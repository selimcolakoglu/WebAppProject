using CLKProject.Common.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using WebAppProject.Data;

public partial class Products : System.Web.UI.Page
{
    private DbEntities db = new DbEntities();
    private Control pageContent;
    // Tüm kontroller sınıf düzeyinde tanımlanır
    private TreeView tvCategories;
    private TreeView tvBrands;
    private TextBox txtMinCost;
    private TextBox txtMaxCost;
    private TextBox txtKeyword;
    private Button btnApplyFilter;
    private Repeater rptProducts;
    private Repeater rptPages;
    private LinkButton btnPrev;
    private LinkButton btnNext;
    private DropDownList ddlPageSize;
    private DropDownList ddlSort;

    public int CurrentPage
    {
        get { return ViewState["Page"] != null ? (int)ViewState["Page"] : 1; }
        set { ViewState["Page"] = value; }
    }

    public int PageCount
    {
        get { return ViewState["PageCount"] != null ? (int)ViewState["PageCount"] : 1; }
        set { ViewState["PageCount"] = value; }
    }

    public int TotalCount
    {
        get { return ViewState["TotalCount"] != null ? (int)ViewState["TotalCount"] : 0; }
        set { ViewState["TotalCount"] = value; }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        pageContent = ThemeHelper.LoadSection(Page, phContent, $"~/Themes/{ThemeHelper.ThemeName}/Views/Products.ascx");

        // Kontrolleri bul ve alanlara ata
        tvCategories = pageContent.FindControl("tvCategories") as TreeView;
        tvBrands = pageContent.FindControl("tvBrands") as TreeView;
        txtMinCost = pageContent.FindControl("txtPriceMin") as TextBox;
        txtMaxCost = pageContent.FindControl("txtPriceMax") as TextBox;
        txtKeyword = pageContent.FindControl("txtKeyword") as TextBox;
        btnApplyFilter = pageContent.FindControl("btnApplyFilter") as Button;
        rptProducts = pageContent.FindControl("rptProducts") as Repeater;
        rptPages = pageContent.FindControl("rptPages") as Repeater;
        btnPrev = pageContent.FindControl("btnPrev") as LinkButton;
        btnNext = pageContent.FindControl("btnNext") as LinkButton;

        ddlPageSize = pageContent.FindControl("ddlPageSize") as DropDownList;
        ddlSort = pageContent.FindControl("ddlSort") as DropDownList;

        if (rptProducts != null)
        {
            rptProducts.ItemCommand += rptProducts_ItemCommand;
        }

        if (ddlPageSize != null)
        {
            ddlPageSize.AutoPostBack = true;
            ddlPageSize.SelectedIndexChanged += DdlPageSize_SelectedIndexChanged;
        }

        if (ddlSort != null)
        {
            ddlSort.AutoPostBack = true;
            ddlSort.SelectedIndexChanged += DdlSort_SelectedIndexChanged;
        }

        if (rptPages != null)
        {
            rptPages.ItemDataBound += RptPages_ItemDataBound;
            rptPages.ItemCommand += RptPages_ItemCommand;
        }


        if (btnApplyFilter != null)
            btnApplyFilter.Click += BtnApplyFilter_Click;

        if (btnPrev != null)
            btnPrev.Click += BtnPrev_Click;

        if (btnNext != null)
            btnNext.Click += BtnNext_Click;



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

    private void RptPages_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Page")
        {
            if (int.TryParse(e.CommandArgument.ToString(), out int page))
            {
                CurrentPage = page;
                LoadProducts();
            }
        }
    }

