(function () {
    const defaultLang = "en";
    const storedLang = localStorage.getItem("language") || defaultLang;
    const langImgEl = document.getElementById("header-lang-img");

    const languageFlags = {
        tr: "tr.svg",
        en: "us.svg",
        sp: "spain.svg",
        gr: "germany.svg",
        it: "italy.svg",
        ru: "russia.svg",
        ch: "china.svg",
        fr: "french.svg",
        ar: "ae.svg"
    };

    function setLanguage(lang) {
        const langCode = languageFlags[lang] ? lang : defaultLang;
        const flagSrc = `/Themes/B2BTheme1/Content/assets/images/flags/${languageFlags[langCode]}`;
        if (langImgEl) langImgEl.src = flagSrc;

        localStorage.setItem("language", langCode);
        loadLanguageJSON(langCode);
    }

    function loadLanguageJSON(lang) {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", `/Themes/B2BTheme1/Content/assets/lang/${lang}.json`);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const translations = JSON.parse(xhr.responseText);
                Object.keys(translations).forEach(key => {
                    const elements = document.querySelectorAll(`[data-key='${key}']`);
                    elements.forEach(el => el.textContent = translations[key]);
                });
            }
        };
        xhr.send();
    }

    function setupLanguageSwitcher() {
        const languageBtns = document.querySelectorAll(".language");
        languageBtns.forEach(btn => {
            btn.addEventListener("click", function () {
                const selectedLang = this.getAttribute("data-lang");
                setLanguage(selectedLang);
            });
        });
    }

    // Initialize
    setLanguage(storedLang);
    setupLanguageSwitcher();
})();

function setupNavbarCollapses() {
    const collapses = document.querySelectorAll(".navbar-nav .collapse");

    if (!collapses.length) return;

    collapses.forEach(collapseEl => {
        const collapseInstance = new bootstrap.Collapse(collapseEl, { toggle: false });

        collapseEl.addEventListener("show.bs.collapse", event => {
            event.stopPropagation();

            const parentCollapse = collapseEl.parentElement.closest(".collapse");

            if (parentCollapse) {
                const siblingCollapses = parentCollapse.querySelectorAll(".collapse");
                siblingCollapses.forEach(sibling => {
                    const siblingInstance = bootstrap.Collapse.getInstance(sibling);
                    if (siblingInstance && siblingInstance !== collapseInstance) siblingInstance.hide();
                });
            } else {
                const siblings = Array.from(collapseEl.parentElement.parentElement.children)
                    .filter(el => el !== collapseEl.parentElement);

                siblings.forEach(sibling => {
                    if (sibling.childNodes.length > 2) {
                        const firstChild = sibling.firstElementChild;
                        if (firstChild) {
                            firstChild.setAttribute("aria-expanded", "false");
                        }

                        const nestedIds = sibling.querySelectorAll("[id]");
                        nestedIds.forEach(nested => {
                            nested.classList.remove("show");

                            const nestedLinks = nested.querySelectorAll("ul li a");
                            nestedLinks.forEach(link => {
                                if (link.hasAttribute("aria-expanded")) {
                                    link.setAttribute("aria-expanded", "false");
                                }
                            });
                        });
                    }
                });
            }
        });

        collapseEl.addEventListener("hide.bs.collapse", event => {
            event.stopPropagation();

            const nestedCollapses = collapseEl.querySelectorAll(".collapse");
            nestedCollapses.forEach(nested => {
                const nestedInstance = bootstrap.Collapse.getInstance(nested);
                if (nestedInstance) nestedInstance.hide();
            });
        });
    });
}

document.addEventListener("DOMContentLoaded", function () {
    setupNavbarCollapses();
});


