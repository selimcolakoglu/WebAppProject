<%@ Control Language="C#" AutoEventWireup="true" %>
<%string contentPath = "/Themes/B2BTheme1/Content";  %>

            <header id="page_topbar">
                <div class="layout-width">
                    <div class="navbar-header">
                        <div class="d-flex">
                            <!-- LOGO -->
                            <div class="navbar-brand-box horizontal-logo">
                                <a href="/" class="logo logo-dark">
                                    <span class="logo-sm">
                                        <img src="<%:contentPath %>/assets/images/logo-sm.png" alt="" height="22">
                                    </span>
                                    <span class="logo-lg">
                                        <img src="<%:contentPath %>/assets/images/tpc_logo.png" alt="" height="50">
                                    </span>
                                </a>

                                <a href="/" class="logo logo-light">
                                    <span class="logo-sm">
                                        <img src="<%:contentPath %>/assets/images/logo-sm.png" alt="" height="22">
                                    </span>
                                    <span class="logo-lg">
                                        <img src="<%:contentPath %>/assets/images/logo-light.png" alt="" height="17">
                                    </span>
                                </a>
                            </div>

                            <button type="button" class="btn btn-sm px-3 fs-16 header-item vertical-menu-btn topnav-hamburger" id="topnav-hamburger-icon">
                                <span class="hamburger-icon">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </span>
                            </button>

                           <!-- App Search -->
<div class="app-search d-none d-md-block">
    <div class="position-relative">
        <asp:TextBox ID="txtGlobalSearch" runat="server" CssClass="form-control" placeholder="Ürün Ara..." autocomplete="off"
            onkeydown="if (event.key === 'Enter') { event.preventDefault(); goToSearch(); }" />
        <span class="mdi mdi-magnify search-widget-icon"></span>
    </div>
