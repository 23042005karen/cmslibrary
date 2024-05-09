{extends file='public.tpl'}
{block name=metaTitle}{if isset($category)}{$category->getMetaTitle()}{else}{$blog->getMetaTitle()}{/if}{foreach from=$pages item=page}{if $page->isCurrent()}{if $page->getTitle() != 1} : Page #{$page->getTitle()}{/if}{/if}{/foreach}{/block}
{block name=metaDescription}{if isset($category)}{$category->getMetaDescription()}{else}{$blog->getMetaDescription()}{/if}{/block}
{block name=metaKeywords}{if isset($category)}{$category->getMetaKeywords()}{else}{$blog->getMetaKeywords()}{/if}{/block}
{block name=content}
    <header class="page-header text-center">
        <div class="container">
            {if isset($category)}
                <h1>{$category->getTitle()}</h1>
            {else}
                <h1>{$blog->getSecondTitle()}{foreach from=$pages item=page}{if $page->isCurrent()}{if $page->getTitle() != 1} : Page #{$page->getTitle()}{/if}{/if}{/foreach}</h1>
            {/if}
        </div>
    </header>
    <div class="page blog-posts">
        <div class="row">
            {if isset($posts) and $posts != null}
                {foreach from=$posts item=post name=post}
                    <div class="post col-lg-12">
                        <div class="row">
                            <div class="col-lg-4">
                                {if $post->getImage() != null}
                                    <a href="{$routes->getRouteString("postViewPublic",["postUrl"=>$post->getUrl()])}" class="post-img">
                                        <img class="img-fluid" src="{$post->getImage()->getWebPath('small')}" alt="{$post->getTitle()}">
                                    </a>
                                {/if}
                            </div>
                            <div class="col-lg-8">
                                <div class="post-content">
                                    <a href="{$routes->getRouteString("postViewPublic",["postUrl"=>$post->getUrl()])}" class="post-title">
                                        <h5>{$post->getTitle()}</h5>
                                    </a>
                                    <div class="post-meta">
                                        <p>
                                            <i class="ti-calendar"></i> {$post->getPublishDateTime()|date_format:"%d %b %Y"}
                                            <i class="ti-user ml-3"></i> {$post->getUser()->getFirstName()} {$post->getUser()->getLastName()}
                                        </p>
                                    </div>
                                    <p>{$post->getShortDescription()}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            {/if}
        </div>
        <div class="row mt-3">
            <div class="col-lg-12">
                {include "general/pagination.tpl"}
            </div>
        </div>
    </div>
{/block}