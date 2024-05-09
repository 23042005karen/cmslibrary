<div class="top-filter">
    <p class="m-0">{t escape=no}Found <span>{/t}{$totalBooks} {t escape=no}books</span> in total{/t}</p>
    <select name="sortColumn" id="books-sort">
        <option value="Books.creationDateTime" data-order="DESC"{if $smarty.session.bookSortingOrderPublic == 'DESC' and $smarty.session.bookSortingColumnPublic == 'Books.creationDateTime'} selected{/if}>{t}Date Descending{/t}</option>
        <option value="Books.creationDateTime" data-order="ASC"{if $smarty.session.bookSortingOrderPublic == 'ASC' and $smarty.session.bookSortingColumnPublic == 'Books.creationDateTime'} selected{/if}>{t}Date Ascending{/t}</option>
        <option value="Books.title" data-order="DESC"{if $smarty.session.bookSortingOrderPublic == 'DESC' and $smarty.session.bookSortingColumnPublic == 'Books.title'} selected{/if}>{t}Title Descending{/t}</option>
        <option value="Books.title" data-order="ASC"{if $smarty.session.bookSortingOrderPublic == 'ASC' and $smarty.session.bookSortingColumnPublic == 'Books.title'} selected{/if}>{t}Title Ascending{/t}</option>
        <option value="Books.publishingYear" data-order="DESC"{if $smarty.session.bookSortingOrderPublic == 'DESC' and $smarty.session.bookSortingColumnPublic == 'Books.publishingYear'} selected{/if}>{t}Year Descending{/t}</option>
        <option value="Books.publishingYear" data-order="ASC"{if $smarty.session.bookSortingOrderPublic == 'ASC' and $smarty.session.bookSortingColumnPublic == 'Books.publishingYear'} selected{/if}>{t}Year Ascending{/t}</option>
    </select>
</div>
<div class="row">
    <div id="preloader-book" style="display: none;">
        <div id="loader"></div>
    </div>
    {if isset($books) and $books != null}
        {foreach from=$books item=book name=book}
            <div class="{$size_grid|default:"col-sm-12 col-md-4 col-lg-2"}">
                <div class="card book card-no-border">
                    {if $book->getCover() != null}
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
                            <a href="{$routes->getRouteString("bookViewPublic",["bookId"=>$book->getId()])}">{$book->getTitle()} ({$book->getPublishingYear()})</a>
                        </h4>
                    </div>
                </div>
            </div>
        {/foreach}
    {/if}
</div>
<div class="books-per-page d-flex">
    {include "general/pagination.tpl"}
</div>
{block name=perPageFilter}
    <div class="top-filter">
        <p class="m-0">{t}Books per page:{/t}</p>
        <select name="perPage" id="countPerPage">
            {foreach from=$siteViewOptions->getOption("booksPerPagePublic")->getListValues() key=key item=value}
                <option value="{$key}"{if ($smarty.session.bookPerPagePublic == null and strcmp($key,$siteViewOptions->getOption("booksPerPagePublic")->getValue()) === 0) or strcmp($key,$smarty.session.bookPerPagePublic) === 0} selected{/if}>{t count=$value 1=$value plural="%1 Books"}1 Book{/t}</option>
            {/foreach}
        </select>
    </div>
{/block}