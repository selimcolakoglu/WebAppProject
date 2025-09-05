<%@ Control Language="C#" AutoEventWireup="true" %>
<%string contentPath = "/Themes/B2BTheme1/Content";  %>
            <footer class="footer" id="page_footer">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-6">
                            <script>document.write(new Date().getFullYear())</script>
                            © Powered By <a href="https://www.ftdijital.com" target="_blank">FT Dijital Bilişim Danışmanlık Ltd. Şti.</a>
                                         <asp:PlaceHolder ID="phHeader" runat="server" />
                        </div>
                        <div class="col-sm-6">
                            <div class="text-sm-end d-none d-sm-block">
                                Tüm Hakları Saklıdır.
                            </div>
                        </div>
                    </div>
                </div>
            </footer>

        <!-- END layout-wrapper -->

        <div id="loadingOverlay" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;
    background:rgba(255,255,255,0.7);z-index:9999;text-align:center;padding-top:20%">
    <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Yükleniyor...</span>
    </div>
</div>

        <!--start back-to-top-->
        <button onclick="topFunction()" class="btn btn-danger btn-icon" id="back-to-top">
            <i class="ri-arrow-up-line"></i>
        </button>
        <!--end back-to-top-->