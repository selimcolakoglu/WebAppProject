using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebAppProject.Data;

public partial class Cart : System.Web.UI.Page
{
    private DbEntities db = new DbEntities();
    private Control pageContent;

    private Repeater rptCart;
    private Literal ltrCartItemCount;
    private Literal ltrSubTotal;
    private Literal ltrDiscountTotal;
    private Literal ltrVatTotal;
    private Literal ltrNetTotal;
    private Button btnCheckout;
    private Button btnClearCart;
    private LinkButton btnWhatsappOrder;
    private TextBox txtCompanyName;
    private TextBox txtPhoneNumber;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        pageContent = ThemeHelper.LoadSection(Page, phContent, $"~/Themes/{ThemeHelper.ThemeName}/Views/Cart.ascx");

        rptCart = pageContent.FindControl("rptCart") as Repeater;
        ltrCartItemCount = pageContent.FindControl("ltrCartItemCount") as Literal;
        ltrSubTotal = pageContent.FindControl("ltrSubTotal") as Literal;
        ltrDiscountTotal = pageContent.FindControl("ltrDiscountTotal") as Literal;
        ltrVatTotal = pageContent.FindControl("ltrVatTotal") as Literal;
        ltrNetTotal = pageContent.FindControl("ltrNetTotal") as Literal;
        btnCheckout = pageContent.FindControl("btnCheckout") as Button;
        btnClearCart = pageContent.FindControl("btnClearCart") as Button;
        btnWhatsappOrder = pageContent.FindControl("btnWhatsappOrder") as LinkButton;
        txtCompanyName = pageContent.FindControl("txtCompanyName") as TextBox;
        txtPhoneNumber = pageContent.FindControl("txtPhoneNumber") as TextBox;

        if (btnWhatsappOrder != null)
        {
            btnWhatsappOrder.Click += BtnWhatsappOrder_Click;
        }

        if (rptCart != null)
            rptCart.ItemCommand += rptCart_ItemCommand;

        if (btnClearCart != null)
            btnClearCart.Click += btnClearCart_Click;

        if (btnCheckout != null)
            btnCheckout.Click += btnCheckout_Click;

