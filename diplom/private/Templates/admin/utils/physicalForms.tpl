{extends file='admin/admin.tpl'}
{block name=title}{t}Physical Forms{/t}{/block}
{block name=content}
    <div class="row">
        <div class="col-sm-12">
            <div class="card" id="physicalForm">
                <form action="{$routes->getRouteString("physicalFormListView")}" method="post">
                    <table class="table table-hover table-striped table-hover">
                        <thead>
                            <tr>
                                <th>{t}Name{/t}</th>
                                <th style="width: 70px"></th>
                            </tr>
                        </thead>
                        <tbody class="repeat-container">
                            {if isset($physicalForms) and physicalForms != null}
                                {foreach from=$physicalForms item=form name=form}
                                    <tr class="form">
                                        <td>
                                            <input class="form-control" type="text" name="names[{$smarty.foreach.form.index}]" value="{$form->getName()}">
                                        </td>
                                        <td class="text-center">
                                            <div class="dropdown" data-trigger="hover" data-toggle="tooltip" title="{t}Delete{/t}">
                                                <button class="btn btn-outline-info" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fa fa-trash-o"></i>
                                                </button>
                                                <ul class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if}">
                                                    <li class="text-center">{t}Do you really want to delete?{/t}</li>
                                                    <li class="divider"></li>
                                                    <li class="text-center">
                                                        <button class="btn btn-outline-secondary delete-form">
                                                            <i class="fa fa-trash-o"></i> {t}Delete{/t}
                                                        </button>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                {/foreach}
                            {/if}
                            <tr class="copy-template form">
                                <td>
                                    <input class="form-control" type="text" name="names[count]" disabled>
                                </td>
                                <td class="text-center">
                                    <div class="dropdown" data-trigger="hover" data-toggle="tooltip" title="{t}Delete{/t}">
                                        <button class="btn btn-outline-info" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fa fa-trash-o"></i>
                                        </button>
                                        <ul class="dropdown-menu {if $activeLanguage->isRTL()}dropdown-menu-left{else}dropdown-menu-right{/if}">
                                            <li class="text-center">{t}Do you really want to delete?{/t}</li>
                                            <li class="divider"></li>
                                            <li class="text-center">
                                                <button class="btn btn-outline-secondary delete-form">
                                                    <i class="fa fa-trash-o"></i> {t}Delete{/t}
                                                </button>
                                            </li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td class="text-center">
                                    <button type="button" class="add btn btn-success form-add">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    <button type="submit" class="btn btn-success pull-right {if $activeLanguage->isRTL()}ml-3{else}mr-3{/if} mb-3">
                        <i class="fa fa-floppy-o"></i> {t}Save{/t}
                    </button>
                </form>
            </div>
        </div>
    </div>
{/block}
{block name=footerCustomJs append}
    <script>
        $(document).ready(function () {
            $('.form-add').on('click', function (e) {
                e.preventDefault();
                var template = $('.copy-template');
                var container = template.closest('.repeat-container');
                var newRow = template.clone();
                var formLength = container.find('tr:visible').length;
                var count = formLength + 1;
                $('input', newRow).each(function () {
                    $.each(this.attributes, function (index, element) {
                        this.value = this.value.replace('[count]', '[' + count + ']');
                    });
                });
                newRow.removeClass('copy-template');
                newRow.find('input').removeAttr('disabled');
                newRow.appendTo(container);
                app.tooltip_popover();
                return false;
            });

            $(document).on('click', '.delete-form', function () {
                var row = $(this).closest('tr');
                row.remove();
                $('.tooltip.show').remove();
            });
        });
    </script>
{/block}