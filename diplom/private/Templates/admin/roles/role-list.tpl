<table class="table table-striped table-bordered table-responsive">
    <thead>
        <tr>
            <th>{t}Name{/t}</th>
            <th style="width: 90px;" class="text-center">{t}Actions{/t}</th>
        </tr>
    </thead>
    <tbody>
        {if isset($roles) and $roles != null}
            {foreach from=$roles item=role name=role}
                <tr>
                    <td>
                        <a href="{$routes->getRouteString("roleEdit",["roleId"=>$role->getId()])}">{$role->getName()}</a>
                    </td>
                    <td class="text-center">
                        <a href="{$routes->getRouteString("roleEdit",["roleId"=>$role->getId()])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if}" data-container="body" data-toggle="tooltip" title="{t}Edit{/t}"><i class="fa fa-pencil"></i></a>
                        {if $role->getId() != 1 and isset($user) and $user->getRole() != null and $user->getRole()->getPriority() >= 255}
                            <div class="dropdown d-inline" data-trigger="hover" data-toggle="tooltip" title="{t}Delete{/t}">
                                <button class="btn btn-outline-info btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <ul class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if}">
                                    <li class="text-center">{t}Do you really want to delete?{/t}</li>
                                    <li class="divider"></li>
                                    <li class="text-center">
                                        <button class="btn btn-outline-secondary delete-user" data-url="{$routes->getRouteString("roleDelete",["roleId"=>$role->getId()])}">
                                            <i class="fa fa-trash-o"></i> {t}Delete{/t}
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        {/if}
                    </td>
                </tr>
            {/foreach}
        {/if}
    </tbody>
</table>
{if isset($pages)}
    {include "admin/general/pagination.tpl"}
{/if}