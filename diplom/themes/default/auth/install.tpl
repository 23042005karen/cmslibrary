<!DOCTYPE html>
<html lang="en" style="height: 100%;">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="KAASoft">
        <meta name="robots" content="noindex,nofollow">
        <meta http-equiv="cache-control" content="no-cache"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta http-equiv="Expires" content="-1"/>
        <title>Install Library CMS</title>
        <link href="{$resourcePath}assets/css/plugins/bootstrap/bootstrap.min.css" rel="stylesheet">
        <link href="{$resourcePath}assets/css/style.css" rel="stylesheet">
        <link rel="icon" type="image/png" sizes="32x32" href="{$resourcePath}assets/images/favicon.png">
    </head>
    <body style="min-height: 100%;background: linear-gradient(180deg,#f0f0f0 0,#dee1e3 100%) !important;">
        <section id="wrapper">
            <div class="login-register" style="">
                <div class="login-box card" style="max-width: 600px;width: auto;">
                    <div class="card-body">
                        <img src="{$resourcePath}assets/images/logo.png" class="d-flex ml-auto mr-auto mb-4 mt-2" alt="{t}Login{/t}"/> :: <a href="https://prowebber.ru/">Shared by prowebber<a/>
                        {include 'errors.tpl'}
                        <form action="{$routes->getRouteString("installSite")}" method="post" class="form-horizontal validate">
                            {if $isUpdate === true}
                                <div class="form-group">
                                    <h3 class="text-center mb-3">Update Library CMS</h3>
                                </div>
                                <div class="form-group mt-3">
                                    <button type="submit" class="btn btn-primary btn-block" id="update">{t}Update{/t}</button>
                                </div>
                            {else}
                                <div class="form-group">
                                    <h3 class="text-center mb-3">Install Library CMS</h3>
                                    <p class="text-muted font-light fs14 text-center">{t}This is installation page. Here you can setup connection to database and create administrator user. Please make sure your connection details and credentials are correct before starting installation process.{/t}</p>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="hostname">{t}Hostname{/t}</label>
                                            <input type="text" name="databaseHost" class="form-control" value="{$smarty.session.POST.databaseHost}">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="databaseName">{t}Database Name{/t}</label>
                                            <input type="text" name="databaseName" class="form-control" autocomplete="off" value="{$smarty.session.POST.databaseName}">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="databaseUserName">{t}Database Username{/t}</label>
                                            <input type="text" name="databaseUserName" class="form-control" autocomplete="off" value="{$smarty.session.POST.databaseUserName}">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="databasePassword">{t}Database Password{/t}</label>
                                            <input type="password" name="databasePassword" class="form-control" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="adminEmail">{t}Admin Email (Login){/t}</label>
                                            <input type="text" name="adminEmail" class="form-control" autocomplete="off" value="{$smarty.session.POST.adminEmail}">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="adminPassword">{t}Admin Password{/t}</label>
                                            <input type="password" name="adminPassword" class="form-control" id="mainPassword" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="adminPassword">{t}Confirm Admin Password{/t}</label>
                                            <input type="password" name="confirmPassword" class="form-control confirmPassword" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                <a class="font-bold fs12 text-uppercase" data-toggle="collapse" href="#advancedOptions" aria-expanded="false" aria-controls="advancedOptions">
                                    {t}Advanced Options{/t} <i class="icon-arrow-down"></i>
                                </a>
                                <div class="collapse mt-3" id="advancedOptions">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="databasePort">{t}Database Port{/t}</label>
                                                <input type="text" name="databasePort" class="form-control" value="3306">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="databaseType">{t}Database Type{/t}</label>
                                                <select name="databaseType" class="form-control">
                                                    <option value="mysql" selected>mysql</option>
                                                    <option value="mariadb">mariadb</option>
                                                    <option value="mssql">mssql</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mt-3">
                                    <button type="submit" class="btn btn-primary btn-block" id="install">{t}Install{/t}</button>
                                </div>
                            {/if}
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <script src="{$resourcePath}assets/js/plugins/jquery/jquery-3.2.1.min.js"></script>
        <script src="{$resourcePath}assets/js/plugins/bootstrap/popper.min.js"></script>
        <script src="{$resourcePath}assets/js/plugins/bootstrap/bootstrap.min.js"></script>
        <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jquery-validate/jquery.validate.js"></script>
        <script src="{$resourcePath}assets/js/plugins/tooltipster/jquery.tooltipster.min.js"></script>
        <script src="{$resourcePath}assets/js/main.js"></script>
        <script>
            $('.validate input,.validate select,.validate textarea').tooltipster({
                trigger: 'custom',
                onlyOne: false,
                position: 'bottom',
                offsetY: -5,
                theme: 'tooltipster-kaa'
            });
            $('.validate').validate({
                errorPlacement: function (error, element) {
                    if (element != undefined) {
                        $(element).tooltipster('update', $(error).text());
                        $(element).tooltipster('show');
                    }
                },
                success: function (label, element) {
                    $(element).tooltipster('hide');
                },
                rules: {
                    adminEmail: {
                        required: true,
                        email: true
                    },
                    confirmPassword: {
                        equalTo: "#mainPassword"
                    }
                }
            });
        </script>
    </body>
</html>