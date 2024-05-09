{extends file='public.tpl'}
{block name=metaTitle}{if $book->getMetaTitle() !== null}{$book->getMetaTitle()}{else}{$book->getTitle()}{/if}{/block}
{block name=metaDescription}{$book->getMetaDescription()|replace:'"':''}{/block}
{block name=metaKeywords}{$book->getMetaKeywords()}{/block}
{block name=headerCss append}{/block}
{assign var="pageURL" value="{$SiteURL}{$smarty.server.REQUEST_URI}"}
{block name=content}
    <div class="page single-book" data-book="{$book->getId()}">
        <div class="row">
            <div class="col-md-3 col-sm-12 col-xs-12">
                <div class="book-img">
                    {if $book->getCover() != null}
                        <img src="{$book->getCover()->getWebPath('medium')}" alt="{$book->getTitle()}">
                    {else}
                        <img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="{$book->getTitle()}">
                    {/if}
                </div>
                {if isset($smarty.server.REQUEST_URI)}
                    <div class="social-btns text-center">
                        <a class="btn facebook" href="https://www.facebook.com/share.php?u={$pageURL}&title={$book->getTitle()}" target="blank"><i class="fa fa-facebook"></i></a>
                        <a class="btn twitter" href="https://twitter.com/intent/tweet?status={$book->getTitle()}+{$pageURL}" target="blank"><i class="fa fa-twitter"></i></a>
                        <a class="btn google" href="https://plus.google.com/share?url={$pageURL}" target="blank"><i class="fa fa-google"></i></a>
                        <a class="btn vk" href="http://vk.com/share.php?url={$pageURL}" target="blank"><i class="fa fa-vk"></i></a>
                        <a class="btn pinterest" href="http://pinterest.com/pin/create/button/?url={$pageURL}&description={$book->getTitle()}" target="blank"><i class="fa fa-pinterest"></i></a>
                    </div>
                {/if}
                {if $book->getEBookId() != null}
                    {if $siteViewOptions->getOptionValue("showDownloadLink") or (isset($user) and $user->getRole() != null and $user->getRole()->getPriority() > 100)}
                        <a href="{$routes->getRouteString("electronicBookGet",["electronicBookId"=>$book->getEBookId()])}" class="btn btn-outline-info btn-block mt-2"><i class="fa fa-download" aria-hidden="true"></i> {t}Download{/t}
                        </a>
                    {/if}
                    <a href="{$routes->getRouteString("electronicBookView",["bookId"=>$book->getId()])}" class="btn btn-outline-info btn-block mt-2"><i class="fa fa-eye" aria-hidden="true"></i> {t}Read{/t}
                    </a>
                {/if}
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
                <div class="main-content">
                    <h1 class="">{$book->getTitle()}{if $book->getSubTitle() != null} {$book->getSubTitle()}{/if}</h1>
                    <p class="book-year">{$book->getPublishingYear()}</p>
                    <div class="book-rating">
                        {if !empty($book->getRating())}
                            {assign var=tooltipMessage value="{$book->getRating()} {t}Average Book Rating{/t}"}
                        {else}
                            {assign var=tooltipMessage value="{t}Be the first to vote{/t}"}
                        {/if}

                        {if !isset($user) or isset($userBookRating)}
                            {assign var=isRead value=true}
                        {/if}

                        {include 'books/rating.tpl' rating=$book->getRating() readOnly=$isRead tooltipMessage=$tooltipMessage showTooltip=true}

                        <div class="whole-rating d-inline-block">
                            <span>{$book->getBookRatingVotesNumber()}</span> {t}Votes{/t}{if isset($userBookRating)}, {t}Your mark is {/t}
                                <strong class="font-weight-bold">{$userBookRating}</strong>
                                .{/if}
                        </div>
                    </div>
                    {if isset($user) and $user->getRole() != null and $user->getRole()->getPriority() > 200}
                        <p>
                            <a href="{$routes->getRouteString("bookEdit",["bookId"=>$book->getId()])}"><i class="ion-edit" aria-hidden="true"></i> {t}Edit Book{/t}
                            </a>
                        </p>
                    {/if}
                    {if $book->getDescription()}
                        <div class="sub-title">
                            <h4>{t}Description{/t}</h4>
                        </div>
                        <div class="book-description">
                            {$book->getDescription()}
                        </div>
                    {/if}
                </div>
            </div>
            <div class="col-md-3 col-xs-12 col-sm-12">
                {if $book->getSeries() != null}
                    <div class="book-additional-info">
                        <h6>{t}Series:{/t} </h6>
                        <p>
                            <a href="{$routes->getRouteString("seriesBooksPublic",["seriesId"=>$book->getSeries()->getId()])}">{$book->getSeries()->getName()}</a>
                        </p>
                    </div>
                {/if}
                {if $book->getPublisher() != null}
                    <div class="book-additional-info">
                        <h6>{t}Publisher:{/t} </h6>
                        <p>
                            <a href="{$routes->getRouteString("publisherBooksPublic",["publisherId"=>$book->getPublisher()->getId()])}">{$book->getPublisher()->getName()}</a>
                        </p>
                    </div>
                {/if}
                {if $book->getGenres() !== null and is_array($book->getGenres()) and count($book->getGenres()) > 0}
                    <div class="book-additional-info">
                        <h6>{t}Genres:{/t} </h6>
                        <p>
                            {foreach from=$book->getGenres() item=genre name=genre}
                                <a href="{$routes->getRouteString("genreBooksPublic",["genreId"=>$genre->getId()])}">{$genre->getName()}</a>{if $smarty.foreach.genre.last}{else},{/if}
                            {/foreach}
                        </p>
                    </div>
                {/if}
                {if $book->getAuthors() !== null and is_array($book->getAuthors()) and count($book->getAuthors()) > 0}
                    <div class="book-additional-info">
                        <h6>{t}Authors:{/t} </h6>
                        <p>
                            {foreach from=$book->getAuthors() item=author name=author}
                                <a href="{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}">{$author->getLastName()} {$author->getFirstName()}</a>{if $smarty.foreach.author.last}{else},{/if}
                            {/foreach}
                        </p>
                    </div>
                {/if}
                {if $book->getPages() != null}
                    <div class="book-additional-info">
                        <h6>{t}Pages:{/t} </h6>
                        <p>
                            {$book->getPages()}
                        </p>
                    </div>
                {/if}

                {if $book->getBinding() !== null}
                    <div class="book-additional-info">
                        <h6>{t}Binding:{/t} </h6>
                        <p>
                            {if $book->getBinding() == 'Softcover'}{t}Softcover{/t}{/if}
                            {if $book->getBinding() == 'Hardcover'}{t}Hardcover{/t}{/if}
                        </p>
                    </div>
                {/if}
                {if $book->getISBN10() != null}
                    <div class="book-additional-info">
                        <h6>{t}ISBN10:{/t} </h6>
                        <p>
                            {$book->getISBN10()}
                        </p>
                    </div>
                {/if}
                {if $book->getISBN13() != null}
                    <div class="book-additional-info">
                        <h6>{t}ISBN13:{/t} </h6>
                        <p>
                            {$book->getISBN13()}
                        </p>
                    </div>
                {/if}
            </div>
            <div class="col-lg-12">
                {if strcmp($siteViewOptions->getOptionValue("reviewCreator"),"Nobody") != 0 or ($book->getReviews() != null and count($book->getReviews()) > 0)}
                    <div class="row mt-5 mb-3">
                        <div class="col-lg-6 col-6">
                            <h2>{t}Reviews{/t}</h2>
                        </div>
                        <div class="col-lg-6 col-6 text-right">
                            {if $siteViewOptions->getOptionValue("reviewCreator") == "Everybody" or ($siteViewOptions->getOptionValue("reviewCreator") == "User" and isset($user))}
                                <button class="btn btn-primary btn-rounded shadow add-review-collapse" data-toggle="collapse" data-target="#addReview" aria-expanded="false" aria-controls="addReview">{t}Write a review{/t}</button>
                            {/if}
                        </div>
                    </div>
                {/if}
                {*t}Review creation is allowed to registered users only.{/t*}
                {if $siteViewOptions->getOptionValue("reviewCreator") == "Everybody" or ($siteViewOptions->getOptionValue("reviewCreator") == "User" and isset($user))}
                    <form class="add-review validate-review collapse" id="addReview">
                        <div class="row">
                            {if $siteViewOptions->getOptionValue("reviewCreator") == "Everybody" and !isset($user)}
                                <div class="col-lg-12">
                                    <div class="notes">{t}Required fields are marked *. Your email address will not be published.{/t}</div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <input name="name" class="form-control" placeholder="{t}Name{/t} *" type="text">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <input name="email" class="form-control" placeholder="{t}Email{/t} *" type="text">
                                    </div>
                                </div>
                            {/if}
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <input type="hidden" name="bookId" value="{$book->getId()}">
                                    <textarea name="text" cols="30" rows="5" class="form-control" placeholder="{t}Review{/t} *"></textarea>
                                </div>
                            </div>
                            <div class="col-lg-12 text-center">
                                <button class="btn btn-primary shadow submit-review">{t}Submit{/t}</button>
                            </div>
                        </div>
                    </form>
                {/if}
                {if $book->getReviews() != null}
                    <div class="reviews">
                        {foreach from=$book->getReviews() item=review name=review}
                            <div class="review">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <strong class="review-user">
                                            {if $review->getUserId() != null and $review->getUser() != null}
                                                {$review->getUser()->getFirstName()} {$review->getUser()->getLastName()}
                                            {else}
                                                {$review->getName()}
                                            {/if}
                                        </strong>
                                        <span class="review-meta">{$review->getCreationDateTime()|date_format:$siteViewOptions->getOptionValue("dateFormat")}</span>
                                    </div>
                                    <div class="col-lg-6">
                                        {if $review->getBookRating() != null}
                                            <div class="review-rating">
                                                {include 'books/rating.tpl' rating=$review->getBookRating() readOnly=true}
                                            </div>
                                        {/if}
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="review-content">
                                            {$review->getText()}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                {/if}
            </div>
        </div>
    </div>
{/block}
{block name=footerJs append}
    <script type='text/javascript' src="{$themePath}resources/js/plugins/jquery-validate/jquery.validate.js"></script>
{/block}
{block name=customJs append}
    <script>
        app.bootstrap_tooltip();
        $('.rating-stars:not(.readOnly) li').on('mouseover', function () {
            var onStar = parseInt($(this).data('value'), 10);
            $(this).parent().children('li.star').each(function (e) {
                if (e < onStar) {
                    $(this).addClass('hover');
                }
                else {
                    $(this).removeClass('hover');
                }
            });

        }).on('mouseout', function () {
            $(this).parent().children('li.star').each(function (e) {
                $(this).removeClass('hover');
            });
        });

        $('.rating-stars:not(.readOnly) li').on('click', function () {
            var _this = $(this);
            var onStar = parseInt($(this).data('value'), 10);
            var stars = $(this).parent().children('li.star');
            var bookId = $('.single-book').data('book');
            var url = '/book/[bookId]/set-rating/[rating]';
            url = url.replace('[bookId]', bookId);
            for (i = 0; i < stars.length; i++) {
                $(stars[i]).removeClass('selected');
            }

            for (i = 0; i < onStar; i++) {
                $(stars[i]).addClass('selected');
            }

            if (bookId = !null) {
                $.ajax({
                    dataType: 'json',
                    method: 'POST',
                    url: url.replace('[rating]', onStar),
                    success: function (data) {
                        if (data.redirect) {
                            app.ajax_redirect(data.redirect);
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                $('.rating-stars:not(.readOnly) li').unbind();
                                $(_this).closest('ul').addClass('readOnly').find('.star').removeClass('hover');
                            }
                        }
                    },
                    error: function (jqXHR, exception) {
                        app.notification('error', data.error);
                    }
                });
            }
        });

        {if strcmp($siteViewOptions->getOptionValue("reviewCreator"),"Nobody") != 0}
        $(".validate-review").validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                name: {
                    required: true
                }
            }
        });
        var reviewCreatePublicUrl = '{$routes->getRouteString("reviewCreatePublic")}';
        $('.submit-review').on('click', function (e) {
            e.preventDefault();
            var form = $(this).closest('.add-review');
            if (form.valid()) {
                $.ajax({
                    dataType: 'json',
                    method: 'POST',
                    data: $(form).serialize(),
                    url: reviewCreatePublicUrl,
                    beforeSend: function (data) {
                        $(form).append('<div class="form-message"><i class="fa fa-spinner fa-spin"></i><span class="sr-only">{t}Loading...{/t}</span> {t}Sending, Please Wait..{/t} </div>');
                    },
                    success: function (data) {
                        if (data.redirect) {
                            app.ajax_redirect(data.redirect);
                        } else {
                            if (data.error) {
                                $(form).find('.form-message').addClass('error').text(data.error);
                            } else {
                                $(form).find('.form-message').addClass('success').text(data.success);
                                $(form).find('input, textarea').val('');
                            }
                        }
                    },
                    error: function (jqXHR, exception) {
                        $(form).find('.form-message').addClass('error').text('{t}Failed to send your message. Please try later or contact the administrator{/t} {$siteViewOptions->getOptionValue("adminEmail")}');
                    },
                    complete: function (data) {
                        setTimeout(function () {
                            $(form).find('.form-message').fadeOut().remove();
                            $('#addReview').collapse('hide');
                        }, 5000);
                    }
                });
            }
        });

        {/if}

    </script>
{/block}