function resetMenuLayout() {
    const layoutType = document.documentElement.getAttribute("data-layout");

    const scrollbar = document.getElementById("scrollbar");
    const navbarNav = document.getElementById("navbar-nav");
    const twoColumnMenu = document.getElementById("two-column-menu");
    const navbarMenu = document.querySelector(".navbar-menu");

    if (["vertical", "semibox"].includes(layoutType)) {
        if (twoColumnMenu) twoColumnMenu.innerHTML = "";
        if (navbarMenu) navbarMenu.innerHTML = initialNavbarHTML();
        if (scrollbar) {
            scrollbar.setAttribute("data-simplebar", "");
            scrollbar.classList.add("h-100");
        }
        if (navbarNav) navbarNav.setAttribute("data-simplebar", "");
    }

    if (layoutType === "twocolumn") {
        if (scrollbar) {
            scrollbar.removeAttribute("data-simplebar");
            scrollbar.classList.remove("h-100");
        }
    }

    if (layoutType === "horizontal") {
        setupHorizontalMenu();
    }
}

function setupTwoColumnLayout() {
    const savedAttributes = JSON.parse(sessionStorage.getItem("defaultAttribute") || "{}");

    const layout = document.documentElement.getAttribute("data-layout");
    if (!savedAttributes || layout !== "twocolumn" && savedAttributes["data-layout"] !== "twocolumn") return;

    const navbarMenu = document.querySelector(".navbar-menu");
    const navList = document.getElementById("navbar-nav").querySelectorAll(".menu-link");

    if (navbarMenu) navbarMenu.innerHTML = initialNavbarHTML();

    const listContainer = document.createElement("ul");
    listContainer.className = "twocolumn-iconview";

    navList.forEach(link => {
        const listItem = document.createElement("li");
        link.querySelectorAll("span").forEach(span => span.classList.add("d-none"));
        if (link.parentElement.classList.contains("twocolumn-item-show")) link.classList.add("active");
        link.classList.remove("collapsed", "menu-link");
        if (link.classList.contains("nav-link")) {
            link.classList.replace("nav-link", "nav-icon");
        }
        listItem.appendChild(link);
        listContainer.appendChild(listItem);
    });

    const currentPage = location.pathname === "/" ? "index.html" : location.pathname.substring(location.pathname.lastIndexOf("/") + 1);
    const activeLink = document.getElementById("navbar-nav").querySelector(`[href="${currentPage}"]`);

    if (activeLink) {
        const collapseMenu = activeLink.closest(".collapse.menu-dropdown");
        if (collapseMenu) {
            collapseMenu.classList.add("show");
            const parentLink = collapseMenu.parentElement.children[0];
            parentLink.classList.add("active");
            parentLink.setAttribute("aria-expanded", "true");
        }
    }

    const twoColumnMenu = document.getElementById("two-column-menu");
    if (twoColumnMenu) twoColumnMenu.innerHTML = listContainer.outerHTML;
}

function initialNavbarHTML() {
    // Bu fonksiyon baþtaki navbar-menu HTML'ini geri döndürür.
    // Sayfa yüklendiðinde alýnmýþ bir kopyasýný kullanmalýsýnýz.
    return window.initialNavbarHTML || "";  // Not: Sayfa ilk yüklenirken initialNavbarHTML = .navbar-menu.innerHTML alýnmalý
}

function setupHorizontalMenu() {
    // Horizontal layout için ayrý menü ayarlamalarý burada yapýlabilir.
    console.log("Horizontal layout initialized.");
}


document.addEventListener("DOMContentLoaded", function () {
    resetMenuLayout();
    setupTwoColumnLayout(); // Eðer twocolumn aktifse çalýþýr
});

function applySetting(attrName, value) {
    document.documentElement.setAttribute(attrName, value);
    sessionStorage.setItem(attrName, value);
}

function restoreDefaultSettingsFromSession() {
    const storedSettings = sessionStorage.getItem("defaultAttribute");
    if (!storedSettings) return;

    const settings = JSON.parse(storedSettings);
    Object.keys(settings).forEach(key => {
        applySetting(key, settings[key]);
    });
}

function saveCurrentAttributesAsDefault() {
    const attributes = document.documentElement.attributes;
    const settings = {};

    Array.from(attributes).forEach(attr => {
        if (attr && attr.name) {
            settings[attr.name] = attr.value;
            sessionStorage.setItem(attr.name, attr.value);
        }
    });

    sessionStorage.setItem("defaultAttribute", JSON.stringify(settings));
}

