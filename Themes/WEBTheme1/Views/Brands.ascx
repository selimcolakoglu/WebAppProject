<%@ Control Language="C#" AutoEventWireup="true" %>

    <main class="main pages mb-80">
        <div class="page-header breadcrumb-wrap">
            <div class="container">
                <div class="breadcrumb">
                    <a href="/" rel="nofollow"><i class="fi-rs-home mr-5"></i>Anasayfa</a>
                    <span></span> Markalar
                </div>
            </div>
        </div>
        <div class="page-content pt-50">
            <div class="container">

                <div class="row vendor-grid">
                   
                    <asp:Repeater ID="rptBrands" runat="server">
    <ItemTemplate>
        <div class="col-lg-3 col-md-6 col-12 col-sm-6">
            <div class="vendor-wrap mb-40">
                <div class="vendor-img-action-wrap">
                    <div class="vendor-img">
                        <a href='/Products?bid=<%# Eval("Id") %>'>
                            <img class="default-img" src='<%# Eval("Img") %>' alt="" />
                        </a>
                    </div>
                </div>
                <div class="vendor-content-wrap">
                    <div class="d-flex justify-content-between align-items-end mb-30">
                        <div>
                            <h4 class="mb-5">
                                <a href='/Products?bid=<%# Eval("Id") %>'><%# Eval("Title") %></a>
                            </h4>
                            <div class="product-rate-cover">
                                <div class="product-rate d-inline-block">
                                    <div class="product-rating" style="width: 100%"></div>
                                </div>
                                <span class="font-small ml-5 text-muted"> (5.0)</span>
                            </div>
                        </div>
                        <div class="mb-10">
                            <span class="font-small total-product"><%# Eval("ProductCount") %> Ürün</span>
                        </div>
                    </div>
                    <a href='/Products?bid=<%# Eval("Id") %>' class="btn btn-xs">
                        Ürünler <i class="fi-rs-arrow-small-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>


                </div>
            </div>
        </div>
    </main>
    