</div>

                        </div>

                        <div class="d-flex align-items-center">

                            <div class="dropdown d-md-none topbar-head-dropdown header-item">
                                <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle" id="page-header-search-dropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="bx bx-search fs-22"></i>
                                </button>
                                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0" aria-labelledby="page-header-search-dropdown">
                                    <div class="p-3">
                                        <div class="form-group m-0">
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="Search ..." aria-label="Recipient's username">
                                                <button class="btn btn-primary" type="submit"><i class="mdi mdi-magnify"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="dropdown ms-1 topbar-head-dropdown header-item">
                                <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <img id="header-lang-img" src="<%:contentPath %>/assets/images/flags/tr.svg" alt="Header Language" height="20" class="rounded">
                                </button>
                                <div class="dropdown-menu dropdown-menu-end">

                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language py-2" data-lang="tr" title="Turkish">
                                        <img src="<%:contentPath %>/assets/images/flags/tr.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">Türkçe</span>
                                    </a>
                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="en" title="English">
                                        <img src="<%:contentPath %>/assets/images/flags/us.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">English</span>
                                    </a>

                                                                        <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="fr" title="French">
                                        <img src="<%:contentPath %>/assets/images/flags/french.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">Français</span>
                                    </a>

                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="ar" title="Arabic">
                                        <img src="<%:contentPath %>/assets/images/flags/ae.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">Arabic</span>
                                    </a>

                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="sp" title="Spanish">
                                        <img src="<%:contentPath %>/assets/images/flags/spain.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">Española</span>
                                    </a>

                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="gr" title="German">
                                        <img src="<%:contentPath %>/assets/images/flags/germany.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">Deutsche</span>
                                    </a>

                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="it" title="Italian">
                                        <img src="<%:contentPath %>/assets/images/flags/italy.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">Italiana</span>
                                    </a>

                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="ru" title="Russian">
                                        <img src="<%:contentPath %>/assets/images/flags/russia.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">русский</span>
                                    </a>

                                    <!-- item-->
                                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="ch" title="Chinese">
                                        <img src="<%:contentPath %>/assets/images/flags/china.svg" alt="user-image" class="me-2 rounded" height="18">
                                        <span class="align-middle">中国人</span>
                                    </a>


                                </div>
                            </div>


                          <asp:UpdatePanel ID="upCart" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div class="dropdown topbar-head-dropdown ms-1 header-item">
            <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle" id="page-header-cart-dropdown"
                data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false">
                <i class='bx bx-shopping-bag fs-22'></i>
                <span class="position-absolute topbar-badge cartitem-badge fs-10 translate-middle badge rounded-pill bg-info">
                    <asp:Literal ID="ltrCartCount" runat="server" Text="0" />
                </span>
            </button>
            <div class="dropdown-menu dropdown-menu-xl dropdown-menu-end p-0 dropdown-menu-cart"
                aria-labelledby="page-header-cart-dropdown">
                <div class="p-3 border-top-0 border-start-0 border-end-0 border-dashed border">
                    <div class="row align-items-center">
                        <div class="col">
                            <h6 class="m-0 fs-16 fw-semibold">Sepet</h6>
                        </div>
                        <div class="col-auto">
                            <span class="badge bg-warning-subtle text-warning fs-13">
                                <asp:Literal ID="ltrCartCountBadge" runat="server" Text="0" />
                                ürün
                            </span>
                        </div>
                    </div>
                </div>

                <div data-simplebar style="max-height: 300px;">
                    <div class="p-2">
                        <asp:PlaceHolder ID="phCartEmpty" runat="server" Visible="false">
                            <div class="text-center empty-cart">
                                <div class="avatar-md mx-auto my-3">
                                    <div class="avatar-title bg-info-subtle text-info fs-36 rounded-circle">
                                        <i class='bx bx-cart'></i>
                                    </div>
                                </div>
                                <h5 class="mb-3">Sepetiniz boş !</h5>
                                <a href="/Products" class="btn btn-success w-md mb-3">Siparişe Başla</a>
                            </div>
                        </asp:PlaceHolder>

                        <asp:Repeater ID="rptCartItems" runat="server">
                            <ItemTemplate>
                                <div class="d-block dropdown-item dropdown-item-cart text-wrap px-3 py-2">
                                    <div class="d-flex align-items-center">
                                        <img src="/" class="me-3 rounded-circle avatar-sm p-2 bg-light" />
                                        <div class="flex-grow-1">
                                            <h6 class="mt-0 mb-1 fs-14"><%# Eval("ProductTitle") %></h6>
                                            <p class="mb-0 fs-12 text-muted">
                                                Miktar: <span><%# Eval("FormattedQty") %> x <%# Eval("FormattedPrice") %></span>
                                            </p>
                                        </div>
                                        <div class="px-2">
                                            <h5 class="m-0 fw-normal"><%# Eval("LineTotal") %></h5>
                                        </div>
                                        
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div class="p-3 border-bottom-0 border-start-0 border-end-0 border-dashed border">
                    <div class="d-flex justify-content-between align-items-center pb-3">
                        <h5 class="m-0 text-muted">Toplam:</h5>
                        <div class="px-2">
                            <h5 class="m-0"><asp:Literal ID="ltrCartTotal" runat="server" /></h5>
                        </div>
                    </div>
                    <a href="/Cart" class="btn btn-success text-center w-100">Sepete Git</a>
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>


                            <div class="dropdown topbar-head-dropdown ms-1 header-item" id="notificationDropdown" style="display: none;">
                                <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle" id="page-header-notifications-dropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false">
                                    <i class='bx bx-bell fs-22'></i>
                                    <span class="position-absolute topbar-badge fs-10 translate-middle badge rounded-pill bg-danger">3<span class="visually-hidden">unread messages</span></span>
                                </button>
                                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0" aria-labelledby="page-header-notifications-dropdown">

                                    <div class="dropdown-head bg-primary bg-pattern rounded-top">
                                        <div class="p-3">
                                            <div class="row align-items-center">
                                                <div class="col">
                                                    <h6 class="m-0 fs-16 fw-semibold text-white">Notifications </h6>
                                                </div>
                                                <div class="col-auto dropdown-tabs">
                                                    <span class="badge bg-light-subtle text-body fs-13">4 New</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="px-2 pt-2">
                                            <ul class="nav nav-tabs dropdown-tabs nav-tabs-custom" data-dropdown-tabs="true" id="notificationItemsTab" role="tablist">
                                                <li class="nav-item waves-effect waves-light">
                                                    <a class="nav-link active" data-bs-toggle="tab" href="#all-noti-tab" role="tab" aria-selected="true">All (4)
                                                    </a>
                                                </li>
                                                <li class="nav-item waves-effect waves-light">
                                                    <a class="nav-link" data-bs-toggle="tab" href="#messages-tab" role="tab" aria-selected="false">Messages
                                                    </a>
                                                </li>
                                                <li class="nav-item waves-effect waves-light">
                                                    <a class="nav-link" data-bs-toggle="tab" href="#alerts-tab" role="tab" aria-selected="false">Alerts
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>

                                    </div>

                                    <div class="tab-content position-relative" id="notificationItemsTabContent">
                                        <div class="tab-pane fade show active py-2 ps-2" id="all-noti-tab" role="tabpanel">
                                            <div data-simplebar style="max-height: 300px;" class="pe-2">
                                                <div class="text-reset notification-item d-block dropdown-item position-relative">
                                                    <div class="d-flex">
                                                        <div class="avatar-xs me-3 flex-shrink-0">
                                                            <span class="avatar-title bg-info-subtle text-info rounded-circle fs-16">
                                                                <i class="bx bx-badge-check"></i>
                                                            </span>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-2 lh-base">Your <b>Elite</b> author Graphic
                                                        Optimization <span class="text-secondary">reward</span> is
                                                        ready!
                                                                </h6>
                                                            </a>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>Just 30 sec ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="all-notification-check01">
                                                                <label class="form-check-label" for="all-notification-check01"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="text-reset notification-item d-block dropdown-item position-relative">
                                                    <div class="d-flex">
                                                        <img src="<%:contentPath %>/assets/images/users/avatar-2.jpg" class="me-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-1 fs-13 fw-semibold">Angela Bernier</h6>
                                                            </a>
                                                            <div class="fs-13 text-muted">
                                                                <p class="mb-1">
                                                                    Answered to your comment on the cash flow forecast's
                                                        graph 🔔.
                                                                </p>
                                                            </div>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>48 min ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="all-notification-check02">
                                                                <label class="form-check-label" for="all-notification-check02"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="text-reset notification-item d-block dropdown-item position-relative">
                                                    <div class="d-flex">
                                                        <div class="avatar-xs me-3">
                                                            <span class="avatar-title bg-danger-subtle text-danger rounded-circle fs-16">
                                                                <i class='bx bx-message-square-dots'></i>
                                                            </span>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-2 fs-13 lh-base">You have received <b class="text-success">20</b> new messages in the conversation
                                                                </h6>
                                                            </a>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>2 hrs ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="all-notification-check03">
                                                                <label class="form-check-label" for="all-notification-check03"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="text-reset notification-item d-block dropdown-item position-relative">
                                                    <div class="d-flex">
                                                        <img src="<%:contentPath %>/assets/images/users/avatar-8.jpg" class="me-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-1 fs-13 fw-semibold">Maureen Gibson</h6>
                                                            </a>
                                                            <div class="fs-13 text-muted">
                                                                <p class="mb-1">We talked about a project on linkedin.</p>
                                                            </div>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>4 hrs ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="all-notification-check04">
                                                                <label class="form-check-label" for="all-notification-check04"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="my-3 text-center view-all">
                                                    <button type="button" class="btn btn-soft-success waves-effect waves-light">
                                                        View
                                            All Notifications <i class="ri-arrow-right-line align-middle"></i>
                                                    </button>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="tab-pane fade py-2 ps-2" id="messages-tab" role="tabpanel" aria-labelledby="messages-tab">
                                            <div data-simplebar style="max-height: 300px;" class="pe-2">
                                                <div class="text-reset notification-item d-block dropdown-item">
                                                    <div class="d-flex">
                                                        <img src="<%:contentPath %>/assets/images/users/avatar-3.jpg" class="me-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-1 fs-13 fw-semibold">James Lemire</h6>
                                                            </a>
                                                            <div class="fs-13 text-muted">
                                                                <p class="mb-1">We talked about a project on linkedin.</p>
                                                            </div>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>30 min ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="messages-notification-check01">
                                                                <label class="form-check-label" for="messages-notification-check01"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="text-reset notification-item d-block dropdown-item">
                                                    <div class="d-flex">
                                                        <img src="<%:contentPath %>/assets/images/users/avatar-2.jpg" class="me-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-1 fs-13 fw-semibold">Angela Bernier</h6>
                                                            </a>
                                                            <div class="fs-13 text-muted">
                                                                <p class="mb-1">
                                                                    Answered to your comment on the cash flow forecast's
                                                        graph 🔔.
                                                                </p>
                                                            </div>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>2 hrs ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="messages-notification-check02">
                                                                <label class="form-check-label" for="messages-notification-check02"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="text-reset notification-item d-block dropdown-item">
                                                    <div class="d-flex">
                                                        <img src="<%:contentPath %>/assets/images/users/avatar-6.jpg" class="me-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-1 fs-13 fw-semibold">Kenneth Brown</h6>
                                                            </a>
                                                            <div class="fs-13 text-muted">
                                                                <p class="mb-1">
                                                                    Mentionned you in his comment on 📃 invoice #12501.
                                                                </p>
                                                            </div>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>10 hrs ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="messages-notification-check03">
                                                                <label class="form-check-label" for="messages-notification-check03"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="text-reset notification-item d-block dropdown-item">
                                                    <div class="d-flex">
                                                        <img src="<%:contentPath %>/assets/images/users/avatar-8.jpg" class="me-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="flex-grow-1">
                                                            <a href="#!" class="stretched-link">
                                                                <h6 class="mt-0 mb-1 fs-13 fw-semibold">Maureen Gibson</h6>
                                                            </a>
                                                            <div class="fs-13 text-muted">
                                                                <p class="mb-1">We talked about a project on linkedin.</p>
                                                            </div>
                                                            <p class="mb-0 fs-11 fw-medium text-uppercase text-muted">
                                                                <span><i class="mdi mdi-clock-outline"></i>3 days ago</span>
                                                            </p>
                                                        </div>
                                                        <div class="px-2 fs-15">
                                                            <div class="form-check notification-check">
                                                                <input class="form-check-input" type="checkbox" value="" id="messages-notification-check04">
                                                                <label class="form-check-label" for="messages-notification-check04"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="my-3 text-center view-all">
                                                    <button type="button" class="btn btn-soft-success waves-effect waves-light">
                                                        View
                                            All Messages <i class="ri-arrow-right-line align-middle"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade p-4" id="alerts-tab" role="tabpanel" aria-labelledby="alerts-tab"></div>

                                        <div class="notification-actions" id="notification-actions">
                                            <div class="d-flex text-muted justify-content-center">
                                                Select
                                                <div id="select-content" class="text-body fw-semibold px-1">0</div>
                                                Result
                                                <button type="button" class="btn btn-link link-danger p-0 ms-3" data-bs-toggle="modal" data-bs-target="#removeNotificationModal">Remove</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="ms-1 header-item d-none d-sm-flex">
                                <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle" data-toggle="fullscreen">
                                    <i class='bx bx-fullscreen fs-22'></i>
                                </button>
                            </div>

                            <div class="dropdown ms-sm-3 header-item topbar-user">
                                <button type="button" class="btn" id="page-header-user-dropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="d-flex align-items-center">
                                        <img class="rounded-circle header-profile-user" src="<%:contentPath %>/assets/images/users/avatar-1.jpg" alt="Header Avatar">
                                        <span class="text-start ms-xl-2">
                                            <span class="d-none d-xl-inline-block ms-1 fw-semibold user-name-text">FT Dijital Bilişim Danışmanlık Ltd. Şti.</span>
                                            <span class="d-none d-xl-block ms-1 fs-13 user-name-sub-text">Selim Çolakoğlu</span>
                                        </span>
                                    </span>
                                </button>
                                <div class="dropdown-menu dropdown-menu-end">
                                    <!-- item-->
                                    <h6 class="dropdown-header">Hoşgeldiniz</h6>
                                    <a class="dropdown-item" href="/MyProfile"><i class="mdi mdi-account-circle text-muted fs-16 align-middle me-1"></i><span class="align-middle">Profilim</span></a>
                                    <a class="dropdown-item" href="/Logout"><i class="mdi mdi-logout text-muted fs-16 align-middle me-1"></i><span class="align-middle">Çıkış Yap</span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- /.modal -->
            <!-- ========== App Menu ========== -->
            <div class="app-menu navbar-menu" id="page_menu">
                <!-- LOGO -->
                <div class="navbar-brand-box">
                    <!-- Dark Logo-->
                    <a href="index.html" class="logo logo-dark">
                        <span class="logo-sm">
                            <img src="<%:contentPath %>/assets/images/logo-sm.png" alt="" height="22">
                        </span>
                        <span class="logo-lg">
                            <img src="<%:contentPath %>/assets/images/logo-dark.png" alt="" height="17">
                        </span>
                    </a>
                    <!-- Light Logo-->
                    <a href="index.html" class="logo logo-light">
                        <span class="logo-sm">
                            <img src="<%:contentPath %>/assets/images/logo-sm.png" alt="" height="22">
                        </span>
                        <span class="logo-lg">
                            <img src="<%:contentPath %>/assets/images/logo-light.png" alt="" height="17">
                        </span>
                    </a>
                    <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover">
                        <i class="ri-record-circle-line"></i>
                    </button>
                </div>

                <div id="scrollbar">
