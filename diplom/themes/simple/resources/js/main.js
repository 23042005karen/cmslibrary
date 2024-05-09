var app = {
    smoothScroll: function () {
        if ($("#back-to-top").length > 0)
            $('#back-to-top').on('click', function (e) {
                e.preventDefault();
                $('html,body').animate({
                    scrollTop: 0
                }, 700);
            });
    },
    markMatch: function (text, term) {
        var match = text.toUpperCase().indexOf(term.toUpperCase());
        var $result = $('<span></span>');
        if (match < 0) {
            return $result.text(text);
        }
        $result.text(text.substring(0, match));
        var $match = $('<span class="select2-rendered__match"></span>');
        $match.text(text.substring(match, match + term.length));
        $result.append($match);
        $result.append(text.substring(match + term.length));
        return $result;
    },
    ajax_redirect: function (data) {
        if (data.redirect) {
            window.location.href = data.redirect;
            return false;
        }
    },
    searchForm: function () {
        $('.search-close').on('click', function () {
            $('.search-header').removeClass('open');
        });
        $('.search-open').on('click', function (e) {
            e.preventDefault();
            $('.search-header').addClass('open');
            $('.search-input').focus();
        });
    },
    displayMessage: function (type, text) {
        //type - danger, warning, success, info
        var block = $('#message-block');
        $(block).removeClass().addClass('alert alert-' + type).html(text).show();
        setTimeout(function () {
            $(block).hide();
        }, 5000);
    },
    card: {
        delete: function (elm, fn) {
            elm = $(elm);

            elm.fadeOut(200, function () {
                $(this).remove();
            });

            if (typeof fn === "function") fn();

            return false;
        },
        toggle: function (elm, fn) {
            elm = $(elm);

            elm.toggleClass("block-toggled");

            if (typeof fn === "function") fn();

            return false;
        },
        expand: function (elm, fn) {
            elm = $(elm);

            elm.toggleClass("block-expanded");

            if (typeof fn === "function") fn();

            return false;
        },
        loading: {
            start: function (elm) {
                $(elm).append("<div class=\"card-loading-layer\"><div class=\"app-spinner loading loading-primary\"></div></div>");
                return true;
            },
            finish: function (elm) {
                $(elm).find(".card-loading-layer").remove();
                return true;
            }
        }
    },
    getErrorMessage: function (jqXHR, exception) {
        var msg = '';
        if (jqXHR.status === 0) {
            msg = 'Not connect.\n Verify Network.';
        } else if (jqXHR.status == 404) {
            msg = 'Requested page not found. [404]';
        } else if (jqXHR.status == 500) {
            msg = 'Internal Server Error [500].';
        } else if (exception === 'parsererror') {
            msg = 'Requested JSON parse failed.';
        } else if (exception === 'timeout') {
            msg = 'Time out error.';
        } else if (exception === 'abort') {
            msg = 'Ajax request aborted.';
        } else {
            msg = 'Uncaught Error.\n' + jqXHR.responseText;
        }
        return msg;
    },
    bootstrap_select: function () {
        if ($(".select-picker").length > 0) {
            $('.select-picker').selectpicker();
        }
    },
    bootstrap_tooltip: function () {
        $("[data-toggle='tooltip']").tooltip();
    },
    switch_button: function () {
        if ($(".switch").length > 0) {
            $(".switch").each(function () {
                $(this).append("<span></span>");
            });
        }
    },
    checkbox_radio: function () {
        if ($(".app-checkbox").length > 0 || $(".app-radio").length > 0) {
            $(".app-checkbox label, .app-radio label").each(function () {
                $(this).append("<span></span>");
            });
        }
    },
    multi_dropdown: function () {
        $('.primary-menu-items .dropdown > a').on('click', function (e) {
            if (!$(this).next().hasClass('show')) {
                $(this).parents('.dropdown-menu').first().find('.show').removeClass("show");
            }
            var $subMenu = $(this).next(".dropdown-menu");
            $subMenu.toggleClass('show');

            $(this).parent("li").toggleClass('show');

            $(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function (e) {
                $('.dropdown-menu .show').removeClass("show");
            });
            return false;
        });
    },
    loaded: function () {
        app.smoothScroll();
        app.searchForm();
        app.checkbox_radio();
        app.multi_dropdown();
    }
};
$(document).ready(function () {
    app.loaded();
});