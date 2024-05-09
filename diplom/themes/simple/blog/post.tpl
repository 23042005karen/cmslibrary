{extends file='public.tpl'}
{block name=metaTitle}{if $post->getMetaTitle() !== null}{$post->getMetaTitle()}{else}{$post->getTitle()}{/if}{/block}
{block name=metaDescription}{$post->getMetaDescription()|replace:'"':''}{/block}
{block name=metaKeywords}{$post->getMetaKeywords()}{/block}
{assign var="pageURL" value="{$SiteURL}{$smarty.server.REQUEST_URI}"}
{block name=content}
    <header class="page-header text-center">
        <div class="container">
            <h1>{$post->getTitle()}</h1>
        </div>
    </header>
    <div class="page blog-post">
        <div class="row">
            <div class="col-sm-12">
                <div class="page-content">
                    {if $post->getImage() != null}
                        <div class="text-center">
                            <img class="img-responsive" src="{$post->getImage()->getWebPath('')}" alt="{$post->getTitle()}">
                        </div>
                    {/if}
                    <div class="post-meta text-center mt-1">
                        <p>
                            <i class="ti-calendar"></i> {$post->getPublishDateTime()|date_format:"%d %b %Y"}
                            <i class="ti-user ml-3"></i> {$post->getUser()->getFirstName()} {$post->getUser()->getLastName()}
                            {if count($post->getCategories()) > 0}
                                <i class="ti-tag ml-3"></i>
                                {foreach from=$post->getCategories() item=category name=categories}
                                    <a href="{$routes->getRouteString("postListByCategoryViewPublic",["categoryUrl"=>$category->getUrl()])}">{$category->getName()}</a>{if $smarty.foreach.categories.last !== true}, {/if}
                                {/foreach}
                            {/if}
                        </p>
                    </div>
                    {if isset($smarty.server.REQUEST_URI)}
                        <div class="social-btns text-center">
                            <a class="btn facebook" href="https://www.facebook.com/share.php?u={$pageURL}&title={$post->getTitle()}" target="blank"><i class="fa fa-facebook"></i></a>
                            <a class="btn twitter" href="https://twitter.com/intent/tweet?status={$post->getTitle()}+{$pageURL}" target="blank"><i class="fa fa-twitter"></i></a>
                            <a class="btn google" href="https://plus.google.com/share?url={$pageURL}" target="blank"><i class="fa fa-google"></i></a>
                            <a class="btn vk" href="http://vk.com/share.php?url={$pageURL}" target="blank"><i class="fa fa-vk"></i></a>
                            <a class="btn pinterest" href="http://pinterest.com/pin/create/button/?url={$pageURL}&description={$post->getTitle()}" target="blank"><i class="fa fa-pinterest"></i></a>
                        </div>
                    {/if}
                    {if $post->getContent()}
                        {$post->getContent()}
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerJs append}
{/block}
{block namecustomJs append}
{/block}
