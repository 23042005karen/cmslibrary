{extends file='admin/admin.tpl'}
{block name=title}{t}Users{/t}{/block}
{block name=toolbar}
    <div class="heading-elements">
        <a href="{$routes->getRouteString("userCreate")}" class="btn btn-success btn-icon-fixed" target="_blank">
            <i class="fa fa-plus"></i> {t}Add User{/t}
        </a>
    </div>
{/block}
{block name=content}
    <div class="row">
        <div class="col-12">
            <div class="card" id="userList">
                {include "admin/users/user-list.tpl"}
            </div>
        </div>
    </div>
{/block}
{block name=footerPageJs append}{/block}
{block name=footerCustomJs append}
    <script>
        $(document).ready(function () {
            $(document).on('click', '.delete-user', function (e) {
                var url = $(this).attr('data-url');
                var row = $(this).closest('tr');
                $.ajax({
                    dataType: 'json',
                    type: 'POST',
                    url: url,
                    beforeSend: function () {
                        app.card.loading.start('#userList');
                    },
                    success: function (data) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                app.notification('success', data.success);
                                $(row).remove();
                            }
                        }
                    },
                    complete: function () {
                        app.card.loading.finish('#userList');
                    },
                    error: function (jqXHR, exception) {
                        app.notification('error', app.getErrorMessage(jqXHR, exception));
                    }
                });
            });
            $(document).on('click', '.ajax-page', function (e) {
                e.preventDefault();
                $.ajax({
                    dataType: 'json',
                    url: $(this).attr('href'),
                    beforeSend: function () {
                        app.card.loading.start($("#userList"));
                    },
                    success: function (data) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                $("#userList").html(data.html);
                            }
                        }
                    },
                    complete: function () {
                        app.card.loading.finish($("#userList"));
                    },
                    error: function (jqXHR, exception) {
                        app.notification('error', app.getErrorMessage(jqXHR, exception));
                    }
                });
            });
        });
    </script>
{/block}