    private void DdlSort_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Sayfa sıfırla ve ürünleri yükle
        CurrentPage = 1;
        LoadProducts();
    }

    private void DdlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Sayfa sıfırla ve ürünleri yükle
        CurrentPage = 1;
        LoadProducts();
    }

    private void RptPages_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            var pageValue = Convert.ToInt32(e.Item.DataItem);
            var liPageItem = (HtmlGenericControl)e.Item.FindControl("liPageItem");

            if (pageValue == CurrentPage)
            {
                liPageItem.Attributes["class"] = "page-item active";
            }
            else
            {
                liPageItem.Attributes["class"] = "page-item";
            }
        }
    }


    private void BtnNext_Click(object sender, EventArgs e)
    {
        if (CurrentPage < PageCount)
        {
            CurrentPage++;
            LoadProducts();
        }
    }

    private void BtnPrev_Click(object sender, EventArgs e)
    {
        if (CurrentPage > 1)
        {
            CurrentPage--;
            LoadProducts();
        }
    }

    private void TvCategories_SelectedNodeChanged(object sender, EventArgs e)
    {
        var tv = sender as TreeView;
        if (tv?.SelectedNode != null)
        {
            int categoryId = Convert.ToInt32(tv.SelectedNode.Value);
            // kategoriye göre ürün filtrele
        }
    }

    private void TvBrands_SelectedNodeChanged(object sender, EventArgs e)
    {
        var tv = sender as TreeView;
        if (tv?.SelectedNode != null)
        {
            int brandId = Convert.ToInt32(tv.SelectedNode.Value);
            // markaya göre ürün filtrele
        }
    }

    private void BtnApplyFilter_Click(object sender, EventArgs e)
    {
        ApplyFilter();
    }

    private void ApplyFilter()
    {
        // Keyword ve fiyat aralığı
        ViewState["Keyword"] = txtKeyword.Text.Trim();
        ViewState["MinPrice"] = txtMinCost.Text.Trim();
        ViewState["MaxPrice"] = txtMaxCost.Text.Trim();

        // MARKALAR (TreeView ile)
        var selectedBrandIds = new List<string>();
        foreach (TreeNode node in tvBrands.CheckedNodes)
        {
            if (!string.IsNullOrEmpty(node.Value))
                selectedBrandIds.Add(node.Value);
        }
        ViewState["BrandIds"] = selectedBrandIds;

        // KATEGORİLER (TreeView ile)
        var selectedCategoryIds = new List<string>();
        foreach (TreeNode node in tvCategories.CheckedNodes)
        {
            if (!string.IsNullOrEmpty(node.Value))
                selectedCategoryIds.Add(node.Value);
        }
        ViewState["CategoryIds"] = selectedCategoryIds;

        // Sayfa sıfırla ve ürünleri yükle
        CurrentPage = 1;
        LoadProducts();
    }

    private void LoadProducts(string keyword = "")
    {
        keyword = ViewState["Keyword"]?.ToString() ?? "";
        decimal.TryParse(ViewState["MinPrice"]?.ToString(), out decimal minPrice);
        decimal.TryParse(ViewState["MaxPrice"]?.ToString(), out decimal maxPrice);
        minPrice = minPrice == 0 ? 0 : minPrice;
        maxPrice = maxPrice == 0 ? 999999 : maxPrice;

        var categoryIds = ViewState["CategoryIds"] as List<string> ?? new List<string>();
        var brandIds = ViewState["BrandIds"] as List<string> ?? new List<string>();

        int pageSize = 12;
        if (ddlPageSize != null && int.TryParse(ddlPageSize.SelectedValue, out int selectedPageSize))
            pageSize = selectedPageSize;

        int skip = (CurrentPage - 1) * pageSize;

        string sortOption = "discount";
        if (ddlSort != null)
            sortOption = ddlSort.SelectedValue;

        string normalizedKeyword = keyword
            .ToLowerInvariant()
            .Replace("ı", "i")
            .Replace("ğ", "g")
            .Replace("ü", "u")
            .Replace("ş", "s")
            .Replace("ö", "o")
            .Replace("ç", "c");

        var query = (from p in db.TB_Product
                     join b in db.TB_Brand on p.BrandId equals b.Id into brandGroup
                     from b in brandGroup.DefaultIfEmpty()
                     join curr in db.TB_Currency on p.CurrencyId equals curr.Id into currGroup
                     from curr in currGroup.DefaultIfEmpty()
                     join cat in db.TB_Category on p.CategoryId equals cat.Id into catGroup
                     from cat in catGroup.DefaultIfEmpty()
                     join pu in db.TB_ProductUnit on p.Id equals pu.ProductId
                     join mainUnit in db.TB_Unit on pu.UnitId equals mainUnit.Id
                     join subUnit in db.TB_Unit on mainUnit.ParentId equals subUnit.Id
                     where p.Active == 1
                           && pu.MainUnit == 1
                           && (string.IsNullOrEmpty(normalizedKeyword) || p.Title.Contains(normalizedKeyword) || b.Title.Contains(normalizedKeyword) || p.Code.Contains(normalizedKeyword))
                           && (!p.Price.HasValue || (p.Price.Value >= minPrice && p.Price.Value <= maxPrice))
                           && (categoryIds.Count == 0 || categoryIds.Contains(p.CategoryId.ToString()))
                           && (brandIds.Count == 0 || brandIds.Contains(p.BrandId.ToString()))
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
                         Image2 = p.ImagePath ?? "/Themes/WEBTheme1/Content/assets/imgs/shop/product-1-2.jpg",
                         MainUnitTitle = mainUnit.Title,
                         SubUnitTitle = subUnit.Title,
                         PackageCount = pu.UnitAmount ?? 0,
                         Width = p.Width ?? 0,
                         Height = p.Height ?? 0,
                         Weight = p.Weight ?? 0
                     }).ToList()
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
                             FinalPriceDecimal = finalPrice,
                             p.Prefix,
                             p.Suffix,
                             StockText = stockText
                         };
                     });

        // Sıralama
        switch (sortOption)
        {
            case "price-asc":
                query = query.OrderBy(p => p.FinalPriceDecimal);
                break;
            case "price-desc":
                query = query.OrderByDescending(p => p.FinalPriceDecimal);
                break;
            case "name-asc":
                query = query.OrderBy(p => p.Title);
                break;
            case "name-desc":
                query = query.OrderByDescending(p => p.Title);
                break;
            case "discount":
            default:
                query = query.OrderByDescending(p => p.HasDiscount);
                break;
        }

        TotalCount = query.Count();
        PageCount = (int)Math.Ceiling((double)TotalCount / pageSize);

        var pagedProducts = query
            .Skip(skip)
            .Take(pageSize)
            .ToList();

        rptProducts.DataSource = pagedProducts;
        rptProducts.DataBind();

        List<int> pages = Enumerable.Range(1, PageCount).ToList();
        rptPages.DataSource = pages;
        rptPages.DataBind();

        btnPrev.Enabled = CurrentPage > 1;
        btnNext.Enabled = CurrentPage < PageCount;
    }




    private void LoadCategories(TreeView tree)
    {
        var categories = db.TB_Category
            .Where(c => c.Active == 1)
            .ToList();

        var rootCats = categories.Where(c => c.ParentId == 0).ToList();

        foreach (var root in rootCats)
        {
            TreeNode rootNode = new TreeNode(root.Title, root.Id.ToString());
            var children = categories.Where(c => c.ParentId == root.Id).ToList();

            foreach (var child in children)
            {
                TreeNode childNode = new TreeNode(child.Title, child.Id.ToString());
                rootNode.ChildNodes.Add(childNode);
            }

            tree.Nodes.Add(rootNode);
        }

        tree.CollapseAll(); // isteğe göre açabilirsin
    }

    private void LoadBrands(TreeView tree)
    {
        var brands = db.TB_Brand
            .Where(b => b.Active == 1)
            .OrderBy(b => b.Title)
            .ToList();

        foreach (var brand in brands)
        {
            TreeNode brandNode = new TreeNode(brand.Title, brand.Id.ToString());
            tree.Nodes.Add(brandNode);
        }

        tree.CollapseAll();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            CurrentPage = 1;
            string k = Request.QueryString["k"];
            string bid = Request.QueryString["bid"];
            string cid = Request.QueryString["cid"];

            if (!string.IsNullOrEmpty(bid))
            {
                var selectedBrandIds = bid.Split(',').Where(x => !string.IsNullOrWhiteSpace(x)).ToList();
                ViewState["BrandIds"] = selectedBrandIds;
            }

            if (!string.IsNullOrEmpty(cid))
            {
                var selectedCategoryIds = cid.Split(',').Where(x => !string.IsNullOrWhiteSpace(x)).ToList();
                ViewState["CategoryIds"] = selectedCategoryIds;
            }


            if (!string.IsNullOrEmpty(k))
            {
                txtKeyword.Text = k;
                ApplyFilter();
            }
            else
            {
                LoadProducts(); // boş arama yapıldığında tüm ürünleri getir
            }

            if (tvCategories != null)
                LoadCategories(tvCategories);

            if (tvBrands != null)
                LoadBrands(tvBrands);
        }
    }
}