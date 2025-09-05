<%@ Control Language="C#" AutoEventWireup="true" %>

    <main class="main">
        <section class="home-slider position-relative mb-30">
            <div class="container">
                <div class="row">
                    <div class="col-lg-9">
                        <div class="home-slide-cover mt-30">
                            <div class="hero-slider-1 style-5 dot-style-1 dot-style-1-position-2">
                                <div class="single-hero-slider single-animation-wrap" style="background-image: url(/Themes/WEBTheme1/Content/assets/imgs/slider/slider-7.png)">
                                    <div class="slider-content">
                                        <h1 class="display-2 mb-40">
                                            Yeni Sezon Ürünleri<br />
                                            Stokta!
                                        </h1>
                                        <p class="mb-65">İşlevsel tasarımlara sahip yeni plastik ürünler<br> raflarda yerini aldı. İlk sen al, farkı yaşa.</p>
                                    </div>
                                </div>
                                <div class="single-hero-slider single-animation-wrap" style="background-image: url(/Themes/WEBTheme1/Content/assets/imgs/slider/slider-8.png)">
<div class="slider-content">
    <h1 class="display-2 mb-40">
        Hijyenin Vazgeçilmezleri<br />
        Burada
    </h1>
    <p class="mb-65">Dayanıklı ve kullanışlı temizlik<br /> ürünleriyle her alan tertemiz, her iş kolay.</p>
</div>

                                </div>
                            </div>
                            <div class="slider-arrow hero-slider-1-arrow"></div>
                        </div>
                    </div>
                    <div class="col-lg-3">
               <div class="row">
    <div class="col-md-6 col-lg-12">
        <div class="banner-img style-4 mt-30">
            <img src="/Themes/WEBTheme1/Content/assets/imgs/banner/banner-14.png" alt="" />
            <div class="banner-text">
                <h4 class="mb-30 text-white">
                    Her Gün Temizlik<br />
                    İçin İdeal Ürünler
                </h4>
                <a href="/Products?cid=temizlik" class="btn btn-xs mb-50">Ürünleri Gör <i class="fi-rs-arrow-small-right"></i></a>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-lg-12">
        <div class="banner-img style-5 mt-5 mt-md-30">
            <img src="/Themes/WEBTheme1/Content/assets/imgs/banner/banner-15.png" alt="" />
            <div class="banner-text">
                <h5 class="mb-20 text-white">
                    Pratik Saklama<br />Çözümleri<br />
                    Her Eve Gerekli
                </h5>
                <a href="/Products?cid=saklama" class="btn btn-xs">Keşfet <i class="fi-rs-arrow-small-right"></i></a>
            </div>
        </div>
    </div>
</div>

                    </div>
                </div>
            </div>
        </section>
        <!--End hero slider-->
        <section class="product-tabs section-padding position-relative">
            <div class="container">
                <div class="section-title style-2 wow animate__animated animate__fadeIn">
                    <h3>İndirimdeki Ürünler</h3>

                </div>
                <!--End nav-tabs-->
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="tab-one" role="tabpanel" aria-labelledby="tab-one">
                       
                            <asp:UpdatePanel ID="upDiscountProduct" runat="server">
                                <ContentTemplate>
 <div class="row">
                             
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
    </ContentTemplate>
</asp:UpdatePanel>
                            <!--end product card-->
                     
                        <!--End product-grid-4-->
                    </div>
                </div>
                <!--End tab-content-->
            </div>
        </section>
        <!--Products Tabs-->
        <section class="section-padding">
            <div class="container">
     <div class="row">
    <div class="col-lg-3 col-md-6">
        <div class="banner-img style-6 wow animate__animated animate__fadeInUp" data-wow-delay="0">
            <img src="/Themes/WEBTheme1/Content/assets/imgs/banner/banner-16.png" alt="" />
            <div class="banner-text">
                <h6 class="mb-10 mt-30">Her Alana Uygun<br />Temizlik Kovaları</h6>
                <p>Ürünleri Gör</p>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="banner-img style-6 wow animate__animated animate__fadeInUp" data-wow-delay="0.2s">
            <img src="/Themes/WEBTheme1/Content/assets/imgs/banner/banner-17.png" alt="" />
            <div class="banner-text">
                <h6 class="mb-10 mt-30">Gıda Dostu<br />Saklama Kapları</h6>
                <p>Detaylı İncele</p>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="banner-img style-6 wow animate__animated animate__fadeInUp" data-wow-delay="0.4s">
            <img src="/Themes/WEBTheme1/Content/assets/imgs/banner/banner-18.png" alt="" />
            <div class="banner-text">
                <h6 class="mb-10 mt-30">Renkli ve Dayanıklı<br />Çamaşır Sepetleri</h6>
                <p>Hemen Bak</p>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="banner-img style-6 wow animate__animated animate__fadeInUp" data-wow-delay="0.6s">
            <img src="/Themes/WEBTheme1/Content/assets/imgs/banner/banner-19.png" alt="" />
            <div class="banner-text">
                <h6 class="mb-10 mt-30">Endüstriyel Kullanıma<br />Uygun Kilitli Kutular</h6>
                <p>Ürünleri Keşfet</p>
            </div>
        </div>
    </div>
</div>

            </div>
        </section>
        <!--End 4 banners-->

    </main>
    