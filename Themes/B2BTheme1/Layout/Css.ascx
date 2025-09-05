<%@ Control Language="C#" AutoEventWireup="true" %>
<%string contentPath = "/Themes/B2BTheme1/Content";  %>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="TPC Otomotiv - B2B" name="description" />
<meta content="Selim Çolakoğlu" name="author" />
<!-- App favicon -->
<link rel="shortcut icon" href="<%:contentPath %>/assets/images/favicon.ico" />

<!-- plugin css -->
<link href="<%:contentPath %>/assets/libs/jsvectormap/jsvectormap.min.css" rel="stylesheet" type="text/css" />

<!-- nouislider css -->
<link rel="stylesheet" href="<%:contentPath %>/assets/libs/nouislider/nouislider.min.css" />

<!-- gridjs css -->
<link rel="stylesheet" href="<%:contentPath %>/assets/libs/gridjs/theme/mermaid.min.css" />

<!-- Layout config Js -->
<script src="<%:contentPath %>/assets/js/layout.js"></script>

<!-- Bootstrap Css -->
<link href="<%:contentPath %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<!-- Icons Css -->
<link href="<%:contentPath %>/assets/css/icons.min.css" rel="stylesheet" type="text/css" />

<!-- App Css -->
<link href="<%:contentPath %>/assets/css/app.min.css" rel="stylesheet" type="text/css" />

<!-- Custom Css -->
<link href="<%:contentPath %>/assets/css/custom.min.css" rel="stylesheet" type="text/css" />

<script>
    document.documentElement.setAttribute("lang", "tr");
    document.documentElement.setAttribute("data-layout", "horizontal");
    document.documentElement.setAttribute("data-layout-style", "detached");
    document.documentElement.setAttribute("data-sidebar", "light");
    document.documentElement.setAttribute("data-topbar", "light");
    document.documentElement.setAttribute("data-sidebar-size", "lg");
    document.documentElement.setAttribute("data-sidebar-image", "none");
    document.documentElement.setAttribute("data-preloader", "disable");
</script>



<style>
    .modal {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        z-index: 1055 !important;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.5);
        padding-top: 0 !important;
        margin-top: 0 !important;
    }

    .modal-dialog {
        margin-top: 0 !important;
        margin-left: auto;
        margin-right: auto;
    }

    body.modal-open {
        padding-right: 0 !important;
    }
</style>
<style>
    .checkboxlist input[type="checkbox"] {
        margin-right: 6px;
        accent-color: #0d6efd; /* Bootstrap primary rengi */
    }

    .checkboxlist label {
        margin-bottom: 4px;
        display: flex;
        align-items: center;
    }
</style>
