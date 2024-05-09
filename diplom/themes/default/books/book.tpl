{extends file='public.tpl'}
{block name=metaTitle}{if $book->getMetaTitle() !== null}{$book->getMetaTitle()}{else}{$book->getTitle()}{/if}{/block}
{block name=metaDescription}{$book->getMetaDescription()|replace:'"':''}{/block}
{block name=metaKeywords}{$book->getMetaKeywords()}{/block}
{block name=headerCss append}{/block}
{assign var="pageURL" value="{$SiteURL}{$smarty.server.REQUEST_URI}"}
{block name=headerPrefix}prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# books: http://ogp.me/ns/books#"{/block}
{block name=socialNetworksMeta append}
    {if $book != null}
        <meta property="og:type" content="books.book"/>
        <meta property="og:title" content="{$book->getTitle()}"/>
        <meta property="og:image" content="{$SiteURL}{if $book->getCover() != null}{$book->getCover()->getWebPath('')}{else}{$siteViewOptions->getOptionValue("noBookImageFilePath")}{/if}"/>
        <meta property="og:description" content="{$book->getDescription()|strip_tags:true|strip|truncate:255}"/>
        <meta property="og:url" content="{$pageURL}"/>
        {if $book->getAuthors() !== null and is_array($book->getAuthors()) and count($book->getAuthors()) > 0}
            {foreach from=$book->getAuthors() item=author name=author}
                <meta property="book:author" content="{$author->getLastName()} {$author->getFirstName()}">
            {/foreach}
        {/if}
        {if $book->getISBN13() != null}
            <meta property="book:isbn" content="{$book->getISBN13()}">
        {elseif $book->getISBN10() != null}
            <meta property="book:isbn" content="{$book->getISBN10()}">
        {/if}
        {if $book->getPublishingYear() != null}
            <meta property="book:release_date" content="{$book->getPublishingYear()}">
        {/if}
    {/if}
{/block}
{block name=content}
    <section class="single-book" data-book="{$book->getId()}" itemscope itemtype="http://schema.org/Book">
        <meta itemprop="url" content="{$smarty.server.REQUEST_URI}"/>
        {if $book->getAuthors() !== null and is_array($book->getAuthors()) and count($book->getAuthors()) > 0}
            {foreach from=$book->getAuthors() item=author name=author}
                <meta itemprop="author" content="{$author->getLastName()} {$author->getFirstName()}"/>
            {/foreach}
        {/if}
        {if $book->getPublisher() != null}
            <meta itemprop="publisher" content="{$book->getPublisher()->getName()}"/>
        {/if}

        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="sticky-left-column">
                        <div class="book-cover">
                            {if $book->getCover() != null}
                                <img src="{$book->getCover()->getWebPath('')}" alt="{$book->getTitle()}" class="img-fluid" itemprop="image">
                            {else}
                                <img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="{$book->getTitle()}" class="img-fluid" itemprop="image">
                            {/if}
                            {if isset($user) and $user->getRole() != null and $user->getRole()->getPriority() >= 200}
                                <a href="{$routes->getRouteString("bookEdit",["bookId"=>$book->getId()])}" class="edit-book" title="{t}Edit Book{/t}"><i class="ti-pencil" aria-hidden="true"></i></a>
                            {/if}
                        </div>
                        {if isset($smarty.server.REQUEST_URI)}
                            <div class="social-btns">
                                <a class="btn facebook" href="https://www.facebook.com/share.php?u={$pageURL}&title={$book->getTitle()}" target="blank"><i class="fab fa-facebook-f"></i></a>
                                <a class="btn twitter" href="https://twitter.com/intent/tweet?status={$book->getTitle()}+{$pageURL}" target="blank"><i class="fab fa-twitter"></i></a>
                                <a class="btn google" href="https://plus.google.com/share?url={$pageURL}" target="blank"><i class="fab fa-google"></i></a>
                                <a class="btn vk" href="http://vk.com/share.php?url={$pageURL}" target="blank"><i class="fab fa-vk"></i></a>
                                <a class="btn pinterest" href="http://pinterest.com/pin/create/button/?url={$pageURL}&description={$book->getTitle()}" target="blank"><i class="fab fa-pinterest"></i></a>
                            </div>
                        {/if}
                        {if $book->getEBookId() != null}
                            <div class="book-links">
                                {if $siteViewOptions->getOptionValue("showDownloadLink") or (isset($user) and $user->getRole() != null and $user->getRole()->getPriority() >= 100)}
                                    <a href="{$routes->getRouteString("electronicBookGet",["electronicBookId"=>$book->getEBookId()])}" class="btn btn-primary shadow download-link"><i class="ti-download mr-1" aria-hidden="true"></i> {t}Download{/t}
                                    </a>
                                {/if}
                                <a href="{$routes->getRouteString("electronicBookView",["bookId"=>$book->getId()])}" class="btn btn-primary shadow read-link"><i class="fas fa-book mr-1"></i> {t}Read{/t}
                                </a>
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="col-lg-9">
                    <h1 itemprop="name">{$book->getTitle()}{if $book->getSubTitle() != null} {$book->getSubTitle()}{/if}</h1>
                    {if $book->getPublishingYear() != null}
                        <div class="book-year" itemprop="datePublished">{$book->getPublishingYear()}</div>
                    {/if}
                    <div class="book-rating general" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                        {include 'books/rating.tpl' rating=$book->getRating()}
                        <div class="whole-rating">
                            <span class="average">{$book->getRating()|number_format:2:".":","} {t}Avg rating{/t}</span><span class="separator">—</span><span>{$book->getBookRatingVotesNumber()}</span> {t}Votes{/t}
                        </div>
                        <meta itemprop="ratingValue" content="{$book->getRating()|number_format:2:".":","}"/>
                        <meta itemprop="ratingCount" content="{$book->getBookRatingVotesNumber()}"/>
                    </div>

                    <table class="table book-meta">
                        <tbody>
                            <tr>
                                <td>{t}Series:{/t}</td>
                                <td>
                                    {if $book->getSeries() != null}
                                        <a href="{$routes->getRouteString("seriesBooksPublic",["seriesId"=>$book->getSeries()->getId()])}">{$book->getSeries()->getName()}</a>
                                    {else}
                                        {t}NA{/t}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td>{t}Publisher:{/t}</td>
                                <td>
                                    {if $book->getPublisher() != null}
                                        <a href="{$routes->getRouteString("publisherBooksPublic",["publisherId"=>$book->getPublisher()->getId()])}" itemprop="publisher">{$book->getPublisher()->getName()}</a>
                                    {else}
                                        {t}NA{/t}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td>{t}Genres:{/t}</td>
                                <td>
                                    {if $book->getGenres() !== null and is_array($book->getGenres()) and count($book->getGenres()) > 0}
                                        {foreach from=$book->getGenres() item=genre name=genre}
                                            <a href="{$routes->getRouteString("genreBooksPublic",["genreId"=>$genre->getId()])}">{$genre->getName()}</a>{if $smarty.foreach.genre.last}{else},{/if}
                                        {/foreach}
                                    {else}
                                        {t}NA{/t}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td>{t}Authors:{/t}</td>
                                <td>
                                    {if $book->getAuthors() !== null and is_array($book->getAuthors()) and count($book->getAuthors()) > 0}
                                        {foreach from=$book->getAuthors() item=author name=author}
                                            <a href="{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}" itemprop="author">{$author->getLastName()} {$author->getFirstName()}</a>{if $smarty.foreach.author.last}{else},{/if}
                                        {/foreach}
                                    {else}
                                        {t}NA{/t}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td>{t}Pages:{/t}</td>
                                <td>
                                    {if $book->getPages() != null}
                                        <span itemprop="numberOfPages">{$book->getPages()} {t}pages{/t}</span>
                                    {else}
                                        {t}NA{/t}
                                    {/if}
                                </td>
                            </tr>
                            <tr>
                                <td>{t}Binding:{/t}</td>
                                <td>
                                    {if $book->getBinding() !== null}
                                        {$book->getBinding()}
                                    {else}
                                        {t}NA{/t}
                                    {/if}
                                </td>
                            </tr>
                            {if $book->getISBN10() != null}
                                <tr>
                                    <td>{t}ISBN10:{/t}</td>
                                    <td>{$book->getISBN10()}</td>
                                </tr>
                            {/if}
                            {if $book->getISBN13() != null}
                                <tr>
                                    <td>{t}ISBN13:{/t}</td>
                                    <td>
                                        <spna itemprop="isbn">{$book->getISBN13()}</spna>
                                    </td>
                                </tr>
                            {/if}
                        </tbody>
                    </table>
                    {if $book->getDescription()}
                        <div class="book-description" itemprop="description">
                            {$book->getDescription()}
                        </div>
                    {/if}

                    {if strcmp($siteViewOptions->getOptionValue("reviewCreator"),"Nobody") != 0 or ($book->getReviews() != null and count($book->getReviews()) > 0)}
                        <div class="row mt-5 mb-3">
                            <div class="col-lg-6 col-6">
                                {if ($book->getReviews() != null and count($book->getReviews()) > 0) or ($siteViewOptions->getOptionValue("reviewCreator") == "Everybody" or ($siteViewOptions->getOptionValue("reviewCreator") == "User" and isset($user)))}
                                    <h2>{t}Reviews{/t}</h2>
                                {/if}
                            </div>
                            <div class="col-lg-6 col-6 {if $activeLanguage->isRTL()}text-left{else}text-right{/if}">
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
                                {if isset($user)}
                                    <div class="col-lg-12 mb-3 {if $activeLanguage->isRTL()}text-right{/if}">
                                        <div class="rate-book">
                                            {t}Rate this book{/t}
                                        </div>
                                        {if isset($userBookRating)}
                                            <div class="book-rating user-rating">
                                                {for $ratingIndex=1 to 5}
                                                    <i class="fas fa-star{if $userBookRating == $ratingIndex} active{/if}" data-value="{$ratingIndex}"></i>
                                                {/for}
                                                <div class="save-rating">{t}saving{/t}...</div>
                                            </div>
                                            <div class="user-mark"> {t}Your mark is {/t}
                                                <strong class="font-weight-bold">{$userBookRating}</strong>.
                                            </div>
                                        {else}
                                            <div class="book-rating user-rating">
                                                <i class="far fa-star" data-value="1"></i>
                                                <i class="far fa-star" data-value="2"></i>
                                                <i class="far fa-star" data-value="3"></i>
                                                <i class="far fa-star" data-value="4"></i>
                                                <i class="far fa-star" data-value="5"></i>
                                                <div class="save-rating">{t}saving{/t}...</div>
                                            </div>
                                            <div class="user-mark off"> {t}Your mark is {/t}
                                                <strong class="font-weight-bold">{$userBookRating}</strong>.
                                            </div>
                                        {/if}
                                    </div>
                                {/if}
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
                                        <textarea name="text" cols="30" rows="5" class="form-control" placeholder="{t}Review{/t}"></textarea>
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
                                        <div class="col-lg-6 {if $activeLanguage->isRTL()}text-right{/if}">
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

    </section>
{/block}
{block name=footerJs append}
    <script type='text/javascript' src="{$themePath}resources/js/readmore.min.js"></script>
    <script type='text/javascript' src="{$themePath}resources/js/jquery.validate.js"></script>
{/block}
{block name=customJs append}
    <script>
        $(".user-rating i").hover(function () {
            var container = $(this).parent();
            var $this = $(this);
            $this.nextAll('i').removeClass('fas').addClass("far");
            $this.prevUntil("div").removeClass("far").addClass('fas');
            $this.removeClass("far").addClass('fas');
        });
        $(".user-rating i").mouseout(function () {
            var container = $(this).parent();
            var select = $(container).find('.active');
            select.nextAll('i').removeClass('fas').addClass('far');
            select.prevUntil("div").removeClass('far').addClass('fas');
            select.removeClass('far').addClass('fas');
            if (container.find('i.active').length == 0) {
                container.find('i').removeClass('fas').addClass('far');
            }
        });
        $(".user-rating i").click(function () {
            $(this).addClass('active').siblings().removeClass('active');
            $(this).removeClass('far').addClass('fas');
            $(this).prevUntil("").removeClass('far').addClass('fas');
            $(this).nextAll('i').removeClass('fas').addClass('far');

            var starValue = $(this).data('value');
            var stars = $(this).parent().children('i');
            var text = $(this).parent().find('.save-rating');
            var bookId = $('.single-book').data('book');
            var url = '/book/[bookId]/set-rating/[rating]';
            url = url.replace('[bookId]', bookId).replace('[rating]', starValue);

            if (bookId = !null) {
                $.ajax({
                    dataType: 'json',
                    method: 'POST',
                    url: url,
                    beforeSend: function () {
                        $(stars).hide();
                        $(text).addClass('on');
                    },
                    success: function (data) {
                        if (data.redirect) {
                            app.ajax_redirect(data.redirect);
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                $('.user-mark').removeClass('off');
                                $('.user-mark strong').text(starValue);
                                //calculatedRating
                            }
                        }
                    },
                    error: function (jqXHR, exception) {
                        app.notification('error', data.error);
                    },
                    complete: function () {
                        $(stars).show();
                        $(text).removeClass('on');
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
                        $(form).after('<div class="form-message"><i class="fa fa-spinner fa-spin"></i><span class="sr-only">{t}Loading...{/t}</span> {t}Sending, Please Wait..{/t} </div>');
                    },
                    success: function (data) {
                        if (data.redirect) {
                            app.ajax_redirect(data.redirect);
                        } else {
                            if (data.error) {
                                $('.form-message').addClass('error').text(data.error);
                            } else {
                                $('.form-message').addClass('success').text(data.success);
                                $(form).find('input, textarea').val('');
                            }
                        }
                    },
                    error: function (jqXHR, exception) {
                        $('.form-message').addClass('error').text('{t}Failed to send your message. Please try later or contact the administrator{/t} {$siteViewOptions->getOptionValue("adminEmail")}');
                    },
                    complete: function (data) {
                        $('#addReview').collapse('hide');
                        setTimeout(function () {
                            $('.form-message').fadeOut().remove();
                        }, 5000);
                    }
                });
            }
        });
        {/if}
        $(window).resize(function () {
            var windowWidth = $(window).width();
            if (windowWidth > 992) {
                stick();
            }
            else {
                unstick();
            }
        });
        function stick() {
            $(".sticky-left-column").sticky({
                topSpacing: 100,
                bottomSpacing: 100,
                zIndex: 999
            });
        }

        function unstick() {
            $(".sticky-left-column").unstick();
        }
        var windowWidth = $(window).width();
        if (windowWidth > 992) {
            stick();
        }
        $('.review-content').readmore({
            speed: 75,
            moreLink: '<a href="#" class="read-more">{t}read more{/t}</a>',
            lessLink: false
        });
    </script>
{/block}