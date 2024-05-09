{extends file='public.tpl'}
{block name=metaTitle}{$author->getFirstName()} {$author->getLastName()}{/block}
{block name=metaDescription}{/block}
{block name=metaKeywords}{/block}
{block name=headerCss append}{/block}
{block name=content}
    <div class="page">
        <div class="container">
            <div class="row category author mb-3">
                <div class="col-md-2">
                    <div class="author">
                        {if $author->getPhoto() != null}
                            <img src="{$author->getPhoto()->getWebPath('medium')}" alt="{$author->getLastName()} {$author->getFirstName()}">
                        {else}
                            <img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="{$author->getLastName()} {$author->getFirstName()}">
                        {/if}
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="author-info">
                        <h1>{$author->getFirstName()} {$author->getLastName()}</h1>
                        {if isset($user) and $user->getRole() != null and $user->getRole()->getPriority() > 200}
                            <a href="{$routes->getRouteString("authorEdit",["authorId"=>$author->getId()])}"><i class="ion-edit" aria-hidden="true"></i> {t}Edit Author{/t}
                            </a>
                        {/if}
                        <div class="description-author more">
                            {if $author->getDescription() != null}
                                {$author->getDescription()}
                            {else}
                                {t}Information about the author{/t} {$author->getFirstName()} {$author->getLastName()} {t}will soon be added to the site.{/t}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="books-list">
                        {include 'books/books-list.tpl' size_grid="col-sm-12 col-md-4 col-lg-2"}
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerJs append}
    <script src="{$themePath}resources/js/plugins/readMoreJS/readMoreJS.min.js"></script>
{/block}
{block name=customJs append}
    <script>
        $readMoreJS.init({
            target: '.description-author',
            numOfWords: 80,
            toggle: true,
            moreLink: '{t}read more ...{/t}',
            lessLink: '{t}read less{/t}'
        });

        $(document).on('change', '#countPerPage', function (e) {
            var url = '{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}';
            $.ajax({
                type: "POST",
                url: url,
                dataType: 'json',
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
            var url = '{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}';
            $.ajax({
                type: "POST",
                url: url,
                dataType: 'json',
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
    </script>
{/block}