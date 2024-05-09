{extends file='public.tpl'}
{block name=metaTitle}{t}You were looking for{/t} '{$searchText}'{/block}
{block name=metaDescription}{/block}
{block name=metaKeywords}{/block}
{block name=headerCss append}

{/block}
{block name=content}
    <div class="page">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-uppercase text-center mt-1 mb-5">
                        <h1>{t}You were looking for{/t} '<strong>{$searchText}</strong>'</h1>
                    </div>
                    <input type="hidden" name="searchText" id="searchText" value="{$searchText}">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="books-list">
                        {include 'books/books-list.tpl' size_grid="col-sm-6 col-md-4 col-lg-2"}
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerJs append}{/block}
{block name=customJs append}
    <script>
        $(document).on('change', '#countPerPage', function (e) {
            var url = '{$routes->getRouteString("booksPublic")}';
            $.ajax({
                type: "POST",
                url: url,
                data: $('#book-filter, #books-sort, #countPerPage, #searchText').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
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
                data: $('#book-filter, #books-sort, #countPerPage, #searchText').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
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
                data: $('#book-filter, #books-sort, #countPerPage, #searchText').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
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
    </script>
{/block}