<header class="header">
    <nav class="navbar top-navbar navbar-expand-md navbar-light">
        <div class="navbar-header">
            <a class="navbar-brand" href="{$routes->getRouteString("adminIndex")}">
                <b>
                    <img src="{$resourcePath}assets/images/logo-icon.png" alt="logo"/>
                </b>
                <span>
                    <img src="{$siteViewOptions->getOptionValue("logoFilePath")}" alt="logo"/>
                </span>
            </a>
        </div>
        <div class="navbar-collapse">
            <ul class="navbar-nav {if $activeLanguage->isRTL()}ml-auto{else}mr-auto{/if} mt-md-0 ">
                <li class="nav-item">
                    <a class="nav-link nav-toggler d-md-none text-muted" href="javascript:void(0)"><i class="icon-menu" aria-hidden="true"></i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link sidebartoggler d-none d-md-block text-muted" href="javascript:void(0)"><i class="icon-menu" aria-hidden="true"></i></a>
                </li>
                {if isset($user) and $user->getRole() != null and $user->getRole()->getPriority() >= 200}
                    <li class="nav-item d-none d-md-block">
                        <div class="search-header">
                            <div class="input-group">
                                <input type="text" class="form-control header-search-input" placeholder="{t}Search{/t}" name="searchText">
                                <select name="searchBy" id="searchBy">
                                    <option value="books">{t}By Books{/t}</option>
                                    <option value="users">{t}By Users{/t}</option>
                                </select>
                                <span class="input-group-btn">
                                <a class="search-btn btn btn-outline-default" id="search-book"><i class="fa header-search-icon fa-search"></i></a>
                            </span>
                            </div>
                            <ul class="header-search-results"></ul>
                        </div>
                    </li>
                {/if}
            </ul>
            <ul class="navbar-nav my-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="{$routes->getRouteString("publicIndex")}" target="_blank"><i class="icon-screen-desktop"></i></a>
                </li>
                {if isset($user)}
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-muted" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="icon-settings"></i>
                        </a>
                        <div class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if} animated bounceIn">
                            {if $user->getId() != null}
                                <a href="{$routes->getRouteString("userEdit",["userId"=>$user->getId()])}" class="dropdown-item"><i class="icon-user mr-2"></i> {t}Profile{/t}
                                </a>
                            {/if}
                            <a href="{$routes->getRouteString("adminLogout")}" class="dropdown-item"><i class="icon-power mr-2"></i> {t}Logout{/t}
                            </a>
                        </div>
                    </li>
                {/if}
                <li class="nav-item dropdown">
                    {include 'admin/general/languageSelector.tpl'}
                </li>
            </ul>
        </div>
    </nav>
</header>