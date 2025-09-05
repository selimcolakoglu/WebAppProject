using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    private Control pageContent;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        pageContent = ThemeHelper.LoadSection(Page, phContent, $"~/Admin/Themes/{ThemeHelper.ThemeAdminName}/Views/Default.ascx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}