using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebAppProject.Data;
using CLKProject.Common.Extensions;
using ASP;

public partial class _Default : System.Web.UI.Page
{
    private DbEntities db = new DbEntities();
    public Literal ltrAvailableCredit;
    public Literal ltrDebt;
    public Repeater rptProducts;
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        var pageContent = ThemeHelper.LoadSection(Page, phContent, $"~/Themes/{ThemeHelper.ThemeName}/Views/Default.ascx");

        rptProducts = pageContent.FindControl("rptProducts") as Repeater;
        if (rptProducts != null)
        {
            rptProducts.ItemCommand += rptProducts_ItemCommand;
            LoadDiscountedProducts();
        }

        ltrAvailableCredit = pageContent.FindControl("ltrAvailableCredit") as Literal;
        ltrDebt = pageContent.FindControl("ltrDebt") as Literal;

        if (ltrAvailableCredit != null && ltrDebt != null)
        {
            ShowBalanceSummary();
        }
    }

    private void ShowBalanceSummary()
    {
        int? businessId = Session["BusinessId"] as int?;
        if (businessId == null) return;

        var business = db.TB_Business.FirstOrDefault(b => b.Id == businessId && b.Active == 1);
        if (business == null) return;

        decimal creditLimit = business.CreditLimit ?? 0;
        decimal debt = business.Debt ?? 0;
        decimal available = creditLimit - debt;

        ltrAvailableCredit.Text = available.ToString("N2") + " TL";
        ltrDebt.Text = debt.ToString("N2") + " TL";
    }

    protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "AddToCart")
        {
            int productId = Convert.ToInt32(e.CommandArgument);
            int quantity = 1; // Şimdilik sabit, sonra inputla alabiliriz

            int? userId = Session["UserId"] as int?;
            int? businessId = Session["BusinessId"] as int?;

            bool success = CartHelper.AddToCart(productId, quantity, true);

            if (success)
            {
                var master = this.Master as SiteTemplate;
                master?.LoadData();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "cartSuccess", "showCartSuccess();", true);
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void LoadDiscountedProducts()
    {
        if (rptProducts == null) return;

        var products = (from p in db.TB_Product
                        join b in db.TB_Brand on p.BrandId equals b.Id into brandGroup
                        from b in brandGroup.DefaultIfEmpty()

                        join curr in db.TB_Currency on p.CurrencyId equals curr.Id into currGroup
                        from curr in currGroup.DefaultIfEmpty()

                        join pu in db.TB_ProductUnit on p.Id equals pu.ProductId
                        join mainUnit in db.TB_Unit on pu.UnitId equals mainUnit.Id
                        join subUnit in db.TB_Unit on mainUnit.ParentId equals subUnit.Id

                        join cat in db.TB_Category on p.CategoryId equals cat.Id into catGroup
                        from cat in catGroup.DefaultIfEmpty()

                        where p.Active == 1 && pu.MainUnit == 1 && (p.DisPrice > 0 || p.DisRate > 0)
                        orderby p.Id descending
                        select new
                        {
                            p.Id,
                            p.Title,
                            p.Code,
                            Brand = b != null ? b.Title : "",
                            Category = cat != null ? cat.Title : "",
                            CategoryId = p.CategoryId,
                            Price = p.Price ?? 0,
                            DisPrice = p.DisPrice ?? 0,
                            DisRate = p.DisRate ?? 0,
                            Stock = p.Stock ?? 0,
                            Prefix = curr.Prefix ?? "",
                            Suffix = curr.Suffix ?? "",
                            Image1 = p.ImagePath ?? "/Themes/WEBTheme1/Content/assets/imgs/shop/product-1-1.jpg",
                            Image2 = p.ImagePath ?? "/Themes/WEBTheme1/Content/assets/imgs/shop/product-1-2.jpg", // alternatif görsel
                            Width = p.Width ?? 0,
                            Height = p.Height ?? 0,
                            Weight = p.Weight ?? 0,
                            MainUnitTitle = mainUnit.Title,
                            SubUnitTitle = subUnit.Title,
                            PackageCount = pu.UnitAmount ?? 0
                        }).Take(12).ToList()
                        .Select(p =>
                        {
                            decimal finalPrice = p.Price;
                            if (p.DisRate > 0)
                                finalPrice -= finalPrice * (p.DisRate / 100);
                            else if (p.DisPrice > 0)
                                finalPrice -= p.DisPrice;

                            string final = finalPrice.ToString("N2");
                            string original = p.Price.ToString("N2");

                            string stockText = (p.Stock % 1 == 0)
                                ? Convert.ToInt32(p.Stock).ToString()
                                : p.Stock.ToString("N1");

                            return new
                            {
                                p.Id,
                                p.Title,
                                p.Code,
                                p.Brand,
                                p.Category,
                                p.CategoryId,
                                p.Image1,
                                p.Image2,
                                Size = $"{p.Width.ToStringZero()} cm x {p.Height.ToStringZero()} cm",
                                Weight = $"{p.Weight.ToStringZero()} Kg",
                                p.MainUnitTitle,
                                p.SubUnitTitle,
                                PackageCount = p.PackageCount,
                                HasDiscount = finalPrice < p.Price,
                                Price = original,
                                FinalPrice = final,
                                p.Prefix,
                                p.Suffix,
                                StockText = stockText
                            };
                        }).ToList();

        rptProducts.DataSource = products;
        rptProducts.DataBind();
    }

}