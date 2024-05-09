{extends file='admin/admin.tpl'}
{block name=title}{t}Books{/t}{/block}
{block name=toolbar}
{/block}
{block name=headerCss append}
    <link href="{$resourcePath}assets/css/plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet"/>
{/block}
{block name=content}
    <div class="row">
        <div class="col-md-12">
            <div class="card" id="books-block">
                {include 'admin/books/userBooks-list.tpl'}
            </div>
        </div>
    </div>
{/block}
{block name=footerPageJs append}
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-select/bootstrap-select.js"></script>
{/block}
{block name=footerCustomJs append}
    <script>
        $(document).on('change', '#countPerPage', function (e) {
            var url = '{$routes->getRouteString("userBooksView")}';
            $.ajax({
                type: "POST",
                url: url,
                data: $('#books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
                dataType: 'json',
                beforeSend: function () {
                    app.card.loading.start('#books-block');
                },
                success: function (data) {
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    } else {
                        if (data.error) {
                            app.notification('error', data.error);
                        } else {
                            $('#books-block').html(data.html);
                            app.bootstrap_select();
                            app.tooltip_popover();
                        }
                    }
                },
                complete: function () {
                    app.card.loading.finish('#books-block');
                },
                error: function (jqXHR, exception) {
                    app.notification('error', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
        $(document).on('change', '#books-sort', function (e) {
            var url = '{$routes->getRouteString("userBooksView")}';
            $.ajax({
                type: "POST",
                url: url,
                data: $('#books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
                dataType: 'json',
                beforeSend: function () {
                    app.card.loading.start('#books-block');
                },
                success: function (data) {
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    } else {
                        if (data.error) {
                            app.notification('error', data.error);
                        } else {
                            $('#books-block').html(data.html);
                            app.bootstrap_select();
                            app.tooltip_popover();
                        }
                    }
                },
                complete: function () {
                    app.card.loading.finish('#books-block');
                },
                error: function (jqXHR, exception) {
                    app.notification('error', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
        $(document).on('click', '.ajax-page', function (e) {
            e.preventDefault();
            $.ajax({
                type: "POST",
                data: $('#books-sort, #countPerPage').serialize() + '&sortOrder=' + $('option:selected', '#books-sort').attr('data-order'),
                dataType: 'json',
                url: $(this).attr('href'),
                beforeSend: function () {
                    app.card.loading.start('#books-block');
                },
                success: function (data) {
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    } else {
                        if (data.error) {
                            app.notification('error', data.error);
                        } else {
                            $('#books-block').html(data.html);
                            app.bootstrap_select();
                            app.tooltip_popover();
                        }
                    }
                },
                complete: function () {
                    app.card.loading.finish('#books-block');
                },
                error: function (jqXHR, exception) {
                    app.notification('error', app.getErrorMessage(jqXHR, exception));
                }
            });
        });
    </script>
{/block}