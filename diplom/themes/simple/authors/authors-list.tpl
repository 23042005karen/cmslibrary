<div class="top-filter">
    <p class="m-0">{t escape=no}Found <span>{/t}{$totalAuthors} {t escape=no}authors</span> in total{/t}</p>
    <select name="sortColumn" id="books-sort">
        <option value="Authors.lastName" data-order="DESC"{if $smarty.session.authorSortingOrderPublic == 'DESC' and $smarty.session.authorSortingColumnPublic == 'Authors.lastName'} selected{/if}>{t}Name Descending{/t}</option>
        <option value="Authors.lastName" data-order="ASC"{if $smarty.session.authorSortingOrderPublic == 'ASC' and $smarty.session.authorSortingColumnPublic == 'Authors.lastName'} selected{/if}>{t}Name Ascending{/t}</option>
    </select>
</div>
<div id="preloader-book">
    <div id="loader"></div>
</div>
<div class="row">
    {if isset($authors) and $authors != null}
        {foreach from=$authors item=author name=author}
            <div class="col-sm-6 col-md-3 col-lg-2">
                <div class="card book card-no-border">
                    {if $author->getPhoto() != null}
                        <div class="photo">
                            <a href="{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}" class="text-center"><img src="{$author->getPhoto()->getWebPath('medium')}" alt="" class="card-img-top"></a>
                        </div>
                    {else}
                        <div class="photo">
                            <a href="{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}" class="text-center"><img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="{$author->getLastName()} {$author->getFirstName()}" class="card-img-top"></a>
                        </div>
                    {/if}
                    <div class="card-block p-2 text-center">
                        <h4 class="card-title mb-0">
                            <a href="{$routes->getRouteString("authorBooksPublic",["authorId"=>$author->getId()])}">{$author->getLastName()} {$author->getFirstName()}</a>
                        </h4>
                        <span class="count mb-1">{$author->getBookCount()} {t}books{/t}</span>
                    </div>
                </div>
            </div>
        {/foreach}
    {/if}
</div>
<div class="books-per-page d-flex">
    {include "general/pagination.tpl"}
</div>
<div class="top-filter">
    <p class="m-0">{t}Authors per page:{/t}</p>
    <select name="perPage" id="countPerPage">
        {foreach from=$siteViewOptions->getOption("authorsPerPagePublic")->getListValues() key=key item=value}
            <option value="{$key}"{if ($smarty.session.authorPerPagePublic == null and strcmp($key,$siteViewOptions->getOption("authorsPerPagePublic")->getValue()) === 0) or strcmp($key,$smarty.session.authorPerPagePublic) === 0} selected{/if}>{t count=$value 1=$value plural="%1 Authors"}1 Author{/t}</option>
        {/foreach}
    </select>
</div>