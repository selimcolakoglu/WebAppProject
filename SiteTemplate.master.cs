using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using WebAppProject.Data;

public partial class SiteTemplate : System.Web.UI.MasterPage
{
    private DbEntities db = new DbEntities();
    private Control header;
    private DropDownList ddlCategories;
    private TextBox txtKeyword;
    private Literal ltrCartCountBadge;
    private UpdatePanel upCart;
    private Literal ltrCartCount;
    private Repeater rptCartItems;
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        ThemeHelper.ThemeName = "B2BTheme1";
        ThemeHelper.ThemeAdminName = "B2BTheme";

        var css = ThemeHelper.LoadSection(Page, phCss, $"~/Themes/{ThemeHelper.ThemeName}/Layout/Css.ascx");
        header = ThemeHelper.LoadSection(Page, phHeader, $"~/Themes/{ThemeHelper.ThemeName}/Layout/Header.ascx");
        var footer = ThemeHelper.LoadSection(Page, phFooter, $"~/Themes/{ThemeHelper.ThemeName}/Layout/Footer.ascx");
        var js = ThemeHelper.LoadSection(Page, phJs, $"~/Themes/{ThemeHelper.ThemeName}/Layout/Js.ascx");

        LoadCategories(header);

        ddlCategories = header.FindControl("ddlCategories") as DropDownList;
        txtKeyword = header.FindControl("txtKeyword") as TextBox;
        ltrCartCountBadge = header.FindControl("ltrCartCountBadge") as Literal;
        ltrCartCount = header.FindControl("ltrCartCount") as Literal;
        upCart = header.FindControl("upCart") as UpdatePanel;
        rptCartItems = header.FindControl("rptCartItems") as Repeater;

        if (!Page.IsPostBack && ddlCategories != null)
            LoadCategoryDropdown(ddlCategories);

        var btnSearchHidden = header.FindControl("btnSearchHidden") as Button;

        if (txtKeyword != null && btnSearchHidden != null)
            txtKeyword.Attributes["data-button"] = btnSearchHidden.ClientID;

        if (btnSearchHidden != null)
            btnSearchHidden.Click += BtnSearchHidden_Click;

        LoadData();
    }

    public void LoadData()
    {
        string count = CartHelper.GetCartItemCount(true).ToString();

        if (ltrCartCountBadge != null)
        {
            ltrCartCountBadge.Text = count;
        }
        if (ltrCartCount != null)
        {
            ltrCartCount.Text = count;   
        }

        if (rptCartItems != null)
        {
            var result = CartHelper.GetCartDetails(true);
            if (result != null)
            {
                rptCartItems.DataSource = result.Items;
                rptCartItems.DataBind();
            }
            
        }

        upCart.Update();
    }

    private void BtnSearchHidden_Click(object sender, EventArgs e)
    {
        int cid = Convert.ToInt32(ddlCategories?.SelectedValue ?? "0");
        string keyword = txtKeyword?.Text.Trim();

        string redirectUrl = "/Products?";
        if (cid > 0) redirectUrl += $"cid={cid}&";
        if (!string.IsNullOrEmpty(keyword)) redirectUrl += $"k={HttpUtility.UrlEncode(keyword)}";

        Response.Redirect(redirectUrl.TrimEnd('&'));
    }


    private void LoadCategories(Control pageContent)
    {
        var rptFirst5 = pageContent.FindControl("rptFirst5") as Repeater;
        var rptSecond5 = pageContent.FindControl("rptSecond5") as Repeater;
        var rptMoreLeft = pageContent.FindControl("rptMoreLeft") as Repeater;
        var rptMoreRight = pageContent.FindControl("rptMoreRight") as Repeater;

        var allCategories = db.TB_Category
                              .Where(c => c.ParentId == 0 && c.Active == 1)
                              .OrderBy(c => c.Title)
                              .ToList();

        var subCategories = db.TB_Category
                              .Where(c => c.ParentId != 0 && c.Active == 1)
                              .ToList();

        var categoryList = allCategories.Select(cat =>
        {
            var subIds = subCategories
                .Where(s => s.ParentId == cat.Id)
                .Select(s => s.Id.ToString())
                .ToList();

            var allIds = new List<string> { cat.Id.ToString() };
            allIds.AddRange(subIds);

            return new
            {
                Id = cat.Id,
                Title = cat.Title,
                IdList = string.Join(",", allIds)
            };
        }).ToList();

        var first10 = categoryList.Take(10).ToList();
        var more = categoryList.Skip(10).ToList();

        if (rptFirst5 != null)
            rptFirst5.DataSource = first10.Take(5);
        if (rptSecond5 != null)
            rptSecond5.DataSource = first10.Skip(5).Take(5);
        if (rptMoreLeft != null)
            rptMoreLeft.DataSource = more.Where((x, i) => i % 2 == 0);
        if (rptMoreRight != null)
            rptMoreRight.DataSource = more.Where((x, i) => i % 2 != 0);

        rptFirst5?.DataBind();
        rptSecond5?.DataBind();
        rptMoreLeft?.DataBind();
        rptMoreRight?.DataBind();
    }


    private void LoadCategoryDropdown(DropDownList ddl)
    {
        ddl.Items.Clear();
        ddl.Items.Add(new ListItem("Tüm Kategoriler", "0"));

        var categories = db.TB_Category
            .Where(c => c.ParentId == 0 && c.Active == 1)
            .OrderBy(c => c.Title)
            .ToList();

        foreach (var cat in categories)
        {
            ddl.Items.Add(new ListItem(cat.Title, cat.Id.ToString()));
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Session["UserId"] = 1;
        Session["BusinessId"] = 1;
    }
}
