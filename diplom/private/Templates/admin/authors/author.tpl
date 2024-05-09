{extends file='admin/admin.tpl'}
{block name=title}{if $action == "create"}{t}Add Author{/t}{else}{t}Edit Author{/t}{/if}{/block}
{block name=headerCss append}
    <link href="{$resourcePath}assets/js/plugins/summernote/summernote-bs4.css" rel="stylesheet"/>
{/block}
{block name=content}
    <div class="row">
        <div class="col-md-9">
            <div class="card" id="author-block">
                <div class="card-body">
                    {if $action == "create"}
                        {assign var=route value=$routes->getRouteString("authorCreate")}
                    {elseif $action == "edit" and isset($author)}
                        {assign var=route value=$routes->getRouteString("authorEdit",["authorId"=>$author->getId()])}
                    {elseif $action == "delete"}
                        {assign var=route value=""}
                    {/if}
                    <form action="{$route}" method="post" class="author-form" data-edit="{if $action == "create"}false{else}true{/if}">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="name" class="control-label">{t}First Name{/t}</label>
                                    <input type="text" class="form-control" autocomplete="off" name="firstName" value="{if $action == "edit"}{$author->getFirstName()}{/if}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="name" class="control-label">{t}Middle Name{/t}</label>
                                    <input type="text" class="form-control" autocomplete="off" name="middleName" value="{if $action == "edit"}{$author->getMiddleName()}{/if}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="name" class="control-label">{t}Last Name{/t}</label>
                                    <input type="text" class="form-control" autocomplete="off" name="lastName" value="{if $action == "edit"}{$author->getLastName()}{/if}">
                                    <input type="hidden" name="photoId" class="photoId" value="{if $action == "edit"}{$author->getPhotoId()}{/if}">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="description" class="control-label">{t}Description{/t}</label>
                                    <textarea type="text" class="form-control" autocomplete="off" name="description" id="content-box">{if $action == "edit"}{$author->getDescription()}{/if}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row margin-top-20">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <button type="submit" class="btn btn-outline-secondary disabled pull-right save-author">
                                        <i class="fa fa-floppy-o"></i> {t}Save{/t}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card" id="photo-block">
                <div class="card-body main-image-upload">
                    <div class="fileinput {if $action == "edit" and $author->getPhotoId() != null}fileinput-exists{else}fileinput-new{/if}" style="width: 100%;" data-provides="fileinput">
                        <div class="fileinput-preview thumbnail mb20" data-trigger="fileinput" style="width: 100%; min-height: 150px;">
                            {if $action == "edit" and $author->getPhoto() != null}
                                <img src="{$author->getPhoto()->getWebPath()}" alt="">
                            {else}
                                <img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="">
                            {/if}
                        </div>
                        <div>
                            <a href="#" class="btn btn-outline-secondary fileinput-exists" data-dismiss="fileinput">{t}Remove{/t}</a>
                            <span class="btn btn-outline-secondary btn-file file-input">
                                <span class="fileinput-new">{t}Select image{/t}</span>
                                <span class="fileinput-exists">{t}Change{/t}</span>
                                <input type="file" name="file" value="{if $action == "edit"}{if $author->getPhotoId() != null}{$author->getPhotoId()}{/if}{/if}" class="disabledIt">
                            </span>
                            <a href="#" class="btn btn-outline-secondary uploadPhoto fileinput-exists">
                                <i class="fa fa-upload"></i> {t}Upload{/t}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerPageJs append}
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jasnyupload/fileinput.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/summernote/summernote-bs4.min.js"></script>
{/block}
{block name=footerCustomJs append}
    <script>
        $(document).ready(function () {
            $('#content-box').summernote().on('summernote.change', function () {
                $('.author-form').attr('data-changed', true);
                $('.save-author').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            $(document).on('change', 'input,textarea,select', function () {
                $(this).closest('form').attr('data-changed', true);
                $('.save-author').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            $(document).on('click', '.close', function () {
                $(this).closest('.fileinput').find('input:file').removeClass('file-exists');
            });
            $(document).on('change.bs.fileinput', '.main-image-upload .fileinput, .gallery-image-upload .fileinput', function () {
                $(this).attr('data-changed', true);
                $('.author-form').attr('data-changed', true);
                $('.save-author').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
                $(this).find('input:file').addClass('file-exists');
            });
            var photoUploadUrl = '{$routes->getRouteString("authorPhotoUpload",[])}';
            $('.uploadPhoto').on('click', function (e) {
                e.preventDefault();
                var rowData, fileValue, file;

                var dataChanged = $('.main-image-upload .fileinput').attr('data-changed');
                var imageUploadElement = $('.main-image-upload');

                if (dataChanged == 'true') {
                    rowData = new FormData();
                    file = $(imageUploadElement).find('input:file');
                    fileValue = $(imageUploadElement).find('input:file').val();
                    var photoId = $('.coverId').val();
                    if ($(file)[0].files[0] != null) {
                        rowData.append('file', $(file)[0].files[0], fileValue);
                        if (photoId) {
                            rowData.append('photoId', photoId);
                        }
                    } else if ($(file).closest('.fileinput').hasClass('fileinput-new')) {
                        rowData.append('file', null);
                        if (photoId) {
                            rowData.append('photoId', photoId);
                        }
                    } else {
                        rowData.append('file', '');
                        if (photoId) {
                            rowData.append('photoId', photoId);
                        }
                    }
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        processData: false,
                        contentType: false,
                        data: rowData,
                        url: photoUploadUrl,
                        beforeSend: function (data) {
                            app.card.loading.start('#photo-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.photoId').val(data.imageId);
                                    $('.save-author').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#photo-block');
                        }
                    });
                }
            });
            var authorEditUrl = '{$routes->getRouteString("authorEdit",[])}';
            $('.save-author').on('click', function (e) {
                e.preventDefault();
                var form = $(this).closest('form');
                var dataEdit = form.attr('data-edit');
                var dataChanged = form.attr('data-changed');
                if (dataChanged == 'true') {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        data: form.serialize(),
                        url: form.attr('action'),
                        beforeSend: function (data) {
                            app.card.loading.start('#author-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    form.attr('action', authorEditUrl.replace("[authorId]", data.authorId)).attr('data-changed', false);
                                    app.notification('success', '{t}Data has been saved successfully{/t}');
                                    $('.save-author').removeClass('btn-outline-success').addClass('btn-outline-secondary disabled');
                                    if (dataEdit == 'false') {
                                        $('.page-title h3').text('{t}Edit Author{/t}');
                                        history.pushState(null, '', authorEditUrl.replace("[authorId]", data.authorId));
                                    }
                                    $(form).attr('data-edit', true);
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#author-block');
                        }
                    });
                } else {
                    app.notification('information', '{t}There are no changes{/t}');
                }
            });
        });
    </script>
{/block}