        if (!Page.IsPostBack && rptCart != null)
            LoadCartPage();
    }

    private void BtnWhatsappOrder_Click(object sender, EventArgs e)
    {
        string companyName = txtCompanyName.Text?.Trim();
        string phoneNumber = txtPhoneNumber.Text?.Trim();

        if (!string.IsNullOrEmpty(companyName))
            Session["CompanyName"] = companyName;

        if (!string.IsNullOrEmpty(phoneNumber))
            Session["PhoneNumber"] = phoneNumber;

        // Gerekli alanların doldurulduğunu kontrol et
        if (string.IsNullOrEmpty(companyName) || string.IsNullOrEmpty(phoneNumber))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "missingInfo",
                "showErrorMessage('Lütfen tüm alanları doldurun.');", true);
            return;
        }

        // Telefon numarası doğrulaması
        if (!IsValidPhoneNumber(phoneNumber))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "invalidPhone",
                "showErrorMessage('Geçersiz telefon numarası.');", true);
            return;
        }

        #region 1. Firma (Business) Kaydı
        var business = new TB_Business
        {
            Title = companyName,
            TaxNr = phoneNumber, // Vergi No'ya telefon numarası yazıldı
            Phone = phoneNumber,
            Email = "whatsapp@order.com",
            CreditLimit = 0,
            Debt = 0,
            AddDate = DateTime.Now,
            PersonalFullName = "WhatsApp Order",
            Active = 1
        };

        db.TB_Business.Add(business);
        db.SaveChanges();
        int businessId = business.Id;
        #endregion

        #region 2. Kullanıcı (User) Kaydı
        var user = new TB_User
        {
            Username = $"user_{businessId}",
            Password = "nopass",
            BusinessId = businessId,
            FullName = "WhatsApp User",
            Permission = 0,
            AddDate = DateTime.Now,
            Active = 1
        };

        db.TB_User.Add(user);
        db.SaveChanges();
        int userId = user.Id;
        #endregion

        #region 3. Sepetten Sipariş Oluşturma
        var summary = CartHelper.GetCartDetails(true);
        var cartItems = summary.Items;
        if (cartItems == null || !cartItems.Any())
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyCart",
                "alert('Sepetiniz boş.');", true);
            return;
        }

        string orderNo = $"ORD-{DateTime.Now:yyyyMMdd}-{new Random().Next(1000, 9999)}";

        var order = new TB_Order
        {
            OrderNo = orderNo,
            BusinessId = businessId,
            UserId = userId,
            SubTotal = summary.SubTotal,
            VatTotal = summary.VatTotal,
            DisTotal = summary.DiscountTotal,
            NetTotal = summary.NetTotal,
            ShippingTotal = 0,
            ShipTrackingNumber = null,
            PayMethod = 0, // Havale
            ShipAddrId = null,
            BillAddrId = null,
            ShipMethodId = 0, // Standart Teslimat
            AddDate = DateTime.Now,
            Status = 1 // Hazırlanıyor
        };

        db.TB_Order.Add(order);
        db.SaveChanges();
        int orderId = order.Id;

        foreach (var item in cartItems)
        {
            var orderDetail = new TB_OrderDetail
            {
                OrderId = orderId,
                ProductId = item.ProductId,
                Qty = item.Qty,
                Price = item.Price,
                DisPrice = item.DisPrice,
                DisRate = item.DisRate,
                Vat = item.VatAmount,
                CurrencyId = item.CurrencyId,
                CurrencyRate = item.CurrencyRate
            };
            db.TB_OrderDetail.Add(orderDetail);
        }

        db.SaveChanges();
        #endregion

        #region 4. WhatsApp'a Yönlendirme
        string message = $"Merhaba {companyName},\nSiparişiniz alınmıştır.\nSipariş No: {orderNo}\nToplam Tutar: {order.NetTotal:C2}";
        string url = $"https://wa.me/{phoneNumber}?text={HttpUtility.UrlEncode(message)}";

        CartHelper.ClearCart(true); // Sepeti temizle

        ScriptManager.RegisterStartupScript(this, this.GetType(), "redirectToWhatsApp", $@"
        window.open('{url}', '_blank');
        setTimeout(function() {{
            window.location.href = '/Checkout';
        }}, 500);", true);
        #endregion
    }

    // Telefon numarasının geçerliliğini kontrol eden metot
    private bool IsValidPhoneNumber(string phoneNumber)
    {
        // Burada telefon numarasının geçerliliğini kontrol etmek için gerekli kuralları uygulayabilirsiniz.
        // Örneğin, sadece rakamlardan oluşup oluşmadığını kontrol edebilirsiniz.
        return phoneNumber.All(char.IsDigit) && phoneNumber.Length >= 10; // Örnek kontrol (en az 10 rakam)
    }


    protected void LoadCartPage()
    {
        var summary = CartHelper.GetCartDetails(true);

        if (summary != null)
        {
            rptCart.DataSource = summary.Items;
            rptCart.DataBind();

            ltrCartItemCount.Text = summary.ItemCount.ToString();
            ltrSubTotal.Text = summary.Prefix + summary.SubTotal.ToString("N2") + summary.Suffix;
            ltrDiscountTotal.Text = summary.Prefix + summary.DiscountTotal.ToString("N2") + summary.Suffix;
            ltrVatTotal.Text = summary.Prefix + summary.VatTotal.ToString("N2") + summary.Suffix;
            ltrNetTotal.Text = summary.Prefix + summary.NetTotal.ToString("N2") + summary.Suffix;
        }
    }


    private void btnCheckout_Click(object sender, EventArgs e)
    {
        int? businessId = Session["BusinessId"] as int?;
        if (businessId == null) return;

        var cartItems = db.TB_Cart.Where(c => c.BusinessId == businessId).ToList();
        if (!cartItems.Any())
        {
            // Sepet boşsa yönlendirme yapılmasın
            ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyCart", "alert('Sepetiniz boş.');", true);
            return;
        }

        // Her şey okey → Checkout sayfasına yönlendir
        Response.Redirect("/Checkout");
    }

    private void btnClearCart_Click(object sender, EventArgs e)
    {
        CartHelper.ClearCart(true);

        LoadCartPage(); // UI'yi yeniden yükle
    }

    protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int productId = Convert.ToInt32(e.CommandArgument);
        string command = e.CommandName;

        string newQtyText = null;
        if (command == "Update")
        {
            TextBox txt = (TextBox)e.Item.FindControl("txtQty");
            if (txt != null)
                newQtyText = txt.Text;
        }

        // Session desteği var: true yaparsan session'dan çalışır
        CartHelper.UpdateCartItem(productId, command, newQtyText, fromSession: true);

        LoadCartPage(); // UI'yi güncelle
    }


    protected void Page_Load(object sender, EventArgs e)
    {

    }
}