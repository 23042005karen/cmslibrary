<table class="table table-striped table-bordered table-responsive">
    <thead>
        <tr>
            <th>{t}Title{/t}</th>
            <th style="width: 90px;">{t}Actions{/t}</th>
        </tr>
    </thead>
    <tbody>
        {if isset($seriesList) and $seriesList != null}
            {foreach from=$seriesList item=series name=series}
                <tr>
                    <td>
                        <a href="{$routes->getRouteString("seriesEdit",["seriesId"=>$series->getId()])}">{$series->getName()}</a>
                    </td>
                    <td>
                        <a href="{$routes->getRouteString("editSeries",["seriesId"=>$series->getId()])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if}" data-container="body" data-toggle="tooltip" title="{t}Edit{/t}"><i class="fa fa-pencil"></i></a>
                        <div class="dropdown d-inline" data-trigger="hover" data-toggle="tooltip" title="{t}Delete{/t}">
                            <button class="btn btn-outline-info btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-trash-o"></i>
                            </button>
                            <ul class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if}">
                                <li class="text-center">{t}Do you really want to delete?{/t}</li>
                                <li class="divider"></li>
                                <li class="text-center">
                                    <button class="btn btn-outline-secondary delete-series" data-url="{$routes->getRouteString("seriesDelete",["seriesId"=>$series->getId()])}">
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