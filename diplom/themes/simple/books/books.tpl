{extends file='public.tpl'}
{block name=metaTitle}{t}Books List{/t}{/block}
{block name=metaDescription}{/block}
{block name=metaKeywords}{/block}
{block name=headerCss append}{/block}
{block name=content}
    <div class="page">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-sm-12 col-xs-12 order-xs-2">
                    <div class="books-list">
                        {include 'books/books-list-with-filter.tpl' size_grid="col-sm-6 col-md-4 col-lg-3"}
                    </div>
                </div>
                <div class="col-md-4 col-sm-12 col-xs-12 order-xs-1">
                    {include 'general/search-filter.tpl'}
                </div>
            </div>
        </div>
    </div>
{/block}
{block name='footerJs' append}{/block}
{block name='customJs' append}
    <script>
        $(document).on('change', '#countPerPage', function (e) {
            var url = '{$routes->getRouteString("booksPublic")}';
            $.ajax({
                type: "POST",
                url: url,
                data: $('#book-filter, #books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
                beforeSend: function () {
                    $('#preloader-book').show();
                },
                success: function (data) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.displayMessage('danger', data.error);
                    } else {
                        $('.books-list').html(data.html);
                    }
                },
                complete: function () {
                    $('#preloader-book').hide();
                },
                error: function (jqXHR, exception) {
                    app.displayMessage('danger', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
        $(document).on('change', '#books-sort', function (e) {
            var url = '{$routes->getRouteString("booksPublic")}';
            $.ajax({
                type: "POST",
                url: url,
                data: $('#book-filter, #books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
                beforeSend: function () {
                    $('#preloader-book').show();
                },
                success: function (data) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.displayMessage('danger', data.error);
                    } else {
                        $('.books-list').html(data.html);
                    }
                },
                complete: function () {
                    $('#preloader-book').hide();
                },
                error: function (jqXHR, exception) {
                    app.displayMessage('danger', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
        $(document).on('click', '.ajax-page', function (e) {
            e.preventDefault();
            $.ajax({
                type: "POST",
                dataType: 'json',
                data: $('#book-filter, #books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
                url: $(this).attr('href'),
                beforeSend: function () {
                    $('#preloader-book').show();
                },
                success: function (data) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.displayMessage('danger', data.error);
                    } else {
                        $('.books-list').html(data.html);
                    }
                },
                complete: function () {
                    $('#preloader-book').hide();
                },
                error: function (jqXHR, exception) {
                    app.displayMessage('danger', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
        var publisherSearchUrl = '{$routes->getRouteString("publisherSearchPublic",[])}';
        $("#publishers").select2({
            ajax: {
                url: publisherSearchUrl,
                dataType: 'json',
                type: 'POST',
                data: function (params) {
                    return {
                        searchText: params.term
                    };
                },
                processResults: function (data, params) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.displayMessage('danger', data.error);
                    } else {
                        return {
                            results: $.map(data, function (item) {
                                return {
                                    text: item.name,
                                    id: item.id
                                }
                            })
                        };
                    }
                },
                cache: false
            },
            minimumInputLength: 2,
            maximumSelectionLength: 6
        });
        var genreSearchUrl = '{$routes->getRouteString("genreSearchPublic",[])}';
        $("#genres").select2({
            ajax: {
                url: genreSearchUrl,
                dataType: 'json',
                type: 'POST',
                data: function (params) {
                    return {
                        searchText: params.term
                    };
                },
                processResults: function (data, params) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.displayMessage('danger', data.error);
                    } else {
                        return {
                            results: $.map(data, function (item) {
                                return {
                                    text: item.name,
                                    id: item.id
                                }
                            })
                        };
                    }
                },
                cache: false
            },
            minimumInputLength: 2,
            maximumSelectionLength: 6
        });
        var authorSearchUrl = '{$routes->getRouteString("authorSearchPublic",[])}';
        $("#authors").select2({
            ajax: {
                url: authorSearchUrl,
                dataType: 'json',
                type: 'POST',
                data: function (params) {
                    return {
                        searchText: params.term
                    };
                },
                processResults: function (data, params) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.displayMessage('danger', data.error);
                    } else {
                        return {
                            results: $.map(data, function (item) {
                                if(item.firstName) {
                                    var text = item.firstName + ' ' + item.lastName;
                                } else {
                                    text = item.lastName;
                                }
                                return {
                                    text: text,
                                    id: item.id
                                }
                            })
                        };
                    }
                },
                cache: false
            },
            minimumInputLength: 2,
            maximumSelectionLength: 6
        });
        $("#bindings").select2({
            maximumSelectionLength: 6
        });
        $('#filterIt').on('click', function (e) {
            e.preventDefault();
            var url = '{$routes->getRouteString("booksPublic")}';
            var form = $('#book-filter');
            $.ajax({
                dataType: 'json',
                method: 'POST',
                data: $('#book-filter, #books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
                url: url,
                beforeSend: function (data) {
                    $('#preloader-book').show();
                },
                success: function (data) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.displayMessage('danger', data.error);
                    } else {
                        $('.books-list').html(data.html);
                    }
                },
                error: function (jqXHR, exception) {
                    app.displayMessage('danger', app.getErrorMessage(jqXHR, exception));
                },
                complete: function (data) {
                    $('#preloader-book').hide();
                }
            });
        });
    </script>
{/block}