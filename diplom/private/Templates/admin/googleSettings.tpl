{extends file='admin/admin.tpl'}
{block name=title}{t}Google Books Settings{/t}{/block}
{block name=headerCss append}
    <link href="{$resourcePath}assets/css/plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet"/>
{/block}
{block name=content}
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <form action="{$routes->getRouteString("googleSettings")}" method="post" class="validate">
                        <div class="form-group">
                            <label class="control-label">{t}Api Key{/t}</label>
                            <input type="text" class="form-control" name="apiKey" value="{$googleSettings->getApiKey()}">
                        </div>
                        <div class="form-group">
                            <label class="control-label">{t}Max Search Results{/t}</label>
                            <input type="text" class="form-control" name="maxSearchResults" value="{$googleSettings->getMaxSearchResults()}">
                        </div>
                        <div class="form-group">
                            <label class="control-label">{t}Country{/t} <a class="ml-1 text-warning" data-toggle="collapse" href="#codes" aria-expanded="false" aria-controls="codes"><i class="fa fa-info-circle"></i></a></label>
                            <div class="collapse" id="codes">
                                <div class="alert alert-info">
                                    <a href="https://en.wikipedia.org/wiki/List_of_FIPS_country_codes" target="_blank">{t}Use this country codes{/t}.</a>
                                </div>
                            </div>

                            <input type="text" class="form-control" name="country" value="{$googleSettings->getCountry()}">
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-success pull-right mt-2">
                                <i class="fa fa-floppy-o"></i> {t}Save{/t}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerPageJs append}
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jquery-validate/jquery.validate.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-select/bootstrap-select.js"></script>
{/block}
{block name=footerCustomJs append}{/block}