(function ($) {
    'use strict';

    $('.menu-toggler').on('click', function () {
        $('.bar').toggleClass('animate');
    });


})(jQuery);
var app = {
    stickyHeader: function () {
        $(".header").sticky({
            topSpacing: 0,
            zIndex: 999
        });
    },
    smoothScroll: function () {
        var amountScrolled = 100;
        $(window).scroll(function () {
            if ($(window).scrollTop() > amountScrolled) {
                $('button.back-to-top').addClass('show');
            } else {
                $('button.back-to-top').removeClass('show');
            }
        });

        $('button.back-to-top').click(function () {
            $('html, body').animate({
                scrollTop: 0
            }, 800);
            return false;
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
            $('.search-header').removeClass('open').addClass('out');
            setTimeout(function () {
                $('.search-header').hide().addClass('hide');
            }, 850);
        });
        $('.search-open').on('click', function (e) {
            e.preventDefault();
            $('.search-header').show().addClass('open').removeClass('hide out');
            $('.search-input').focus();
        });
    },
    notification: function (type, text) {
        //var msg = '<strong>' + text + '</strong>';
        new Noty({
            text: text,
            type: type, // success, error, warning, information
            layout: 'topRight',
            progressBar: true,
            theme: 'library-cms',
            timeout: 7000,
            animation: {
                open: "animated bounceIn",
                close: "animated fadeOut",
                speed: 200
            }
        }).show();
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
    bootstrap_tooltip: function () {
        $("[data-toggle='tooltip']").tooltip();
    },
    loaded: function () {
        app.stickyHeader();
        app.smoothScroll();
        app.searchForm();
        app.bootstrap_tooltip();
    }
};
$(document).ready(function () {
    app.loaded();
});