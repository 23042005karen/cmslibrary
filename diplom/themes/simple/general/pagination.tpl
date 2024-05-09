{if isset($pages) and ($pages != null and count($pages) > 1)}
    <nav class="m-auto">
        <ul class="pagination">
            {foreach from=$pages item=page}
                <li class="page-item {if $page->isCurrent()} active{/if}">
                    <a href="{$page->getLink()}" class="page-link ajax-page">
                        {if $page->isFirst()}
                            {t}First Page{/t}
                        {elseif $page->isLast()}
                            {t}Last Page{/t}
                        {elseif $page->isNext()}
                            <i class="ti-angle-right"></i>
                        {elseif $page->isPrevious()}
                            <i class="ti-angle-left"></i>
                        {else}
                            {$page->getTitle()}
                        {/if}
                    </a>
                </li>
            {/foreach}
        </ul>
    </nav>
{/if}