<div class="container-fluid">
    <ul class="navbar-nav" id="navbar-nav">
        <li class="menu-title"><span data-key="t-menu">Menu</span></li>

        <!-- Kullanıcı Menüsü -->
        <asp:PlaceHolder ID="phUserMenuItems" runat="server" Visible="false">
            <li class="nav-item">
                <a class="nav-link menu-link" href="/">
                    <i class="ri-dashboard-2-line"></i><span>Anasayfa</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link menu-link" href="/Products">
                    <i class="ri-shopping-bag-line"></i><span>Tüm Ürünler</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link menu-link" href="/MyOrders">
                    <i class="ri-file-list-line"></i><span>Siparişlerim</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link menu-link" href="/Tickets">
                    <i class="ri-feedback-line"></i><span>Destek Talepleri</span>
                </a>
            </li>
        </asp:PlaceHolder>

        <!-- Admin Menüsü -->
        <asp:PlaceHolder ID="phAdminMenuItems" runat="server" Visible="false">
            <li class="nav-item">
                <a class="nav-link menu-link" href="/Admin">
                    <i class="ri-dashboard-fill"></i><span>Gösterge Paneli</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link menu-link" href="/Admin/Orders">
                    <i class="ri-file-list-3-line"></i><span>Siparişler</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link menu-link" href="#menuProductManager" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="menuProductManager">
                    <i class="ri-archive-line"></i><span>Ürün Yönetimi</span>
                </a>
                                            <div class="collapse menu-dropdown" id="menuProductManager">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="/Admin/Products" class="nav-link">Ürünler</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/Admin/ProductCategories" class="nav-link">Kategoriler</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/Admin/ProductBrands" class="nav-link">Markalar</a>
                                    </li>
                                </ul>
                            </div>
            </li>
