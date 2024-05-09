<!DOCTYPE html>
<html lang="en" style="height: 100%;">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="KAASoft">
        <meta name="robots" content="noindex,nofollow">
        <title>{$pageTitle}</title>
        <link href="{$resourcePath}assets/css/plugins/bootstrap/bootstrap.min.css" rel="stylesheet">
        <link href="{$resourcePath}assets/css/style.css" rel="stylesheet">
        <link rel="icon" type="image/png" sizes="32x32" href="{$siteViewOptions->getOptionValue("favIconFilePath")}">
    </head>
    <body style="min-height: 100%;background: linear-gradient(180deg,#f0f0f0 0,#dee1e3 100%) !important;">
        <section id="wrapper">
            <div class="login-register">
                <div class="login-box card">
                    <div class="card-body">
                        <img src="{$siteViewOptions->getOptionValue("logoFilePath")}" class="d-flex ml-auto mr-auto mb-4 mt-2" alt="{t}Login{/t}"/>
                        {include 'errors.tpl'}
                        {include file='auth/login_form.tpl'}
                    </div>
                </div>
            </div>
        </section>
        <script src="{$resourcePath}assets/js/plugins/jquery/jquery-3.2.1.min.js"></script>
        <script src="{$resourcePath}assets/js/plugins/bootstrap/popper.min.js"></script>
        <script src="{$resourcePath}assets/js/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="{$resourcePath}assets/js/main.js"></script>
    </body>
</html>