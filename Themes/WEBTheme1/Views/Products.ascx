<%@ Control Language="C#" AutoEventWireup="true" %>

<main class="main">
    <div class="page-header breadcrumb-wrap">
        <div class="container">
            <div class="breadcrumb">
                <a href="/" rel="nofollow"><i class="fi-rs-home mr-5"></i>Anasayfa</a>
                <span></span>Ürünler
            </div>
        </div>
    </div>
    <div class="container mb-30 mt-30">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>

                <div class="row">
                    <div class="col-lg-12">
                        <a class="shop-filter-toogle" href="#">
                            <span class="fi-rs-filter mr-5"></span>
                            Filtrele
                        <i class="fi-rs-angle-small-down angle-down"></i>
                            <i class="fi-rs-angle-small-up angle-up"></i>
                        </a>
                        <div class="shop-product-fillter-header" style="display: none;">

                            <div class="row">
                                <!-- KATEGORİ -->
                                <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
                                    <div class="card p-3">
                                        <h5 class="mb-3">Kategori</h5>
                                        <asp:TreeView ID="tvCategories" runat="server"
                                            CssClass="treeview"
                                            ShowCheckBoxes="All"
                                            ExpandDepth="0"
                                            PopulateNodesFromClient="true"
                                            EnableClientScript="true"
                                            CollapseImageUrl="~/Content/icons/minus.png"
                                            ExpandImageUrl="~/Content/icons/plus.png"
                                            NodeWrap="false">
                                        </asp:TreeView>



                                    </div>
                                </div>

                                <!-- MARKA -->
                                <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
                                    <div class="card p-3">
                                        <h5 class="mb-3">Marka</h5>
                                        <asp:TreeView ID="tvBrands" runat="server" CssClass="treeview" ShowLines="false" ShowCheckBoxes="All" />
                                    </div>
                                </div>

                                <!-- FİYAT -->
                                <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
                                    <div class="card p-3">
                                        <h5 class="mb-3">Fiyat Aralığı</h5>
                                        <div class="d-flex flex-column gap-2">
                                            <asp:TextBox ID="txtPriceMin" runat="server" CssClass="form-control" placeholder="Min" />
                                            <asp:TextBox ID="txtPriceMax" runat="server" CssClass="form-control" placeholder="Max" />
                                        </div>
                                    </div>
                                </div>

                                <!-- FİLTRELE BUTONU -->
                                <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
                                      <div class="card p-3 d-flex justify-content-center align-items-center">
      <asp:TextBox ID="txtKeyword" runat="server" CssClass="form-control" placeholder="Ürün adı, kodu" />
  </div>
                                    <div class="card p-3 d-flex justify-content-center align-items-center">
                                        <asp:Button ID="btnApplyFilter" runat="server" Text="Filtrele" CssClass="btn btn-primary w-100" />
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="col-12">
<div class="shop-product-fillter">
    <div class="totall-product">
        <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
    </div>
    <div class="sort-by-product-area">
        <div class="sort-by-cover mr-10">
            <div class="sort-by-product-wrap">
                <div class="sort-by">
                    <span><i class="fi-rs-apps"></i>Gösterilen:</span>
                </div>
                <div class="sort-by-dropdown-wrap">
                    <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-select form-select-sm"
                        >
                        <asp:ListItem Text="12" Value="12" />
                        <asp:ListItem Text="36" Value="36" />
                        <asp:ListItem Text="108" Value="108" />
                        <asp:ListItem Text="216" Value="216" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="sort-by-cover">
            <div class="sort-by-product-wrap">
                <div class="sort-by">
                    <span><i class="fi-rs-apps-sort"></i>Sıralama:</span>
                </div>
                <div class="sort-by-dropdown-wrap">
                    <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-select form-select-sm"
                        >
                        <asp:ListItem Text="İndirimli" Value="discount" />
                        <asp:ListItem Text="Fiyat: Düşükten Yükseğe" Value="price-asc" />
                        <asp:ListItem Text="Fiyat: Yüksekten Düşüğe" Value="price-desc" />
                        <asp:ListItem Text="Adı: A-Z ye" Value="name-asc" />
                        <asp:ListItem Text="Adı: Z-A ya" Value="name-desc" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>
    </div>