<li class="nav-item">
    <a class="nav-link menu-link" href="#menuBusinessManager" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="menuBusinessManager">
        <i class="ri-building-line"></i><span>Cari Yönetimi</span>
    </a>

                <div class="collapse menu-dropdown" id="menuBusinessManager">
    <ul class="nav nav-sm flex-column">
        <li class="nav-item">
            <a href="/Admin/BusinessList" class="nav-link">Hesaplar</a>
        </li>
        <li class="nav-item">
            <a href="/Admin/UserList" class="nav-link">Kullanıcılar</a>
        </li>
    </ul>
</div>
</li>

        </asp:PlaceHolder>

<!-- Admin Paneline Geç -->
<asp:PlaceHolder ID="phAdminLink" runat="server" Visible="false">
    <li class="nav-item">
        <a class="nav-link menu-link text-danger" href="/Admin">
            <i class="ri-shield-user-line"></i><span>Admin Paneline Geç</span>
        </a>
    </li>
</asp:PlaceHolder>

<!-- Kullanıcı Paneline Geç -->
<asp:PlaceHolder ID="phUserLink" runat="server" Visible="false">
    <li class="nav-item">
        <a class="nav-link menu-link text-danger" href="/">
            <i class="ri-user-line"></i><span>Kullanıcı Paneline Geç</span>
        </a>
    </li>
</asp:PlaceHolder>


    </ul>
</div>

</div>


                    <!-- Sidebar -->
                </div>

                <div class="sidebar-background"></div>
         
            <!-- Left Sidebar End -->
            <!-- Vertical Overlay-->
            <div class="vertical-overlay"></div>