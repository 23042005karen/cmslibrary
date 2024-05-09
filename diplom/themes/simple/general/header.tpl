<header class="header">
    <div class="container">
        <nav class="navbar navbar-toggleable-lg primary-menu">
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar-toggle" aria-controls="navbar-toggle" aria-expanded="false" aria-label="Toggle navigation">
                <span class="ti-menu"></span>
            </button>

            <a class="navbar-brand" href="{$routes->getRouteString("publicIndex")}"><img src="{$siteViewOptions->getOptionValue("logoFilePath")}" alt="Logo"></a>

            <div class="collapse navbar-collapse justify-content-end" id="navbar-toggle">
                {function printMenu node=null}
                    {if isset($node) and $node->getValue() !== null}
                        {assign var="menuItem" value=$node->getValue()}
                        <li class="{if $node->getChildren() == null}nav-item{/if} {if $node->getChildren() != null}dropdown{/if} {if $menuItem->getClass() != null}{$menuItem->getClass()}{/if}">
                            <a href="{if $menuItem->getPageId() != null}{$pageUrls[$menuItem->getPageId()]}{elseif  $menuItem->getPostId() != null}{$postUrls[$menuItem->getPostId()]}{elseif $menuItem->getLink() != null}{$menuItem->getLink()}{/if}" class="nav-link" {if $node->getChildren() != null} data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"{/if}>{$menuItem->getTitle()}</a>
                            {if $node->getChildren() != null}
                                <ul class="dropdown-menu">
                                    {foreach $node->getChildren() as $subNode}
                                        {printMenu node=$subNode}
                                    {/foreach}
                                </ul>
                            {/if}
                        </li>
                    {/if}
                {/function}
                <ul class="navbar-nav primary-menu-items">
                    {if isset($menu1)}
                        {foreach from=$menu1->getRootNodes() item=rootNode}
                            {printMenu node=$rootNode}
                        {/foreach}
                    {/if}
                </ul>
            </div>
            <ul class="nav-search">
                {if isset($user) and $user != null}
                    {if $user->getFirstName() != null}
                        <li>
                            <a href="{$routes->getRouteString("adminIndex")}" class="open-login-box">
                                {$user->getFirstName()}
                            </a>
                        </li>
                    {/if}
                {else}
                    <li>
                        <a href="#" data-toggle="modal" data-target="#login-box" class="open-login-box">
                            <i class="ti-lock"></i>
                        </a>
                    </li>
                {/if}
                <li>
                    <a href="#" class="search-open">
                        <i class="ti-search"></i>
                    </a>
                </li>
                {if isset($languages)}
                    <li class="languages">
                        <a class="lang-select" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="ti-world"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            {foreach from=$languages item=language}
                                {if $language->isActive()}
                                    <a href="{$routes->getRouteString("languageChange",["languageCode"=>$language->getCode()])}" class="dropdown-item {if $language->getCode()==$activeLanguage->getCode()}active{/if}"><i class="flag-icon flag-icon-{$language->getShortCode()}"></i>{$language->getName()}
                                    </a>
                                {/if}
                            {/foreach}
                        </div>
                    </li>
                {/if}
            </ul>
            <div class="search-header">
                <form action="{$routes->getRouteString("bookSearchPublic")}" method="post" id="headerSearchForm">
                    <input class="search-input" name="searchText" autocomplete="off" type="text">
                    <button type="submit" class="form-icon">
                        <i class="ti-search search-icon"></i>
                    </button>
                    <span class="close search-close form-icon">
							<i class="ti-close"></i>
						</span>
                </form>
            </div>
        </nav>
    </div>
</header>
<div class="header-spacer"></div>
<div class="modal login-box fade" id="login-box" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="card card-no-border">
                    <div class="card-body">
                        <img src="{$siteViewOptions->getOptionValue("logoFilePath")}" class="d-flex ml-auto mr-auto mb-4 mt-2" alt="Login">
                        <form action="{$routes->getRouteString("publicLogin")}" method="post" class="form-horizontal form-material">
                            <div class="form-group ">
                                <div class="col-xs-12">
                                    <input name="login" class="form-control" placeholder="{t}Login{/t}" value="" type="text">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <input name="password" class="form-control" placeholder="{t}Password{/t}" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8 col-xs-8">
                                        <div class="app-checkbox">
                                            <label>
                                                <input type="checkbox" name="rememberMe"> {t}Remember me{/t}
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-xs-4">
                                        <button class="btn btn-success btn-block">{t}Login{/t}</button>
                                    </div>
                                    {if $siteViewOptions->getOptionValue("enableRegistration")}
                                        <div class="col-md-12 mt-2">
                                            <a href="{$routes->getRouteString("userRegistration")}" class="btn btn-primary btn-block">{t}Sign Up{/t}</a>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>