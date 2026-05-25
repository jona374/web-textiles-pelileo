/* ============================================================
   TEXTILES PELILEO — Interacciones de UI
   ============================================================ */
(function () {
    "use strict";

    /* --- Menú móvil --- */
    var burger = document.getElementById("burger");
    var menu = document.getElementById("mobileMenu");
    function closeMenu() {
        if (!menu) return;
        menu.classList.remove("is-open");
        if (burger) { burger.classList.remove("is-open"); burger.setAttribute("aria-expanded", "false"); }
        document.body.style.overflow = "";
    }
    if (burger && menu) {
        burger.addEventListener("click", function () {
            var open = menu.classList.toggle("is-open");
            burger.classList.toggle("is-open", open);
            burger.setAttribute("aria-expanded", open ? "true" : "false");
            document.body.style.overflow = open ? "hidden" : "";
        });
        menu.querySelectorAll("a").forEach(function (a) { a.addEventListener("click", closeMenu); });
        document.addEventListener("keydown", function (e) { if (e.key === "Escape") closeMenu(); });
    }

    /* --- Header sombra al hacer scroll --- */
    var header = document.querySelector(".site-header");
    function onScroll() { if (header) header.classList.toggle("scrolled", window.scrollY > 12); }
    window.addEventListener("scroll", onScroll, { passive: true });
    onScroll();

    /* --- Acordeón FAQ --- */
    document.querySelectorAll(".faq__q").forEach(function (q) {
        q.addEventListener("click", function () {
            var item = q.closest(".faq__item");
            var ans = item.querySelector(".faq__a");
            var isOpen = item.classList.toggle("open");
            ans.style.maxHeight = isOpen ? (ans.scrollHeight + "px") : null;
        });
    });

    /* --- Scroll reveal --- */
    var reveals = document.querySelectorAll(".reveal");
    if ("IntersectionObserver" in window && reveals.length) {
        var io = new IntersectionObserver(function (entries) {
            entries.forEach(function (en) {
                if (en.isIntersecting) { en.target.classList.add("in"); io.unobserve(en.target); }
            });
        }, { threshold: 0.12, rootMargin: "0px 0px -40px 0px" });
        reveals.forEach(function (el) { io.observe(el); });
    } else {
        reveals.forEach(function (el) { el.classList.add("in"); });
    }
})();
