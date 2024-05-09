<!DOCTYPE html>
<html lang="en" class="">
    <head>
        <meta charset="UTF-8">
        <title>{t}500 Internal server error{/t}</title>
        <link rel="icon" type="image/png" href="{$siteViewOptions->getOptionValue("favIconFilePath")}"/>
        <meta name=viewport content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="{$themePath}resources/css/bootstrap.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/plugins/select2/select2.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/font-awesome.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/themify-icons.css">
        <link rel="stylesheet" href="{$themePath}resources/css/flag-icon.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/style.css">
    </head>
    <body>
        <div class="content-wrapper">
            <div class="content">
                <div class="container">
                    <div class="page error-page">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="page-content">
                                    <h1 class="text-center">500</h1>
                                    <div class="error-messages">
                                        <p class="not-found text-center">{t}Internal server error{/t}</p>
                                        <p class="text-center">{t}Looks like we have an internal issue, please try again in couple of minutes.{/t}</p>
                                        {include 'errors.tpl'}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="{$themePath}resources/js/jquery.min.js"></script>
        <script src="{$themePath}resources/js/plugins/bootstrap/popper.min.js"></script>
        <script src="{$themePath}resources/js/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="{$themePath}resources/js/plugins/select2/select2.full.min.js"></script>
        <script src="{$themePath}resources/js/main.js"></script>
    </body>
</html>