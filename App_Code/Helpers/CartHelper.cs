using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAppProject.Data;

/// <summary>
/// Summary description for CartHelper
/// </summary>
public class CartHelper
{
    public static bool AddToCart(int productId, int quantity, bool saveToSession = false)
    {
        int? userId = HttpContext.Current.Session["UserId"] as int?;
        int? businessId = HttpContext.Current.Session["BusinessId"] as int?;

        if (businessId == null)
            return false;

        var product = DbHelper.db.TB_Product.FirstOrDefault(p => p.Id == productId && p.Active == 1);
        if (product == null)
            return false;

        // Döviz kuru
        decimal? currencyRate = 1;
        if (product.CurrencyId != null)
        {
            var currency = DbHelper.db.TB_Currency.FirstOrDefault(c => c.Id == product.CurrencyId);
            if (currency != null && currency.Rate.HasValue)
                currencyRate = currency.Rate;
        }

        if (saveToSession)
        {
            var cartList = HttpContext.Current.Session["Cart"] as List<TB_Cart> ?? new List<TB_Cart>();

            var existing = cartList.FirstOrDefault(c => c.ProductId == productId);
            if (existing != null)
            {
                existing.Qty += quantity;
                existing.AddDate = DateTime.Now;
            }
            else
            {
                var newItem = new TB_Cart
                {
                    BusinessId = businessId,
                    UserId = userId,
                    ProductId = product.Id,
                    Qty = quantity,
                    Price = product.Price,
                    DisPrice = product.DisPrice,
                    DisRate = product.DisRate,
                    Vat = product.Vat,
                    CurrencyId = product.CurrencyId,
                    CurrencyRate = currencyRate,
                    AddDate = DateTime.Now
                };
                cartList.Add(newItem);
            }

            HttpContext.Current.Session["Cart"] = cartList;
            return true;
        }
        else
        {
            var existingCart = DbHelper.db.TB_Cart.FirstOrDefault(c => c.BusinessId == businessId && c.ProductId == productId);

            if (existingCart != null)
            {
                existingCart.Qty += quantity;
                existingCart.AddDate = DateTime.Now;
            }
            else
            {
                var cartItem = new TB_Cart
                {
                    BusinessId = businessId,
                    UserId = userId,
                    ProductId = product.Id,
                    Qty = quantity,
                    Price = product.Price,
                    DisPrice = product.DisPrice,
                    DisRate = product.DisRate,
                    Vat = product.Vat,
                    CurrencyId = product.CurrencyId,
                    CurrencyRate = currencyRate,
                    AddDate = DateTime.Now
                };

                DbHelper.db.TB_Cart.Add(cartItem);
            }

            DbHelper.db.SaveChanges();
            return true;
        }
    }

    public static int GetCartItemCount(bool fromSession = false)
    {
        int? userId = HttpContext.Current.Session["UserId"] as int?;
        int? businessId = HttpContext.Current.Session["BusinessId"] as int?;

        if (businessId == null)
            return 0;

        if (fromSession)
        {
            var cartList = HttpContext.Current.Session["Cart"] as List<TB_Cart>;
            return cartList?.Count ?? 0;
        }
        else
        {
            return DbHelper.db.TB_Cart.Count(c => c.BusinessId == businessId && c.UserId == userId);
        }
    }

