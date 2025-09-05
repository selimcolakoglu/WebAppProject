<%@ Control Language="C#" AutoEventWireup="true" %>

    <main class="main">
        <div class="page-header breadcrumb-wrap">
            <div class="container">
                <div class="breadcrumb">
                    <a href="index.html" rel="nofollow"><i class="fi-rs-home mr-5"></i>Anasayfa</a>
                    <span></span> Alışveriş
                    <span></span> Sepetim
                </div>
            </div>
        </div>
<asp:UpdatePanel ID="upCartPage" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div class="container mb-80 mt-50">
            <div class="row">
                <div class="col-lg-8 mb-40">
                    <h1 class="heading-2 mb-10">Sepetim</h1>
                    <div class="d-flex justify-content-between">
                        <h6 class="text-body">
                            Sepetinizde <span class="text-brand">
                                <asp:Literal ID="ltrCartItemCount" runat="server" />
                            </span> kalem ürün var.
                        </h6>
<h6 class="text-body">
<%--    <asp:LinkButton ID="btnClearCart" runat="server" CssClass="text-muted">
        <i class="fi-rs-trash mr-5"></i>Sepeti Boşalt
    </asp:LinkButton>--%>
</h6>

                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Sol taraf ürün listesi -->
                <div class="col-lg-8">
                    <div class="table-responsive shopping-summery">
                        <asp:Repeater ID="rptCart" runat="server">
                            <HeaderTemplate>
                                <table class="table table-wishlist">
                                    <thead>
                                        <tr class="main-heading">
                                            <th class="custome-checkbox start pl-30"></th>
                                            <th scope="col" colspan="2">Ürün</th>
                                            <th class="d-none" scope="col">Birim Fiyat</th>
                                            <th scope="col">Miktar</th>
                                            <th class="d-none" scope="col">Toplam</th>
                                            <th scope="col" class="end">Sil</th>
                                            <th class="pl-30"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="custome-checkbox pl-30"></td>
                                    <td class="image product-thumbnail">
                                        <img src='<%# Eval("ImagePath") %>' alt="#">
                                    </td>
                                    <td class="product-des product-name">
                                        <h6 class="mb-5">
                                            <a class="product-name mb-10 text-heading" href="#">
                                                <%# Eval("ProductTitle") %>
                                            </a>
                                        </h6>
                                        <small class="text-muted">Kategori: <%# Eval("CategoryTitle") %></small>
                                    </td>
                                    <td class="price d-none" data-title="Price">
                                        <h4 class="text-body"><%# Eval("FormattedPrice") %></h4>
                                    </td>
                                    <td class="detail-info" data-title="Stock">
                                        <div class="detail-extralink mr-15">
                                            <div class="detail-qty border radius">
                                                <asp:LinkButton ID="btnDecrease" runat="server" CssClass="qty-down" CommandName="Decrease" CommandArgument='<%# Eval("ProductId") %>'>
                                                    <i class="fi-rs-angle-small-down"></i>
                                                </asp:LinkButton>
                                                <asp:TextBox ID="txtQty" runat="server" CssClass="qty-val" Text='<%# Eval("FormattedQty") %>' data-original='<%# Eval("FormattedQty") %>' AutoPostBack="false" onblur="triggerQtyUpdate(this)" onkeypress="triggerQtyEnter(this, event)" ></asp:TextBox>
                                                    <asp:Button ID="btnTriggerQty" runat="server"
            CommandName="Update"
            CommandArgument='<%# Eval("ProductId") %>'
            style="display:none;" />
                                                <asp:LinkButton ID="btnIncrease" runat="server" CssClass="qty-up" CommandName="Increase" CommandArgument='<%# Eval("ProductId") %>'>
                                                    <i class="fi-rs-angle-small-up"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="price d-none" data-title="Price">
                                        <h4 class="text-brand"><%# Eval("LineTotal") %></h4>
                                    </td>
                                    <td class="action text-center" data-title="Remove">
                                        <asp:LinkButton ID="btnRemove" runat="server" CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>' CssClass="text-body">
                                            <i class="fi-rs-trash"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="divider-2 mb-30"></div>
                    <div class="cart-action d-flex justify-content-between">
                        <a href="/Products" class="btn">
                            <i class="fi-rs-arrow-left mr-10"></i>Alışverişe Devam Et
                        </a>
                    </div>
                </div>

                <!-- Sağ taraf: Sipariş Özeti -->
<div class="col-lg-4">
    <div class="border p-md-4 cart-totals ml-30">
        <div class="table-responsive">
            <table class="table no-border d-none">
                <tbody>
                    <tr>
                        <td class="cart_total_label">
                            <h6 class="text-muted">Ara Toplam</h6>
                        </td>
                        <td class="cart_total_amount">
                            <h4 class="text-brand text-end">
                                <asp:Literal ID="ltrSubTotal" runat="server" />
                            </h4>
                        </td>
                    </tr>
                    <tr>
                        <td class="cart_total_label">
                            <h6 class="text-muted">İndirim</h6>
                        </td>
                        <td class="cart_total_amount">
                            <h4 class="text-brand text-end">
                                <asp:Literal ID="ltrDiscountTotal" runat="server" />
                            </h4>
                        </td>
                    </tr>
                    <tr>
                        <td class="cart_total_label">
                            <h6 class="text-muted">KDV</h6>
                        </td>
                        <td class="cart_total_amount">
                            <h4 class="text-brand text-end">
                                <asp:Literal ID="ltrVatTotal" runat="server" />
                            </h4>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="divider-2 mt-10 mb-10"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="cart_total_label">
                            <h6 class="text-muted">Genel Toplam</h6>
                        </td>
                        <td class="cart_total_amount">
                            <h4 class="text-brand text-end">
                                <asp:Literal ID="ltrNetTotal" runat="server" />
                            </h4>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="form-group mt-3">
            <label for="txtCompanyName">Firma Adı</label>
            <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" />
        </div>
        <div class="form-group mt-2">
            <label for="txtPhoneNumber">Cep Telefonu</label>
            <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" />
        </div>

        <asp:LinkButton ID="btnWhatsappOrder" runat="server" CssClass="btn mb-20 w-100 btn-outline-success">
            Siparişi Whatsapp ile Gönder <i class="fab fa-whatsapp"></i>
        </asp:LinkButton>
    </div>
</div>


            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

    </main>