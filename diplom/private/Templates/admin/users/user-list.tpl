<table class="table table-striped table-bordered table-responsive">
    <thead>
        <tr>
            <th>{t}Email{/t}</th>
            <th>{t}User Name{/t}</th>
            <th>{t}User Role{/t}</th>
            <th style="width: 90px;" class="text-center">{t}Status{/t}</th>
            <th style="width: 90px;" class="text-center">{t}Actions{/t}</th>
        </tr>
    </thead>
    <tbody>
        {assign var="currentUser" value=$user}
        {if isset($users) and $users != null}
            {foreach from=$users item=user name=user}
                <tr>
                    <td>
                        {if isset($currentUser) and $currentUser->getRole() != null and $currentUser->getRole()->getPriority() < 255}
                            {if $user->getRole() !== null and $user->getRole()->getId() == 1}
                                {$user->getEmail()}
                            {else}
                                <a href="{$routes->getRouteString("userEdit",["userId"=>$user->getId()])}">{$user->getEmail()}</a>
                            {/if}
                        {else}
                            <a href="{$routes->getRouteString("userEdit",["userId"=>$user->getId()])}">{$user->getEmail()}</a>
                        {/if}
                    </td>
                    <td>{$user->getFirstName()} {$user->getLastName()}</td>
                    <td>{if $user->getRole() !== null}{$user->getRole()->getName()}{/if}</td>
                    <td class="text-center">
                        <span class="badge {if $user->isActive() == '1'}badge-success{else}badge-danger{/if}">
                            {if $user->isActive() == '1'}
                                {t}Active{/t}
                            {else}
                                {t}Inactive{/t}
                            {/if}
                        </span>
                    </td>
                    <td class="text-center">
                        {if isset($currentUser) and $currentUser->getRole() != null and $currentUser->getRole()->getPriority() <= 200}
                            {if $user->getRole() !== null and $user->getRole()->getId() != 1}
                                <a href="{$routes->getRouteString("userEdit",["userId"=>$user->getId()])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if}" data-container="body" data-toggle="tooltip" title="{t}Edit{/t}"><i class="fa fa-pencil"></i></a>
                            {/if}
                        {else}
                            <a href="{$routes->getRouteString("userEdit",["userId"=>$user->getId()])}" class="btn btn-outline-info btn-sm {if $activeLanguage->isRTL()}ml-1{else}mr-1{/if}" data-container="body" data-toggle="tooltip" title="{t}Edit{/t}"><i class="fa fa-pencil"></i></a>
                        {/if}
                        {if $user->getRole() !== null and $user->getId() != 1 and $currentUser->getRole()->getPriority() >= 255}
                            <div class="dropdown d-inline" data-trigger="hover" data-toggle="tooltip" title="{t}Delete{/t}">
                                <button class="btn btn-outline-info btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <ul class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if}">
                                    <li class="text-center">{t}Do you really want to delete?{/t}</li>
                                    <li class="divider"></li>
                                    <li class="text-center">
                                        <button class="btn btn-outline-secondary delete-user" data-url="{$routes->getRouteString("userDelete",["userId"=>$user->getId()])}">
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