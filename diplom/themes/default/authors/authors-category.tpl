{extends file='public.tpl'}
{block name=metaTitle}{$author->getFirstName()} {$author->getLastName()}{/block}
{block name=metaDescription}{/block}
{block name=metaKeywords}{/block}
{block name=headerCss append}{/block}
{block name=content}
    <section class="single-author">
        <div class="container">
            <div class="row author">
                <div class="col-lg-12">
                    <div class="author-photo m-auto">
                        {if $author->getPhoto() != null}
                            <img src="{$author->getPhoto()->getWebPath('medium')}" alt="{$author->getLastName()} {$author->getFirstName()}" class="img-fluid">
                        {else}
                            <img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="{$author->getLastName()} {$author->getFirstName()}" class="img-fluid">
                        {/if}
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="author-info">
                        <h1>{$author->getFirstName()} {$author->getLastName()}</h1>
                        <div class="description-author more">
                            {if $author->getDescription() != null}
                                {$author->getDescription()}
                            {else}
                                <div class="text-center">{t}Information about the author{/t} {$author->getFirstName()} {$author->getLastName()} {t}will soon be added to the site.{/t}</div>
                            {/if}
                        </div>
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
    </section>
{/block}
{block name=footerJs append}
    <script src="{$themePath}resources/js/readmore.min.js"></script>
{/block}
{block name=customJs append}
    <script>
        $('.description-author').readmore({
            speed: 75,
            moreLink: '<a href="#">{t}read more ...{/t}</a>',
            lessLink: '<a href="#">{t}read less{/t}</a>'
        });

        $(document).on('change', '#countPerPage', function (e) {
            var url = '{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}';
            $.ajax({
                type: "POST",
                url: url,
                dataType: 'json',
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
            var url = '{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}';
            $.ajax({
                type: "POST",
                url: url,
                dataType: 'json',
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