function initializeThemeOptions() {
    const inputGroups = document.querySelectorAll("[name]");

    inputGroups.forEach(input => {
        const attrName = input.name;

        // Set checked input on load
        if (input.value === sessionStorage.getItem(attrName)) {
            input.checked = true;
        }

        // Add change listener
        input.addEventListener("change", () => {
            applySetting(attrName, input.value);

            // Ekstra özel davranýþlar:
            if (attrName === "data-layout") {
                resetMenuLayout();
                setupTwoColumnLayout();
            }

            if (attrName === "data-bs-theme") {
                window.dispatchEvent(new Event("resize"));
            }

            if (attrName === "data-preloader") {
                const preloader = document.getElementById("preloader");
                if (input.value === "enable" && preloader) {
                    window.addEventListener("load", () => {
                        preloader.style.opacity = "0";
                        preloader.style.visibility = "hidden";
                    });
                }
            }

            if (attrName === "data-layout-width") {
                const sidebarSize = input.value === "boxed" ? "sm-hover" : "lg";
                applySetting("data-sidebar-size", sidebarSize);
            }
        });
    });
}


document.addEventListener("DOMContentLoaded", () => {
    if (sessionStorage.getItem("defaultAttribute")) {
        restoreDefaultSettingsFromSession();
    } else {
        saveCurrentAttributesAsDefault();
    }

    initializeThemeOptions();
});


function applyResponsiveLayout() {
    const width = document.documentElement.clientWidth;
    const layout = sessionStorage.getItem("data-layout");
    const hamburger = document.querySelector(".hamburger-icon");
    const body = document.body;

    // Küçük cihaz: 767px ve altý
    if (width <= 767) {
        body.classList.remove("vertical-sidebar-enable");
        body.classList.add("twocolumn-panel");

        if (layout === "twocolumn") {
            document.documentElement.setAttribute("data-layout", "vertical");
            applySetting("data-layout", "vertical");
        }

        document.documentElement.setAttribute("data-sidebar-size", "lg");

        if (hamburger) hamburger.classList.add("open");

    } else if (width <= 1025) {
        // Tablet / küçük ekran
        body.classList.remove("twocolumn-panel");

        if (layout === "twocolumn") {
            document.documentElement.setAttribute("data-layout", "twocolumn");
            document.getElementById("customizer-layout03")?.click();
            setupTwoColumnLayout();
        }

        if (layout === "vertical" || layout === "semibox") {
            document.documentElement.setAttribute("data-sidebar-size", "sm");
        }

        hamburger?.classList.add("open");

    } else {
        // Büyük ekran
        body.classList.remove("twocolumn-panel");

        if (layout === "twocolumn") {
            document.documentElement.setAttribute("data-layout", "twocolumn");
            document.getElementById("customizer-layout03")?.click();
            setupTwoColumnLayout();
        }

        if (layout === "vertical" || layout === "semibox") {
            const savedSize = sessionStorage.getItem("data-sidebar-size") || "lg";
            document.documentElement.setAttribute("data-sidebar-size", savedSize);
        }

        hamburger?.classList.remove("open");
    }
}

function debounce(fn, delay) {
    let timeout;
    return () => {
        clearTimeout(timeout);
        timeout = setTimeout(fn, delay);
    };
}


window.addEventListener("resize", debounce(applyResponsiveLayout, 200));
document.addEventListener("DOMContentLoaded", applyResponsiveLayout);


function setupNotificationTabs() {
    const tabContents = document.querySelectorAll("#notificationItemsTabContent .tab-pane");

    tabContents.forEach(tab => {
        const notificationItems = tab.querySelectorAll(".notification-item");
        const viewAllButton = tab.querySelector(".view-all");

        if (notificationItems.length > 0) {
            if (viewAllButton) viewAllButton.style.display = "block";
        } else {
            if (viewAllButton) viewAllButton.style.display = "none";

            // Eðer daha önce boþ mesaj eklenmediyse göster
            if (!tab.querySelector(".empty-notification-elem")) {
                tab.innerHTML += `
                    <div class="empty-notification-elem">
                        <div class="w-25 w-sm-50 pt-3 mx-auto">
                            <img src="/assets/images/svg/bell.svg" class="img-fluid" alt="No notifications">
                        </div>
                        <div class="text-center pb-5 mt-2">
                            <h6 class="fs-18 fw-semibold lh-base">
                                Hey! You have no any notifications
                            </h6>
                        </div>
                    </div>`;
            }
        }
    });
}

