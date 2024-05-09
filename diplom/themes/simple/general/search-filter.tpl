<div class="sidebar">
    <div class="search-form">
        <form class="" action="{$routes->getRouteString("bookFilterPublic")}" id="book-filter">
            <div class="row">
                <div class="col-md-12 mb-2">
                    <label>{t}Publisher{/t}</label>
                    <div class="group-elem">
                        <select name="publisherIds[]" id="publishers" multiple="multiple"></select>
                    </div>
                </div>
                <div class="col-md-12 mb-2">
                    <label>{t}Genres{/t}</label>
                    <div class="group-elem">
                        <select name="genreIds[]" id="genres" multiple="multiple"></select>
                    </div>
                </div>
                <div class="col-md-12 mb-2">
                    <label>{t}Authors{/t}</label>
                    <div class="group-elem">
                        <select name="authorIds[]" id="authors" multiple="multiple"></select>
                    </div>
                </div>

                <div class="col-md-12 mb-2">
                    <label>{t}Year{/t}</label>
                    <div class="row">
                        <div class="col-md-6">
                            <select name="startYear">
                                <option value=""></option>
                                {for $foo=1960 to $smarty.now|date_format:'%Y'}
                                    <option value="{$foo}">{$foo}</option>
                                {/for}
                            </select>
                        </div>
                        <div class="col-md-6">
                            <select name="endYear">
                                <option value=""></option>
                                {for $foo=1960 to $smarty.now|date_format:'%Y'}
                                    <option value="{$foo}">{$foo}</option>
                                {/for}
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 mb-2">
                    <label>{t}Bindings{/t}</label>
                    <div class="group-elem">
                        <select name="bindings[]" id="bindings" multiple="multiple">
                            {*if isset($bindings) and is_array($bindings)}
                                {foreach from=$bindings item=binding name=binding}
                                    <option value="{$binding->getId()}">{$binding->getName()}</option>
                                {/foreach}
                            {/if*}
                            <option value="Hardcover">{t}Hardcover{/t}</option>
                            <option value="Softcover">{t}Softcover{/t}</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-12 text-center">
                    <button class="btn btn-primary btn-rounded mt-2" id="filterIt" type="submit">{t}Filter It!{/t}</button>
                </div>
            </div>
        </form>
    </div>
</div>