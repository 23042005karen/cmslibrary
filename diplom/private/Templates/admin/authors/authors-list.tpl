<div class="card-header">
    <div class="heading-elements">
        <select name="sortColumn" id="books-sort" class="select-picker pr-2 d-tc">
            <option value="Authors.lastName" data-order="DESC"{if $smarty.session.authorSortingOrder == 'DESC' and $smarty.session.authorSortingColumn == 'Authors.lastName'} selected{/if}>{t}Name Descending{/t}</option>
            <option value="Authors.lastName" data-order="ASC"{if $smarty.session.authorSortingOrder == 'ASC' and $smarty.session.authorSortingColumn == 'Authors.lastName'} selected{/if}>{t}Name Ascending{/t}</option>
        </select>
        <select name="perPage" id="countPerPage" class="select-picker d-tc">
            {foreach from=$siteViewOptions->getOption("authorsPerPage")->getListValues() key=key item=value}
                <option value="{$key}"{if ($smarty.session.authorPerPage == null and strcmp($key,$siteViewOptions->getOption("authorsPerPage")->getValue()) === 0) or strcmp($key,$smarty.session.authorPerPage) === 0} selected{/if}>{t count=$value 1=$value plural="%1 Authors"}1 Author{/t}</option>
            {/foreach}
        </select>
    </div>
</div>
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th>{t}Last Name{/t}</th>
            <th>{t}Middle Name{/t}</th>
            <th>{t}First Name{/t}</th>
            <th style="width: 90px;">{t}Actions{/t}</th>
        </tr>
    </thead>
    <tbody>
        {if isset($authors) and $authors != null}
            {foreach from=$authors item=author name=author}
                <tr>
                    <td>
                        <a href="{$routes->getRouteString("authorEdit",["authorId"=>$author->getId()])}">{$author->getLastName()}</a>
                    </td>
                    <td>
                        <a href="{$routes->getRouteString("authorEdit",["authorId"=>$author->getId()])}">{$author->getMiddleName()}</a>
                    </td>
                    <td>
                        <a href="{$routes->getRouteString("authorEdit",["authorId"=>$author->getId()])}">{$author->getFirstName()}</a>
                    </td>
                    <td>
                        <a href="{$routes->getRouteString("authorEdit",["authorId"=>$author->getId()])}" class="btn btn-outline-info btn-sm" data-container="body" data-toggle="tooltip" title="{t}Edit{/t}"><i class="fa fa-pencil"></i></a>
                        <div class="dropdown pull-right" data-trigger="hover" data-toggle="tooltip" title="{t}Delete{/t}">
                            <button class="btn btn-outline-info btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-trash-o"></i>
                            </button>
                            <ul class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if}">
                                <li class="text-center">{t}Do you really want to delete?{/t}</li>
                                <li class="divider"></li>
                                <li class="text-center">
                                    <button class="btn btn-outline-secondary delete-author" data-url="{$routes->getRouteString("authorDelete",["authorId"=>$author->getId()])}">
                                        <i class="fa fa-trash-o"></i> {t}Delete{/t}
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>
            {/foreach}
        {/if}
    </tbody>
</table>
{if isset($pages)}
    {include "admin/general/pagination.tpl"}
{/if}