document.addEventListener("DOMContentLoaded", setupNotificationTabs);

function setupSearchInput({ inputId, dropdownId, closeBtnId }) {
    const input = document.getElementById(inputId);
    const dropdown = document.getElementById(dropdownId);
    const closeBtn = document.getElementById(closeBtnId);

    if (!input || !dropdown || !closeBtn) return;

    function toggleDropdown() {
        const value = input.value.trim().toLowerCase();

        if (value.length > 0) {
            dropdown.classList.add("show");
            closeBtn.classList.remove("d-none");

            // Filtreleme iþlemi
            const notifyItems = dropdown.querySelectorAll(".notify-item");
            notifyItems.forEach(item => {
                const title = item.querySelector("h6")?.innerText.toLowerCase() || "";
                const subtitle = item.querySelector("span")?.innerText.toLowerCase() || "";
                item.style.display = (title.includes(value) || subtitle.includes(value)) ? "block" : "none";
            });
        } else {
            dropdown.classList.remove("show");
            closeBtn.classList.add("d-none");
        }
    }

    function resetSearch() {
        input.value = "";
        dropdown.classList.remove("show");
        closeBtn.classList.add("d-none");
    }

    input.addEventListener("focus", toggleDropdown);
    input.addEventListener("keyup", toggleDropdown);
    closeBtn.addEventListener("click", resetSearch);

    document.body.addEventListener("click", (e) => {
        if (e.target.id !== inputId) {
            dropdown.classList.remove("show");
            closeBtn.classList.add("d-none");
        }
    });
}

document.addEventListener("DOMContentLoaded", () => {
    setupSearchInput({
        inputId: "search-options",
        dropdownId: "search-dropdown",
        closeBtnId: "search-close-options"
    });

    setupSearchInput({
        inputId: "search-options-reponsive",
        dropdownId: "search-dropdown-reponsive",
        closeBtnId: "search-close-options"
    });
});

function initializePreloader() {
    const isEnabled = sessionStorage.getItem("data-preloader") === "enable";
    const preloader = document.getElementById("preloader");

    if (!preloader) return;

    if (isEnabled) {
        window.addEventListener("load", () => {
            preloader.style.opacity = "0";
            preloader.style.visibility = "hidden";
        });
    } else {
        // Eðer preloader devre dýþýysa, sayfa yüklenmeden gizle
        preloader.style.opacity = "0";
        preloader.style.visibility = "hidden";
    }
}

document.addEventListener("DOMContentLoaded", initializePreloader);

function initializeChoicesDropdowns() {
    const elements = document.querySelectorAll("[data-choices]");

    elements.forEach(el => {
        const config = {};

        // Okunabilirlik için attribute’larý al
        const attrs = el.attributes;

        if (attrs["data-choices-search-false"]) config.searchEnabled = false;
        if (attrs["data-choices-search-true"]) config.searchEnabled = true;

        if (attrs["data-choices-removeItem"] || attrs["data-choices-multiple-remove"]) {
            config.removeItemButton = true;
        }

        if (attrs["data-choices-limit"]) {
            config.maxItemCount = parseInt(attrs["data-choices-limit"].value);
        }

        if (attrs["data-choices-sorting-false"]) config.shouldSort = false;
        if (attrs["data-choices-sorting-true"]) config.shouldSort = true;

        if (attrs["data-choices-text-unique-true"]) config.duplicateItemsAllowed = false;
        if (attrs["data-choices-text-disabled-true"]) config.addItems = false;

        // Eðer disable yapýlmýþsa
        if (attrs["data-choices-text-disabled-true"]) {
            new Choices(el, config).disable();
        } else {
            new Choices(el, config);
        }
    });
}

document.addEventListener("DOMContentLoaded", initializeChoicesDropdowns);
