<%@ Control Language="C#" AutoEventWireup="true"  %>
<%string contentPath = "/Themes/B2BTheme1/Content";  %>

    <div class="main-content">

        <div class="page-content">
            <div class="container-fluid">


                <div class="row">

                    <div class="col-xxl-12">
                        <div class="row h-100">
                            <div class="col-xl-3">
                                <div class="card card-height-100">
                                    <div class="card-header align-items-center d-flex">
                                        <h4 class="card-title mb-0 flex-grow-1">Cari Hesap</h4>
                                        <div class="flex-shrink-0">
                                            <button type="button" class="btn btn-soft-primary btn-sm d-none">
                                                Hesap Detayları
                                            </button>
                                        </div>
                                    </div>
                                    <!-- end card header -->

                                    <!-- card body -->
                                    <div class="card-body">
                                        <div class="col-12">
                                            <h3 class="text-success text-uppercase fw-semibold text-truncate mb-3">Kalan Limit</h3>
                                            <h4 class="mb-0">
                                                <asp:Literal ID="ltrAvailableCredit" runat="server" />
                                            </h4>
                                        </div>
                                        <br />
                                        <div class="col-12">
                                            <h3 class="text-danger text-uppercase fw-semibold text-truncate mb-3">Borç</h3>
                                            <h4 class="mb-0">
                                                <asp:Literal ID="ltrDebt" runat="server" />
                                            </h4>
                                        </div>
                                        <br />
                                        <div class="col-12">
                                            <div class="d-flex flex-wrap gap-2">
                                                <a href="/Pay" class="btn btn-primary">Ödeme Yap</a>
                                                <a href="/Payments" class="btn btn-outline-primary">Ödemeler</a>
                                            </div>
                                        </div>
                                        <!-- end col -->

                                    </div>
                                    <!-- end card body -->
                                </div>
                                <!-- end card -->
                            </div>
                            <!-- end col -->

                            <div class="col-xl-9">
                                <div class="card">
                                    <div class="card-header align-items-center d-flex">
                                        <h4 class="card-title mb-0 flex-grow-1">Kampanyalar</h4>
                                    </div>
                                    <!-- end card header -->
                                    <div class="card-body">
                                        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                                            <div class="carousel-inner" role="listbox">
                                                <div class="carousel-item active">
                                                    <img class="d-block img-fluid mx-auto" src="<%:contentPath %>/assets/images/small/kampanya-1.jpg" alt="First slide">
                                                </div>
                                                <div class="carousel-item">
                                                    <img class="d-block img-fluid mx-auto" src="<%:contentPath %>/assets/images/small/kampanya-2.jpg" alt="Second slide">
                                                </div>
                                                <div class="carousel-item">
                                                    <img class="d-block img-fluid mx-auto" src="<%:contentPath %>/assets/images/small/kampanya-3.jpg" alt="Third slide">
                                                </div>
                                            </div>
                                            <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-bs-slide="prev">
                                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                            <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-bs-slide="next">
                                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </div>

                                    </div>
                                    <!-- end card-body -->
                                </div>
                                <!-- end card -->
                            </div>
                            <!-- end col-->

                        </div>
                        <!-- end row-->
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row-->

                <div class="row">
                    <div class="col-xl-6">
                        <asp:UpdatePanel ID="upProducts" runat="server">
    <ContentTemplate>
                        <div class="card">
                            <div class="card-header align-items-center d-flex">
                                <h4 class="card-title mb-0 flex-grow-1">İndirimdeki Ürünler</h4>
                            </div>
                            <!-- end card header -->

                            <div class="card-body">
                                <div class="table-responsive table-card">
                                    <table class="table table-borderless table-centered align-middle table-nowrap mb-0">
                                        <thead class="text-muted table-light">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Ürün</th>
                                                <th scope="col">Kodu</th>
                                                <th scope="col">Marka</th>
                                                <th scope="col">Fiyat</th>
                                                <th scope="col">Stok</th>
                                                <th scope="col">İşlem</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <asp:Repeater ID="rptProducts" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <a href='ProductDetail.aspx?id=<%# Eval("Id") %>' class="fw-medium link-primary">
                                                                <div class="avatar-sm bg-light rounded p-1">
                                                                    <img src="/" alt="" class="img-fluid d-block" />
                                                                </div>
                                                            </a>
                                                        </td>

                                                        <td><%# Eval("Title") %></td>
                                                        <td><%# Eval("Code") %></td>
                                                        <td><%# Eval("Brand") %></td>

                                                        <td>
                                                            <%# Convert.ToBoolean(Eval("HasDiscount")) 
        ? $"<span class='text-danger text-decoration-line-through'>{Eval("Prefix")}{Eval("Price")} {Eval("Suffix")}</span><br /><span class='text-success'>{Eval("Prefix")}{Eval("FinalPrice")} {Eval("Suffix")}</span>" 
        : $"<span class='text-success'>{Eval("Prefix")}{Eval("FinalPrice")} {Eval("Suffix")}</span>" %>
                                                        </td>


                                                        <td><%# Eval("StockText") %></td>

                                                        <td>
                                                            <asp:LinkButton ID="btnAddToCart" runat="server"
                                                                CssClass="btn btn-success btn-icon waves-effect waves-light"
                                                                CommandName="AddToCart"
                                                                UseSubmitBehavior="false"
                                                                CommandArgument='<%# Eval("Id") %>' ToolTip="Sepete Ekle">
                    <i class="ri-shopping-cart-line" style="pointer-events: none;"></i>
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>


                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                        <!-- .card-->
            </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="rptProducts" EventName="ItemCommand" />
    </Triggers>
</asp:UpdatePanel>
                    </div>
                    <!-- .col-->


                    <div class="col-xl-6">
                        <div class="card">
                            <div class="card-header align-items-center d-flex">
                                <h4 class="card-title mb-0 flex-grow-1">Favoriye Eklenen Ürünler</h4>
                            </div>
                            <!-- end card header -->

                            <div class="card-body">
                                <div class="table-responsive table-card">
                                    <table class="table table-borderless table-centered align-middle table-nowrap mb-0">
                                        <thead class="text-muted table-light">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Ürün</th>
                                                <th scope="col">Kodu</th>
                                                <th scope="col">Marka</th>
                                                <th scope="col">Fiyat</th>
                                                <th scope="col">Stok</th>
                                                <th scope="col">İşlem</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                        <!-- end tbody -->
                                    </table>
                                    <!-- end table -->
                                    <div class="col-12 align-items-center d-flex" style="padding: 20px;">
                                        Favoriye eklenmiş ürün yok.
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- .card-->
                    </div>
                    <!-- .col-->
                    <!-- end col -->
                </div>
                <!-- end row -->


            </div>
            <!-- container-fluid -->
        </div>
        <!-- End Page-content -->


    </div>