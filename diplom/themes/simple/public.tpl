<!DOCTYPE html>
<html lang="en" class="" dir="ltr">
    <head>
        <meta charset="UTF-8">
        <title>{block name=metaTitle}Library CMS{/block}</title>
        <meta name="description" content="{block name=metaDescription}{/block}">
        <meta name="keywords" content="{block name=metaKeywords}{/block}">
        <link rel="icon" type="image/png" href="{$siteViewOptions->getOptionValue("favIconFilePath")}"/>
        <meta name=viewport content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="{$themePath}resources/css/bootstrap.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/plugins/select2/select2.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/font-awesome.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/themify-icons.css">
        <link rel="stylesheet" href="{$themePath}resources/css/flag-icon.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/style.css">
        {block name=headerCss}{/block}
    </head>
    <body>
        {if ($siteViewOptions->getOptionValue("publicForRegisteredUsersOnly") and isset($user)) or !$siteViewOptions->getOptionValue("publicForRegisteredUsersOnly")}
            <div class="content-wrapper">
                {include 'general/header.tpl'}
                <div class="content">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="d-none" id="message-block"></div>
                            </div>
                        </div>

                        {block name=content}{/block}
                    </div>
                </div>
                {include 'general/footer.tpl'}
            </div>
        {else}
            {include file='auth/login.tpl'}
        {/if}

        {block 'footerJs'}
            <script src="{$themePath}resources/js/jquery.min.js"></script>
            <script src="{$themePath}resources/js/plugins/bootstrap/popper.min.js"></script>
            <script src="{$themePath}resources/js/plugins/bootstrap/bootstrap.min.js"></script>
            <script src="{$themePath}resources/js/plugins/select2/select2.full.min.js"></script>
        {/block}
        <script src="{$themePath}resources/js/main.js"></script>
        {block 'customJs'}{/block}
    </body>
</html>