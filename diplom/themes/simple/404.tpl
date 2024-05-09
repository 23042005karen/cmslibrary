{extends file='public.tpl'}
{block name=content}
    <div class="page error-page">
        <div class="row">
            <div class="col-sm-12">
                <div class="page-content">
                    <h1 class="text-center">404</h1>
                    <div class="error-messages">
                        <p class="not-found text-center">{t}The page you are looking for was not found!{/t}</p>
                        {include 'admin/errors.tpl'}
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}