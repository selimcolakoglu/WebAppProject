<%@ Control Language="C#" AutoEventWireup="true"  %>

    <main class="main">
        <div class="page-header breadcrumb-wrap">
            <div class="container">
                <div class="breadcrumb">
                    <a href="index.html" rel="nofollow"><i class="fi-rs-home mr-5"></i>Anasayfa</a>
                    <span></span> Alışveriş
                    <span></span> Siparişi Tamamla
                </div>
            </div>
        </div>
<asp:UpdatePanel ID="upCartPage" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div class="container mb-80 mt-50">
            <div class="row">
                <div class="col-lg-8 mb-40">
                    <h1 class="heading-2 mb-10">Siparişi Tamamla</h1>
                    <div class="d-flex justify-content-between">
                        <h6 class="text-body">
                           Siparişiniz gönderildi.
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
                     
                    </div>

                    <div class="divider-2 mb-30"></div>
                    <div class="cart-action d-flex justify-content-between">
                      <%--  <a href="/Products" class="btn">
                            <i class="fi-rs-arrow-left mr-10"></i>Alışverişe Devam Et
                        </a>--%>
                    </div>
                </div>

                <!-- Sağ taraf: Sipariş Özeti -->
<div class="col-lg-4 d-none">
    <div class="border p-md-4 cart-totals ml-30">
        <div class="table-responsive">
            <table class="table no-border">
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

    </div>
</div>


            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

    </main>