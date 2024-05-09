{extends file='public.tpl'}
{block name=metaTitle}{t}Publisher{/t}: {$publisher->getName()}{/block}
{block name=metaDescription}{/block}
{block name=metaKeywords}{/block}
{block name=headerCss append}

{/block}
{block name=content}
    <div class="single-publisher">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center mb-3">
                        <h1>{t}Publisher{/t}: {$publisher->getName()}</h1>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="books-list">
                        {include 'books/books-list.tpl' size_grid="col-sm-12 col-md-6 col-lg-4" books_row="book-3-row"}
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerJs append}

{/block}
{block name=customJs append}
    <script>
        $(document).on('change', '#countPerPage', function (e) {
            var url = '{$routes->getRouteString("booksPublic")}';
            $.ajax({
                type: "POST",
                url: url,
                data: $('#book-filter, #books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order') + '&books_row=book-3-row&size_grid=col-sm-12+col-md-6+col-lg-4',
                beforeSend: function () {
                    $('#preloader-book').show();
                },
                success: function (data) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.notification('danger', data.error);
                    } else {
                        $('.books-list').html(data.html);
                    }
                },
                complete: function () {
                    $('#preloader-book').hide();
                },
                error: function (jqXHR, exception) {
                    app.notification('danger', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
        $(document).on('change', '#books-sort', function (e) {
            var url = '{$routes->getRouteString("booksPublic")}';
            $.ajax({
                type: "POST",
                url: url,
                data: $('#book-filter, #books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order') + '&books_row=book-3-row&size_grid=col-sm-12+col-md-6+col-lg-4',
                beforeSend: function () {
                    $('#preloader-book').show();
                },
                success: function (data) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.notification('danger', data.error);
                    } else {
                        $('.books-list').html(data.html);
                    }
                },
                complete: function () {
                    $('#preloader-book').hide();
                },
                error: function (jqXHR, exception) {
                    app.notification('danger', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
        $(document).on('click', '.ajax-page', function (e) {
            e.preventDefault();
            $.ajax({
                type: "POST",
                dataType: 'json',
                data: $('#book-filter, #books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order') + '&books_row=book-3-row&size_grid=col-sm-12+col-md-6+col-lg-4',
                url: $(this).attr('href'),
                beforeSend: function () {
                    $('#preloader-book').show();
                },
                success: function (data) {
                    app.ajax_redirect(data);
                    if (data.error) {
                        app.notification('danger', data.error);
                    } else {
                        $('.books-list').html(data.html);
                    }
                },
                complete: function () {
                    $('#preloader-book').hide();
                },
                error: function (jqXHR, exception) {
                    app.notification('danger', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
    </script>
{/block}