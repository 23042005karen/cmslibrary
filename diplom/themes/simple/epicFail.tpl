<!DOCTYPE html>
<html lang="en" class="">
    <head>
        <meta charset="UTF-8">
        <title>{t}Epic Fail{/t}</title>
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
                                    <h1 class="text-center">{t}Epic Fail{/t}</h1>
                                    <div class="error-messages">
                                        {if isset($smarty.session.messages) and count($smarty.session.messages) > 0}
                                            <div class="alert alert-dismissable alert-danger">
                                                {foreach from=$smarty.session.messages item=message}
                                                    {$message->getMessage()}
                                                    <br/>
                                                {/foreach}
                                            </div>
                                        {/if}
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