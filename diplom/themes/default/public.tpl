<!DOCTYPE html>
<html lang="en" class="" dir="{if $activeLanguage->isRTL()}rtl{else}ltr{/if}">
    <head {block name=headerPrefix}{/block}>
        <meta charset="UTF-8">
        <title>{block name=metaTitle}Library CMS{/block}</title>
        <meta name="description" content="{block name=metaDescription}{/block}">
        <meta name="keywords" content="{block name=metaKeywords}{/block}">
        <link rel="icon" type="image/png" href="{$siteViewOptions->getOptionValue("favIconFilePath")}"/>
        <meta name=viewport content="width=device-width, initial-scale=1">
        {block name=socialNetworksMeta}{/block}
        <link rel="stylesheet" href="{$themePath}resources/css/bootstrap.min.css">
        <link rel="stylesheet" href="{$themePath}resources/css/plugins.css">
        {if $activeLanguage->isRTL()}
            <link rel="stylesheet" href="{$themePath}resources/css/style.rtl.css">
            <link rel="stylesheet" href="{$themePath}resources/css/responsive.rtl.css">
        {else}
            <link rel="stylesheet" href="{$themePath}resources/css/style.css">
            <link rel="stylesheet" href="{$themePath}resources/css/responsive.css">
        {/if}
        {block name=headerCss}{/block}
    </head>
    <body>
        {if ($siteViewOptions->getOptionValue("publicForRegisteredUsersOnly") and isset($user)) or !$siteViewOptions->getOptionValue("publicForRegisteredUsersOnly")}
            {include 'general/header.tpl'}
            {block name=content}{/block}
            {include 'general/footer.tpl'}
        {else}
            {include file='auth/login.tpl'}
        {/if}
        {block name=footerJs}
            <script src="{$themePath}resources/js/jquery.min.js"></script>
            <script src="{$themePath}resources/js/popper.min.js"></script>
            <script src="{$themePath}resources/js/bootstrap.min.js"></script>
        {/block}
        <script src="{$themePath}resources/js/plugins.js"></script>
        <script src="{$themePath}resources/js/custom.js"></script>
        {block name=customJs}{/block}
    </body>
</html>