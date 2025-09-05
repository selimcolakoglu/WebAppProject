<%@ Control Language="C#" AutoEventWireup="true" %>

    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta property="og:title" content="" />
    <meta property="og:type" content="" />
    <meta property="og:url" content="" />
    <meta property="og:image" content="" />
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="/Themes/WEBTheme1/Content/assets/imgs/theme/favicon.svg" />
    <!-- Template CSS -->
    <link rel="stylesheet" href="/Themes/WEBTheme1/Content/assets/css/plugins/animate.min.css" />
    <link rel="stylesheet" href="/Themes/WEBTheme1/Content/assets/css/main.css?v=6.1" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
    @media (min-width: 1200px) {
    .header-wrap {
        flex-wrap: nowrap;
        align-items: center;
    }

    .header-nav {
        flex: 1;
        min-width: 0;
    }

    .main-menu ul {
        flex-wrap: wrap;
        gap: 15px;
    }

    .hotline {
        margin-left: auto !important;
        flex-shrink: 0;
    }

    .header-action-right {
        flex-shrink: 0;
    }
}

    .categori-dropdown-inner ul {
    width: 50%;
}

    .map-responsive iframe {
    width: 100%;
    height: 450px;
    border: 0;
    display: block;
    max-width: 100%;
}

    .slider-content h1,
.slider-content p {

    text-shadow:
        -1px -1px 0 #fff,
         1px -1px 0 #fff,
        -1px  1px 0 #fff,
         1px  1px 0 #fff;
}


</style>

<style>
    .product-img {
        height: 200px;
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
    }

    .product-img img {
        max-height: 100%;
        max-width: 100%;
        object-fit: contain;
    }

    .product-cart-wrap {
        min-height: 500px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

.product-content-wrap h2 a {
    display: -webkit-box;
    -webkit-line-clamp: 2;           /* 2 satırda sınırla */
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    min-height: 48px;                /* Satır yüksekliğine göre ayarla: 2 x line-height */
    line-height: 24px;               /* Satır yüksekliği (örnek) */
}


</style>

<style>
/* Genel stil */
.treeview {
    font-family: 'Segoe UI', sans-serif;
    font-size: 14px;
}

/* Satır içindeki tüm hücreler hizalı ve boşluklu olsun */
.treeview td {
    vertical-align: middle;
    padding: 4px 2px;
}

/* Artı/Eksi ikon kolonu */
.treeview td:first-child {
    width: 30px;
    text-align: center;
}

/* Artı/Eksi ikon hizalaması ve boşluğu — SAĞA verildi */
.treeview a img {
    vertical-align: middle;
    margin-right: 6px;
    margin-top: 2px;
}

.treeview td:nth-child(1) {
    border-right:0px;
}

/* Checkbox + Yazı hizalaması */
.treeview td:nth-child(2) {
    vertical-align: middle;
    padding-left: 6px;
    white-space: nowrap;
}

.treeview td:nth-child(2) input[type="checkbox"] {
    vertical-align: middle;
    margin-right: 6px;
}

/* Checkbox boyut ayarı */
.treeview input[type="checkbox"] {
    transform: scale(0.9);
    width: 16px;
    height: 16px;
    margin-top: -5px;
}

.treeview > div > table td:first-child > div {
    width: 50px !important;
}

.treeview > div > table td:nth-child(1) {
    border-right:0px;
}

.treeview > div > table td:nth-child(2) {
    display: none;
}

.treeview > div > table td:nth-child(3) {
    vertical-align: middle;
    padding-left: 6px;
    white-space: nowrap;
}

.treeview > div > table td:nth-child(3) input[type="checkbox"] {
    vertical-align: middle;
    margin-right: 6px;
}

.treeview table {
    margin-bottom: 0px !important;
}
</style>