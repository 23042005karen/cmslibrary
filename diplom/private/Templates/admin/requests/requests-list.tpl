<div class="card-header">
    <div class="heading-elements">
        <select name="sortColumn" id="books-sort" class="select-picker {if $activeLanguage->isRTL()}pl-2{else}pr-2{/if} d-tc">
            <option value="Requests.creationDate" data-order="DESC"{if $smarty.session.requestSortingOrder == 'DESC' and $smarty.session.requestSortingColumn == 'Requests.creationDate'} selected{/if}>{t}Request Date Descending{/t}</option>
            <option value="Requests.creationDate" data-order="ASC"{if $smarty.session.requestSortingOrder == 'ASC' and $smarty.session.requestSortingColumn == 'Requests.creationDate'} selected{/if}>{t}Request Date Ascending{/t}</option>
        </select>
        <select name="perPage" id="countPerPage" class="select-picker d-tc">
            {foreach from=$siteViewOptions->getOption("requestsPerPage")->getListValues() key=key item=value}
                <option value="{$key}"{if ($smarty.session.requestPerPage == null and strcmp($key,$siteViewOptions->getOption("requestsPerPage")->getValue()) === 0) or strcmp($key,$smarty.session.requestPerPage) === 0} selected{/if}>{t count=$value 1=$value plural="%1 Requests"}1 Request{/t}</option>
            {/foreach}
        </select>
    </div>
</div>
<table class="table table-striped table-bordered table-responsive">
    <thead>
        <tr>
            <th>{t}Book{/t}</th>
            <th>{t}Request From{/t}</th>
            <th>{t}Creation Date{/t}</th>
            <th style="width: 110px;" class="text-center">{t}Status{/t}</th>
            <th style="width: 200px;" class="text-center">{t}Actions{/t}</th>
        </tr>
    </thead>
    <tbody>
        {if isset($requests) and $requests != null}
            {foreach from=$requests item=request name=request}
                <tr>
                    <td>
                        <a href="{$routes->getRouteString("bookEdit",["bookId"=>$request->getBook()->getId()])}">{$request->getBook()->getTitle()}</a>
                        {if $request->getNotes()}
                            <div class="book-list-info">
                                <strong class="text-uppercase">{t}Notes{/t}:</strong>
                                {$request->getNotes()}
                            </div>
                        {/if}
                    </td>
                    <td>
                        {if $request->getUser()}
                            <a href="{$routes->getRouteString("userEdit",["userId"=>$request->getUser()->getId()])}">{$request->getUser()->getFirstName()} {$request->getUser()->getLastName()}</a>
                        {/if}
                    </td>
                    <td>
                        {$request->getCreationDate()}
                    </td>
                    <td class="request-status text-center">
                        <span class="badge {if $request->getStatus() == 'Pending'}badge-warning{elseif $request->getStatus() == 'Accepted'}badge-success{elseif $request->getStatus() == 'Rejected'}badge-danger{/if}">
                            {if $request->getStatus() == 'Pending'}
                                {t}Pending{/t}
                            {elseif $request->getStatus() == 'Accepted'}
                                {t}Accepted{/t}
                            {elseif $request->getStatus() == 'Rejected'}
                                {t}Rejected{/t}
                            {/if}
                        </span>
                    </td>
                    <td class="text-center">
                        <a href="{$routes->getRouteString("requestSetStatus",["requestId"=>$request->getId(),"status"=>"Accepted"])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if} accepted-book" data-container="body" data-toggle="tooltip" title="{t}Accepted{/t}"><i class="fa fa-check"></i></a>
                        <a href="{$routes->getRouteString("requestSetStatus",["requestId"=>$request->getId(),"status"=>"Rejected"])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if} rejected-book" data-container="body" data-toggle="tooltip" title="{t}Rejected{/t}"><i class="fa fa-times"></i></a>
                        {if !$request->getIssue()}
                            <a href="{$routes->getRouteString("requestedBookIssue",["requestId"=>$request->getId()])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if} issue-book" data-container="body" data-toggle="tooltip" title="{t}Issue Book{/t}"><i class="fa fa-book"></i></a>
                        {/if}
                        <a href="{$routes->getRouteString("requestEdit",["requestId"=>$request->getId()])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if}" data-container="body" data-toggle="tooltip" title="{t}Edit{/t}"><i class="fa fa-pencil"></i></a>
                        <div class="dropdown d-inline" data-trigger="hover" data-toggle="tooltip" title="{t}Delete{/t}">
                            <button class="btn btn-outline-info btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-trash-o"></i>
                            </button>
                            <ul class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if}">
                                <li class="text-center">{t}Do you really want to delete?{/t}</li>
                                <li class="divider"></li>
                                <li class="text-center">
                                    <button class="btn btn-outline-secondary delete-request" data-url="{$routes->getRouteString("requestDelete",["requestId"=>$request->getId()])}">
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
{include "admin/general/pagination.tpl"}