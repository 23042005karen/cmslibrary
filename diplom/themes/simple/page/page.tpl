{extends file='public.tpl'}
{block name=metaTitle}{if $page->getMetaTitle()}{$page->getMetaTitle()}{else}{$page->getTitle()}{/if}{/block}
{block name=metaDescription}{$page->getMetaDescription()}{/block}
{block name=metaKeywords}{$page->getMetaKeywords()}{/block}
{block name=headerCss append}{/block}
{block name=content}
    <header class="page-header text-center">
        <div class="container">
            <h1>{$page->getTitle()}</h1>
        </div>
    </header>
    <div class="page">
        <div class="row">
            <div class="col-sm-12">
                <div class="page-content">
                    {if $page->getImage() != null}
                        <div class="text-center mb-3">
                            <img class="img-responsive" src="{$page->getImage()->getWebPath('')}" alt="{$page->getTitle()}">
                        </div>
                    {/if}
                    {if $page->getContent()}
                        {$page->getContent()}
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerJs append}{/block}
{block name=customJs append}{/block}