</div>

                        <div class="row product-grid">
                            <asp:Repeater ID="rptProducts" runat="server">
    <ItemTemplate>
   <div class="col-lg-2 col-md-4 col-sm-6 col-12">
            <div class="product-cart-wrap mb-30 wow animate__animated animate__fadeIn" data-wow-delay=".1s">
                <div class="product-img-action-wrap">
                    <div class="product-img product-img-zoom">
                        <a href='/ProductDetail?id=<%# Eval("Id") %>'>
                            <img class="default-img" src='<%# Eval("Image1") %>' alt="" />
                            <img class="hover-img" src='<%# Eval("Image2") %>' alt="" />
                        </a>
                    </div>
                    <%# Convert.ToBoolean(Eval("HasDiscount")) 
                        ? "<div class='product-badges product-badges-position product-badges-mrg'><span class='hot'>İndirim</span></div>" 
                        : "" %>
                </div>
                <div class="product-content-wrap">
                    <div class="product-category">
                        <a href='/Products?cid=<%# Eval("CategoryId") %>'><%# Eval("Category") %></a>
                    </div>
                    <h2>
                        <a href='/ProductDetail?id=<%# Eval("Id") %>'><%# Eval("Title") %></a>
                    </h2>
                    <div class="product-rate-cover">
                        <div class="product-rate d-inline-block">
                            <div class="product-rating" style="width: 100%"></div>
                        </div>
                        <span class="font-small ml-5 text-muted"> (5.0)</span>
                    </div>
                    <div>
                        <span class="font-small">Marka: <span class="fw-bold"><%# Eval("Brand") %></span></span><br />
                        <span class="font-small">Ürün Kodu: <span class="fw-bold"><%# Eval("Code") %></span></span><br />
                        <span class="font-small">Ölçü: <span class="fw-bold"><%# Eval("Size") %></span></span><br />
                        <span class="font-small">Ağırlık: <span class="fw-bold"><%# Eval("Weight") %></span></span><br />
                        <span class="font-small"><%# Eval("MainUnitTitle") %> de: 
                            <span class="fw-bold"><%# Eval("PackageCount") %> <%# Eval("SubUnitTitle") %></span>
                        </span>
                    </div>
                                             <div class="product-price mt-10 text-center mb-10 d-none">
  <%# Convert.ToBoolean(Eval("HasDiscount")) 
      ? $"<span>{Eval("Prefix")}{Eval("FinalPrice")} {Eval("Suffix")}</span><span class='old-price'>{Eval("Prefix")}{Eval("Price")} {Eval("Suffix")}</span>" 
      : $"<span>{Eval("Prefix")}{Eval("FinalPrice")} {Eval("Suffix")}</span>" %>
   </div>
                          <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="btn w-100 hover-up"
      CommandName="AddToCart" CommandArgument='<%# Eval("Id") %>'
      UseSubmitBehavior="false">
     <i class="fi-rs-shopping-cart mr-5"></i>Sepete Ekle
  </asp:LinkButton>

                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
                        </div>
                        <!--product grid-->
<div class="pagination-area mt-20 mb-20">
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-start">
            <li class="page-item">
                <asp:LinkButton ID="btnPrev" runat="server" CssClass="page-link">
                    <i class="fi-rs-arrow-small-left"></i>
                </asp:LinkButton>
            </li>

            <asp:Repeater ID="rptPages" runat="server">
                <ItemTemplate>
                    <li runat="server" id="liPageItem" class="page-item">
                        <asp:LinkButton ID="lnkPage" runat="server"
                            Text='<%# Container.DataItem %>'
                            CommandName="Page"
                            CommandArgument='<%# Container.DataItem %>'
                            CssClass="page-link" />
                    </li>
                </ItemTemplate>
            </asp:Repeater>

            <li class="page-item">
                <asp:LinkButton ID="btnNext" runat="server" CssClass="page-link">
                    <i class="fi-rs-arrow-small-right"></i>
                </asp:LinkButton>
            </li>
        </ul>
    </nav>
</div>

                   
                    </div>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</main>

<script>
    function fiterButtonInit() {
        $(".shop-filter-toogle").off("click").on("click", function (e) {
            e.preventDefault();
            $(".shop-product-fillter-header").slideToggle();
            $(this).toggleClass("active");
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        fiterButtonInit();
    });

    // UpdatePanel sonrası tekrar çalıştır
    if (typeof Sys !== "undefined") {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            fiterButtonInit();
        });
    }
</script>