    public static CartItemSummary GetCartDetails(bool fromSession = false)
    {
        int? businessId = HttpContext.Current.Session["BusinessId"] as int?;
        if (businessId == null) return null;

        var db = DbHelper.db;
        var defaultCurrency = db.TB_Currency.FirstOrDefault(c => c.DefCurr == 1);
        string prefix = defaultCurrency?.Prefix ?? "";
        string suffix = defaultCurrency?.Suffix ?? "";

        List<TB_Cart> cartList;
        if (fromSession)
        {
            cartList = HttpContext.Current.Session["Cart"] as List<TB_Cart> ?? new List<TB_Cart>();
        }
        else
        {
            cartList = db.TB_Cart.Where(c => c.BusinessId == businessId).ToList();
        }

        var rawCart = (from c in cartList
                       join p in db.TB_Product on c.ProductId equals p.Id
                       join cat in db.TB_Category on p.CategoryId equals cat.Id
                       join cur in db.TB_Currency on c.CurrencyId equals cur.Id into currencyGroup
                       from cur in currencyGroup.DefaultIfEmpty()
                       select new
                       {
                           c.ProductId,
                           p.ImagePath,
                           ProductTitle = p.Title,
                           CategoryTitle = cat.Title,
                           p.Code,
                           Qty = c.Qty ?? 1,
                           Price = c.Price ?? 0,
                           DisPrice = c.DisPrice ?? 0,
                           DisRate = c.DisRate ?? 0,
                           Vat = c.Vat ?? 0,
                           CurrencyId = c.CurrencyId,
                           CurrencyRate = c.CurrencyRate ?? 1,
                           CurrencyPrefix = cur.Prefix ?? "",
                           CurrencySuffix = cur.Suffix ?? ""
                       }).ToList();

        var cartItems = rawCart.Select(x =>
        {
            var qty = x.Qty;
            var originalPrice = x.Price;
            var unitPrice = originalPrice;

            if (x.DisRate > 0)
                unitPrice -= (unitPrice * x.DisRate / 100);
            if (x.DisPrice > 0)
                unitPrice -= x.DisPrice;

            var lineBrut = originalPrice * qty;
            var discountAmount = (originalPrice - unitPrice) * qty;
            var netLine = unitPrice * qty;
            var vatAmount = (unitPrice * x.Vat / 100) * qty;

            return new CartItemDetail
            {
                ProductId = x.ProductId ?? 0,
                ProductTitle = x.ProductTitle,
                CategoryTitle = x.CategoryTitle,
                ProductCode = x.Code,
                Qty = qty,
                FormattedQty = qty % 1 == 0 ? ((int)qty).ToString() : qty.ToString("N2"),
                ImagePath = x.ImagePath,
                Price = x.Price,
                Vat = x.Vat,
                DisRate = x.DisRate,
                DisPrice = x.DisPrice,
                CurrencyRate = x.CurrencyRate,
                BrutLineTotal = lineBrut * x.CurrencyRate,
                DiscountAmount = discountAmount * x.CurrencyRate,
                VatAmount = vatAmount * x.CurrencyRate,
                NetLineTotal = netLine * x.CurrencyRate + vatAmount * x.CurrencyRate,
                FormattedPrice = x.CurrencyPrefix + x.Price.ToString("N2") + x.CurrencySuffix,
                LineTotal = x.CurrencyPrefix + netLine.ToString("N2") + x.CurrencySuffix,

                // ✅ CurrencyId burada eklendi
                CurrencyId = x.CurrencyId
            };
        }).ToList();

        if (cartItems == null)
        {
            cartItems = new List<CartItemDetail>();
        }

        return new CartItemSummary
        {
            Items = cartItems,
            ItemCount = cartItems.Count,
            SubTotal = cartItems.Sum(x => x.BrutLineTotal),
            DiscountTotal = cartItems.Sum(x => x.DiscountAmount),
            VatTotal = cartItems.Sum(x => x.VatAmount),
            NetTotal = cartItems.Sum(x => x.NetLineTotal),
            Prefix = prefix,
            Suffix = suffix
        };
    }

    public static void UpdateCartItem(int productId, string command, string newQtyText = null, bool fromSession = false)
    {
        int? businessId = HttpContext.Current.Session["BusinessId"] as int?;
        if (businessId == null) return;

        var db = DbHelper.db;
        List<TB_Cart> cartList = fromSession
            ? (HttpContext.Current.Session["Cart"] as List<TB_Cart>) ?? new List<TB_Cart>()
            : db.TB_Cart.Where(c => c.BusinessId == businessId).ToList();

        var cartItem = cartList.FirstOrDefault(c => c.ProductId == productId);
        if (cartItem == null) return;

        switch (command)
        {
            case "Increase":
                cartItem.Qty += 1;
                break;

            case "Decrease":
                if (cartItem.Qty > 1)
                    cartItem.Qty -= 1;
                break;

            case "Remove":
                cartList.Remove(cartItem);
                break;

            case "Update":
                if (!string.IsNullOrEmpty(newQtyText) &&
                    decimal.TryParse(newQtyText.Replace(",", "."), out decimal newQty) &&
                    newQty > 0)
                {
                    cartItem.Qty = newQty;
                }
                break;
        }

        if (fromSession)
        {
            HttpContext.Current.Session["Cart"] = cartList;
        }
        else
        {
            if (command == "Remove")
                db.TB_Cart.Remove(cartItem);

            db.SaveChanges();
        }
    }

    public static void ClearCart(bool fromSession = false)
    {
        int? businessId = HttpContext.Current.Session["BusinessId"] as int?;
        if (businessId == null) return;

        if (fromSession)
        {
            HttpContext.Current.Session["Cart"] = new List<TB_Cart>();
        }
        else
        {
            var db = DbHelper.db;
            var carts = db.TB_Cart.Where(c => c.BusinessId == businessId).ToList();
            db.TB_Cart.RemoveRange(carts);
            db.SaveChanges();
        }
    }

}

public class CartItemSummary
{
    public List<CartItemDetail> Items { get; set; }
    public int ItemCount { get; set; }
    public decimal SubTotal { get; set; }
    public decimal DiscountTotal { get; set; }
    public decimal VatTotal { get; set; }
    public decimal NetTotal { get; set; }
    public string Prefix { get; set; }
    public string Suffix { get; set; }
}

public class CartItemDetail
{
    public int ProductId { get; set; }
    public string ProductTitle { get; set; }
    public string CategoryTitle { get; set; }
    public string ProductCode { get; set; }
    public decimal Qty { get; set; }
    public string FormattedQty { get; set; }
    public string ImagePath { get; set; }

    public decimal Price { get; set; }
    public decimal Vat { get; set; }
    public decimal DisRate { get; set; }
    public decimal DisPrice { get; set; }
    public decimal CurrencyRate { get; set; }

    public decimal BrutLineTotal { get; set; }
    public decimal DiscountAmount { get; set; }
    public decimal VatAmount { get; set; }
    public decimal NetLineTotal { get; set; }

    public string FormattedPrice { get; set; }
    public string LineTotal { get; set; }
    public int? CurrencyId { get; set; }
}