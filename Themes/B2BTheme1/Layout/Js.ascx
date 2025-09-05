<%@ Control Language="C#" AutoEventWireup="true"  %>
<%string contentPath = "/Themes/B2BTheme1/Content";  %>

        <!-- JAVASCRIPT -->
        <script src="<%:contentPath %>/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="<%:contentPath %>/assets/libs/simplebar/simplebar.min.js"></script>
        <script src="<%:contentPath %>/assets/libs/node-waves/waves.min.js"></script>
        <script src="<%:contentPath %>/assets/libs/feather-icons/feather.min.js"></script>
        <script src="<%:contentPath %>/assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
        <script src="<%:contentPath %>/assets/js/plugins.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/choices.js/public<%:contentPath %>/assets/scripts/choices.min.js"></script>
            <!-- nouisliderribute js -->
    <script src="<%:contentPath %>/assets/libs/nouislider/nouislider.min.js"></script>
    <script src="<%:contentPath %>/assets/libs/wnumb/wNumb.min.js"></script>

    <!-- gridjs js -->
    <script src="<%:contentPath %>/assets/libs/gridjs/gridjs.umd.js"></script>
    <script src="https://unpkg.com/gridjs/plugins/selection/dist/selection.umd.js"></script>

        <!-- apexcharts -->
        <script src="<%:contentPath %>/assets/libs/apexcharts/apexcharts.min.js"></script>

        <!-- Vector map-->
        <script src="<%:contentPath %>/assets/libs/jsvectormap/jsvectormap.min.js"></script>
        <script src="<%:contentPath %>/assets/libs/jsvectormap/maps/world-merc.js"></script>

        <!-- Dashboard init -->
        <script src="<%:contentPath %>/assets/js/pages/dashboard-analytics.init.js"></script>

            <!-- list.js min js -->
    <script src="<%:contentPath %>/assets/libs/list.js/list.min.js"></script>

    <!--list pagination js-->
    <script src="<%:contentPath %>/assets/libs/list.pagination.js/list.pagination.min.js"></script>

    <!-- ecommerce-order init js -->
    <script src="<%:contentPath %>/assets/js/pages/ecommerce-order.init.js"></script>

            <script src="<%:contentPath %>/assets/libs/card/card.js"></script>

    <!-- Sweet Alerts js -->
    <script src="<%:contentPath %>/assets/libs/sweetalert2/sweetalert2.min.js"></script>




        <!-- App js -->
        <script src="<%:contentPath %>/assets/js/app_fixed.js"></script>

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

        <script type="text/javascript">
            function syncStateTextBox(txtId, checkboxEl) {
                const textbox = document.getElementById(txtId);
                if (textbox) {
                    textbox.value = checkboxEl.checked ? "1" : "0";
                }
            }
        </script>

        <script type="text/javascript">
            function restoreCheckboxesFromState() {
                document.querySelectorAll(".form-check-input").forEach(function (visibleCheckbox) {
                    var textbox = visibleCheckbox.parentElement.querySelector("input[type='text'].d-none");
                    if (textbox) {
                        visibleCheckbox.checked = textbox.value === "1";
                    }
                });
            }

            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(function () {
                document.getElementById("loadingOverlay").style.display = "block";
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                restoreCheckboxesFromState();
                document.getElementById("loadingOverlay").style.display = "none";
            });


            // İlk yüklemede de çalışsın
            window.addEventListener("load", restoreCheckboxesFromState);
        </script>

       <script>
           function triggerQtyUpdate(input) {
               const original = input.getAttribute("data-original");
               const current = input.value;

               if (original === current) return; // değişiklik yok, işlem yapma

               setTimeout(function () {
                   const triggerBtn = input.closest('.product').querySelector('input[id*="btnTriggerQty"]');
                   if (triggerBtn) triggerBtn.click();
               }, 10);
           }

           function triggerQtyEnter(input, e) {
               if ((e.which || e.keyCode) === 13) {
                   e.preventDefault();

                   const original = input.getAttribute("data-original");
                   const current = input.value;

                   if (original === current) return false;

                   triggerQtyUpdate(input);
                   return false;
               }
               return true;
           }
       </script>

        <script type="text/javascript">
            function closeModalFunc(modalId, triggerButtonId) {
                var modal = document.getElementById(modalId);
                if (modal) {
                    var bsModal = bootstrap.Modal.getInstance(modal) || new bootstrap.Modal(modal);
                    bsModal.hide();

                    setTimeout(function () {
                        var btn = document.getElementById(triggerButtonId);
                        if (btn) btn.click();
                    }, 400);
                }
            }
        </script>

        <script>
            function showErrorList(messageList) {
                const messages = messageList.split("+");
                const htmlList = "<ul style='text-align: left; margin: 0; padding-left: 20px;'>" +
                    messages.map(m => `<li>${m}</li>`).join('') + "</ul>";

                Swal.fire({
                    icon: 'error',
                    title: 'Hata!',
                    html: htmlList,
                    confirmButtonText: 'Tamam',
                    customClass: {
                        confirmButton: 'btn btn-danger'
                    },
                    buttonsStyling: false
                });
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


        <script>
            function selectAddress(type, id, targetTextboxId) {
                const textbox = document.getElementById(targetTextboxId);
                if (textbox) {
                    textbox.value = id;
                }
            }

        </script>

                <script>
                    function radioToTextbox(id, targetTextboxId) {
                        const textbox = document.getElementById(targetTextboxId);
                        if (textbox) {
                            textbox.value = id;
                            __doPostBack(targetTextboxId, ''); // ASP.NET TextChanged tetikleme
                        }
                    }

                </script>

<script>
    function parentModalClose(id) {
        var modalEl = window.parent.document.getElementById(id);
        if (modalEl) {
            var modalInstance = window.parent.bootstrap.Modal.getInstance(modalEl);
            if (modalInstance) {
                modalInstance.hide();
            }
        }
    }
</script>

        <script>
            function goToSearch() {
                var input = document.getElementById('txtGlobalSearch');
                var keyword = input.value.trim();
                if (keyword.length > 0) {
                    window.location.href = '/Products?k=' + encodeURIComponent(keyword);
                }
            }
        </script>