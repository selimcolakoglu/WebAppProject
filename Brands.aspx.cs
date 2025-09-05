using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebAppProject.Data;

public partial class Brands : System.Web.UI.Page
{
    private DbEntities db = new DbEntities();
    private Control pageContent;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        pageContent = ThemeHelper.LoadSection(Page, phContent, $"~/Themes/{ThemeHelper.ThemeName}/Views/Brands.ascx");

        LoadBrands(pageContent);
    }
    private void LoadBrands(Control content)
    {
        var rptBrands = content.FindControl("rptBrands") as Repeater;

        if (rptBrands == null) return;

        var brands = (from b in db.TB_Brand
                      where b.Active == 1
                      orderby b.Title
                      select new
                      {
                          b.Id,
                          b.Title,
                          Img = string.IsNullOrEmpty(b.Img)
                              ? "/Themes/WEBTheme1/Content/assets/imgs/vendor/vendor-3.png"
                              : b.Img,
                          ProductCount = db.TB_Product.Count(p => p.BrandId == b.Id && p.Active == 1)
                      }).ToList();

        rptBrands.DataSource = brands;
        rptBrands.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}