{extends file='public.tpl'}
{block name=content}
    <div class="page error-page">
        <div class="row">
            <div class="col-sm-12">
                <div class="page-content">
                    <h1 class="text-center">403</h1>
                    <div class="error-messages">
                        {include 'admin/errors.tpl'}
                        <div class="text-center">
                            <a href="#" class="btn btn-default" onclick="history.back(); return false;">{t}Go back!{/t}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}