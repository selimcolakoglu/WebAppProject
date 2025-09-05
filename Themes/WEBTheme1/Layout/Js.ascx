<%@ Control Language="C#" AutoEventWireup="true" %>

    <!-- Vendor JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/14.6.3/nouislider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/wnumb/1.2.0/wNumb.min.js"></script>

    <script src="/Themes/WEBTheme1/Content/assets/js/vendor/modernizr-3.6.0.min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/vendor/jquery-3.7.1.min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/vendor/jquery-migrate-3.3.0.min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/vendor/bootstrap.bundle.min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/slick.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/jquery.syotimer.min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/waypoints.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/wow.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/perfect-scrollbar.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/magnific-popup.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/select2.min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/counterup.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/jquery.countdown.min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/images-loaded.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/isotope.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/scrollup.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/jquery.vticker-min.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/jquery.theia.sticky.js"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/plugins/jquery.elevatezoom.js"></script>

    <!-- Template  JS -->
    <script src="/Themes/WEBTheme1/Content/assets/js/main.js?v=6.2"></script>
    <script src="/Themes/WEBTheme1/Content/assets/js/shop.js?v=6.2"></script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script type="text/javascript">
                function showCartSuccess() {

                    setTimeout(() => {
                        Swal.fire({
                            icon: 'success',
                            title: 'Sepete eklendi!',
                            showConfirmButton: false,
                            timer: 1000
                        });
                    }, 10);
                }
            </script>

 <script>
     function enableEnterToClickButtonByDataAttr() {
         document.querySelectorAll('input[data-button]').forEach(function (textbox) {
             textbox.addEventListener('keydown', function (e) {
                 if (e.key === 'Enter') {
                     e.preventDefault();
                     var buttonId = textbox.getAttribute('data-button');
                     var button = document.getElementById(buttonId);
                     if (button) button.click();
                 }
             });
         });
     }

     document.addEventListener('DOMContentLoaded', function () {
         enableEnterToClickButtonByDataAttr();
     });
 </script>

<script>
    function bindTreeViewCheckboxLogic() {
        // Yazıya tıklanınca checkbox'ı toggle et ve change event'ini tetikle
        document.querySelectorAll(".treeview td:nth-child(2) a, .treeview td:nth-child(3) a").forEach(function (link) {
            const checkbox = link.closest("td")?.querySelector('input[type="checkbox"]');
            if (!checkbox) return;

            link.removeAttribute("href");
            link.onclick = function (e) {
                e.preventDefault();
                checkbox.checked = !checkbox.checked;
                checkbox.dispatchEvent(new Event("change"));
            };
        });

        // SADECE ÜST kategorilerin checkbox'ları altları etkilesin
        document.querySelectorAll(".treeview > table input[type='checkbox']").forEach(function (checkbox) {
            checkbox.addEventListener("change", function () {
                const currentRow = this.closest("tr");
                const nextDiv = currentRow?.parentElement?.parentElement?.nextElementSibling;
                if (!nextDiv || !nextDiv.matches("div")) return;

                const subCheckboxes = nextDiv.querySelectorAll("input[type='checkbox']");
                subCheckboxes.forEach(cb => cb.checked = this.checked);
            });
        });
    }

    document.addEventListener("DOMContentLoaded", bindTreeViewCheckboxLogic);

    if (typeof (Sys) !== "undefined") {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            bindTreeViewCheckboxLogic();
        });
    }
</script>

<script>
    document.addEventListener("click", function (e) {
        var icon = e.target.closest("i");

        if (!icon || !icon.className.includes("fi-rs")) return;

        var linkButton = icon.closest("a");
        if (!linkButton) return;

        // ASP.NET LinkButton ise:
        if (linkButton.href && linkButton.href.startsWith("javascript:__doPostBack")) {
            // Direkt dış kapsayıcı <a>'ya tıklat
            e.preventDefault();
            e.stopPropagation();

            // Elle tetikle (bazı tarayıcılar güvenlik nedeniyle eval engeller)
            linkButton.click();
        }
    }, true);
</script>


<script>
    function triggerQtyUpdate(input) {
        const original = input.getAttribute("data-original");
        const current = input.value.trim();

        if (original === current) return;

        const td = input.closest("td");
        const triggerBtn = td ? td.querySelector('input[id*="btnTriggerQty"]') : null;

        if (triggerBtn) {
            setTimeout(() => {
                triggerBtn.click();
            }, 10);
        }
    }

    function triggerQtyEnter(input, e) {
        if ((e.which || e.keyCode) === 13) {
            e.preventDefault();

            const original = input.getAttribute("data-original");
            const current = input.value.trim();

            if (original === current) return false;

            triggerQtyUpdate(input);
            return false;
        }
        return true;
    }
</script>

        <script>
            function showSuccessMessage(message) {
                Swal.fire({
                    icon: 'success',
                    title: 'Başarılı!',
                    html: `<p style="text-align: center; font-size: 18px; margin: 0;">${message}</p>`,
                    confirmButtonText: 'Tamam',
                    customClass: {
                        confirmButton: 'btn btn-success'
                    },
                    buttonsStyling: false
                });
            }
</script>
        <script>
            function showErrorMessage(message) {
                Swal.fire({
                    icon: 'error',
                    title: 'Hata!',
                    html: `<p style="text-align: center; font-size: 18px; margin: 0;">${message}</p>`,
                    confirmButtonText: 'Tamam',
                    customClass: {
                        confirmButton: 'btn btn-danger'
                    },
                    buttonsStyling: false
                });
            }
        </script>