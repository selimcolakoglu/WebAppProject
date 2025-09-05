using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebAppProject.Data;

public partial class About : System.Web.UI.Page
{
    private DbEntities db = new DbEntities();
    private Control pageContent;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        pageContent = ThemeHelper.LoadSection(Page, phContent, $"~/Themes/{ThemeHelper.ThemeName}/Views/About.ascx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}