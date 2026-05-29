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

    /* --- Contadores que cuentan al hacerse visibles --- */
    function countUp(el) {
        if (el.dataset.counted === "1") return;
        el.dataset.counted = "1";
        var to = parseInt(el.getAttribute("data-to"), 10) || 0;
        var suffix = el.getAttribute("data-suffix") || "";
        var prefix = el.getAttribute("data-prefix") || "";
        var dur = parseInt(el.getAttribute("data-dur"), 10) || 1200;
        var start = performance.now();
        function step(now) {
            var p = Math.min(1, (now - start) / dur);
            var eased = 1 - Math.pow(1 - p, 3);
            var val = Math.round(eased * to);
            el.textContent = prefix + val + suffix;
            if (p < 1) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    }
    var counters = document.querySelectorAll(".count-up");
    if ("IntersectionObserver" in window && counters.length) {
        var co = new IntersectionObserver(function (entries) {
            entries.forEach(function (en) { if (en.isIntersecting) { countUp(en.target); co.unobserve(en.target); } });
        }, { threshold: 0.4 });
        counters.forEach(function (el) { co.observe(el); });
    }

    /* --- Parallax sutil del hero (transform en imagen de fondo) --- */
    var heroBgImg = document.querySelector(".hero__bg img");
    if (heroBgImg && !matchMedia("(prefers-reduced-motion: reduce)").matches) {
        var ticking = false;
        window.addEventListener("scroll", function () {
            if (!ticking) {
                requestAnimationFrame(function () {
                    var y = Math.min(window.scrollY * 0.25, 120);
                    heroBgImg.style.transform = "translate3d(0," + y + "px,0) scale(1.05)";
                    ticking = false;
                });
                ticking = true;
            }
        }, { passive: true });
    }

    /* --- Tilt 3D suave en .card (solo escritorio con mouse) --- */
    if (matchMedia("(hover: hover) and (pointer: fine)").matches && !matchMedia("(prefers-reduced-motion: reduce)").matches) {
        function bindTilt(card) {
            card.classList.add("tilt");
            var raf = null, hovering = false;
            card.addEventListener("mouseenter", function () { hovering = true; card.style.transition = "transform .12s var(--ease), box-shadow .35s var(--ease)"; });
            card.addEventListener("mousemove", function (e) {
                if (!hovering) return;
                var r = card.getBoundingClientRect();
                var px = (e.clientX - r.left) / r.width - .5;
                var py = (e.clientY - r.top) / r.height - .5;
                if (raf) cancelAnimationFrame(raf);
                raf = requestAnimationFrame(function () {
                    card.style.setProperty("--ry", (px * 7) + "deg");
                    card.style.setProperty("--rx", (-py * 7) + "deg");
                    card.style.setProperty("--tz", "10px");
                });
            });
            card.addEventListener("mouseleave", function () {
                hovering = false;
                card.style.transition = "transform .5s var(--ease), box-shadow .35s var(--ease)";
                card.style.setProperty("--rx", "0deg");
                card.style.setProperty("--ry", "0deg");
                card.style.setProperty("--tz", "0");
            });
        }
        document.querySelectorAll(".card").forEach(bindTilt);
        // observar cards inyectadas por products.js
        var mo = new MutationObserver(function (muts) {
            muts.forEach(function (m) {
                m.addedNodes.forEach(function (n) {
                    if (n.nodeType !== 1) return;
                    if (n.classList && n.classList.contains("card")) bindTilt(n);
                    n.querySelectorAll && n.querySelectorAll(".card:not(.tilt)").forEach(bindTilt);
                });
            });
        });
        mo.observe(document.body, { childList: true, subtree: true });
    }

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
