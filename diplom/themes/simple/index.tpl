{extends file='public.tpl'}
{block name=metaTitle}{if $indexPage != null}{if $indexPage->getMetaTitle() != null}{$indexPage->getMetaTitle()}{else}{$indexPage->getTitle()}{/if}{/if}{/block}
{block name=metaDescription}{if $indexPage != null}{$indexPage->getMetaDescription()}{/if}{/block}
{block name=metaKeywords}{if $indexPage != null}{$indexPage->getMetaKeywords()}{/if}{/block}
{block name=headerCss append}{/block}
{block name=content}
    <div class="home-book-list p-3">
        <div class="row">
            <div class="col-sm-12">
                {if $indexPage != null}
                    {$indexPage->getContent()}
                {/if}
            </div>
            <div class="col-sm-12">
                <div class="page-title mb-3">
                    <h2 class="text-uppercase title">{t}last books{/t}</h2>
                </div>
            </div>
            {if isset($books) and $books != null}
                {foreach from=$books item=book name=book}
                    <div class="col-sm-6 col-md-4 col-lg-2">
                        <div class="card book card-no-border">
                            {if $book->getCover()}
                                <div class="cover">
                                    <a href="{$routes->getRouteString("bookViewPublic",["bookId"=>$book->getId()])}"><img src="{$book->getCover()->getWebPath('small')}" alt="" class="card-img-top"></a>
                                </div>
                            {else}
                                <div class="cover">
                                    <a href="{$routes->getRouteString("bookViewPublic",["bookId"=>$book->getId()])}"><img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="{$book->getTitle()}" class="card-img-top"></a>
                                </div>
                            {/if}
                            <div class="card-block p-2 text-center">
                                <h4 class="card-title">
                                    <a href="{$routes->getRouteString("bookPublicView",["bookId"=>$book->getId()])}">{$book->getTitle()} {if $book->getPublishingYear() != null}({$book->getPublishingYear()}){/if}</a>
                                </h4>
                            </div>
                        </div>
                    </div>
                {/foreach}
            {/if}
        </div>
    </div>
{/block}
{block name=footerJs append}{/block}
{block name=customJs append}{/block}