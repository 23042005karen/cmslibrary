{extends file='admin/admin.tpl'}
{block name=title}{if $action == "create"}{t}Add Post{/t}{else}{t}Edit Post{/t}{/if}{/block}
{block name=toolbar}
    {if $action == "edit"}
        <div class="heading-elements">
            <a href="{$routes->getRouteString("postViewPublic",["postUrl"=>$post->getUrl()])}" class="btn btn-outline-info btn-icon-fixed" target="_blank">
                <i class="fa fa-eye"></i> {t}View Post{/t}
            </a>
        </div>
    {/if}
{/block}
{block name=headerCss append}
    <link href="{$resourcePath}assets/css/plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet"/>
    <link href="{$resourcePath}assets/js/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css" media="screen">
    <link href="{$resourcePath}assets/js/plugins/summernote/summernote-bs4.css" rel="stylesheet"/>
{/block}
{block name=content}
    {if $action == "create"}
        {assign var=route value=$routes->getRouteString("postCreate")}
    {elseif $action == "edit" and isset($post)}
        {assign var=route value=$routes->getRouteString("postEdit",["postId"=>$post->getId()])}
    {elseif $action == "delete"}
        {assign var=route value=""}
    {/if}
    <form action="{$route}" method="post" class="row validate post-form" data-edit="{if $action == "create"}false{else}true{/if}">
        <div class="col-lg-8 col-xlg-9 col-md-7">
            <div class="card">
                <div class="card-body">
                    <input type="hidden" name="id" value="{if $action == "edit" and isset($post)}{$post->getId()}{/if}" class="postId">
                    <input type="hidden" name="imageId" value="{if $action == "edit" and isset($post)}{$post->getImageId()}{/if}" class="imageId">
                    <div class="form-group">
                        <label for="title">{t}Title{/t}</label>
                        <input type="text" name="title" class="form-control" value="{if $action == "edit" and isset($post)}{$post->getTitle()}{/if}">
                    </div>
                    <div class="form-group">
                        <label for="secondTitle">{t}Second Title{/t}</label>
                        <input type="text" name="secondTitle" class="form-control input-sm mb10 mt20" value="{if $action == "edit" and isset($post)}{$post->getSecondTitle()}{/if}">
                    </div>
                    {if $action == "edit" and isset($post) and $post->getId() == 0}
                        <input type="hidden" name="url" value="{if $action == "edit" and isset($post)}{$post->getUrl()}{/if}">
                    {else}
                        <div class="form-group">
                            <label for="url">{t}URL{/t}</label>
                            <input type="text" name="url" class="form-control input-sm mb10" value="{if $action == "edit" and isset($post)}{$post->getUrl()}{/if}" id="urlPath">
                        </div>
                    {/if}
                    <a data-toggle="modal" href="#postGallery" class="btn btn-outline-info btn-icon-fixed mb-2" id="openGallery">
                        <i class="fa fa-image"></i> {t}Gallery{/t}
                    </a>
                    <div class="form-group">
                        <label for="content">{t}Content{/t}</label>
                        <textarea class="form-control" name="content" id="content-box">{if isset($post)}{$post->getContent()}{/if}</textarea>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="form-group">
                        <label for="shortDescription">{t}Short Description{/t}</label>
                        <textarea name="shortDescription" maxlength="250" cols="30" rows="2" class="form-control">{if $action == "edit"}{$post->getShortDescription()}{/if}</textarea>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="form-group">
                        <label for="shortDescription">{t}Meta Title{/t}</label>
                        <input type="text" name="metaTitle" class="form-control" value="{if $action == "edit"}{$post->getMetaTitle()}{/if}">
                    </div>
                    <div class="form-group">
                        <label for="shortDescription">{t}Meta Keywords{/t}</label>
                        <select name="metaKeySelect" id="meta-key" class="form-control" multiple>
                            {if $action == "edit"}
                                {assign var="tagList" value=","|explode:$post->getMetaKeywords()}
                                {foreach from=$tagList item=tag}
                                    {if $tag != null}
                                        <option value="{$tag}" selected>{$tag}</option>
                                    {/if}
                                {/foreach}
                            {/if}
                        </select>
                        <input type="hidden" name="metaKeywords" id="metaKeyList" value="{if $action == "edit"}{$post->getMetaKeywords()}{/if}">
                    </div>
                    <div class="form-group">
                        <label for="shortDescription">{t}Meta Description{/t}</label>
                        <textarea name="metaDescription" cols="30" rows="2" style="width:100% !important" class="form-control">{if $action == "edit"}{$post->getMetaDescription()}{/if}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-xlg-3 col-md-5">
            <div class="card">
                <div class="card-body">
                    <div class="form-group">
                        <label for="title">{t}Status{/t}</label>
                        {if isset($postStatuses)}
                            <select name="status" class="form-control select-picker">
                                {foreach $postStatuses as $postStatusKey => $postStatusValue}
                                    <option value="{$postStatusKey}"{if isset($post) and $post->getStatus() !== null and $post->getStatus() ===$postStatusValue} selected{/if}>{$postStatusValue}</option>
                                {/foreach}
                            </select>
                        {/if}
                    </div>
                    <div class="form-group">
                        <label for="title">{t}Published on{/t}</label>
                        <input class="form-control date-picker" name="publishDateTime" type="text" value="{if $action == "edit" and isset($post)}{$post->getPublishDateTime()|date_format:$siteViewOptions->getOptionValue("inputDateTimeFormat")}{/if}">
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-outline-secondary disabled btn-icon-fixed pull-right save-post">
                            <i class="fa fa-floppy-o"></i> {t}Save{/t}
                        </button>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="form-group">
                        <label for="categories[]">{t}Categories{/t}</label>
                        {if isset($categories)}
                            <ul class="list-unstyled mb0">
                                {foreach $categories as $category}
                                    <li>
                                        {assign var=isCategorySelected value=false}
                                        {if isset($post) and $post->getCategories() !== null}
                                            {foreach $post->getCategories() as $cat}
                                                {if $cat->getId() === $category->getId()}
                                                    {$isCategorySelected = true}
                                                    {break}
                                                {/if}
                                            {/foreach}
                                        {/if}
                                        <div class="app-checkbox">
                                            <label><input type="checkbox" class="serviceFlag" id="{$category->getId()}" name="categories[]" value="{$category->getId()}"{if $isCategorySelected} checked{/if}> {$category->getName()}
                                            </label>
                                        </div>
                                    </li>
                                {/foreach}
                            </ul>
                        {/if}
                    </div>
                </div>
            </div>
            <div class="card" id="image-block">
                <div class="card-body main-image-upload">
                    <label for="file">{t}Image{/t}</label>
                    <div class="fileinput {if $action == "edit" and $post->getImageId() != null}fileinput-exists{else}fileinput-new{/if}" style="width: 100%;" data-provides="fileinput">
                        <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 100%; min-height: 150px;">
                            {if $action == "edit" and $post->getImage() != null}
                                <img src="{$post->getImage()->getWebPath()}" alt="">
                            {else}
                                <img src="{$siteViewOptions->getOptionValue("noBookImageFilePath")}" alt="">
                            {/if}
                        </div>
                        <div>
                            <a href="#" class="btn btn-sm btn-outline-secondary fileinput-exists delete-main-img" data-id="{if $action == "edit" and isset($post)}{$post->getImageId()}{/if}" data-dismiss="fileinput">{t}Remove{/t}</a>
                            <span class="btn btn-sm btn-outline-secondary btn-file file-input">
                                <span class="fileinput-new">{t}Select image{/t}</span>
                                <span class="fileinput-exists">{t}Change{/t}</span>
                                <input type="file" name="file" value="{if $action == "edit"}{if $post->getImageId() != null}{$post->getImageId()}{/if}{/if}">
                            </span>
                            <a href="#" class="btn btn-sm btn-outline-secondary uploadMainImage fileinput-exists">
                                <i class="fa fa-upload"></i> {t}Upload{/t}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="modal fade" id="postGallery" tabindex="-1" role="dialog" aria-labelledby="postGalleryLabel" aria-hidden="true">
        <div class="modal-dialog" style="max-width: 80%;">
            <div class="modal-content card">
                <div class="modal-header">
                    <h2 class="modal-title">{t}Gallery{/t}</h2>
                </div>
                <div class="modal-body" id="galleryBlock">
                </div>
                <div class="modal-footer gallery-image-upload">
                    <div class="fileinput fileinput-new" data-provides="fileinput">
                        <span class="btn btn-sm btn-outline-secondary btn-file">
                            <span class="fileinput-new">{t}Select file{/t}</span>
                            <span class="fileinput-exists">{t}Change{/t}</span>
                            <input type="file" name="file">
                        </span>
                        <span class="fileinput-filename"></span>
                        <a href="#" class="close fileinput-exists" data-dismiss="fileinput" style="float: none">&times;</a>
                    </div>
                    <a href="#" class="btn btn-sm btn-outline-secondary uploadGalleryImage">
                        <i class="fa fa-upload"></i> {t}Upload{/t}
                    </a>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name=footerPageJs append}
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/select2/select2.full.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jasnyupload/fileinput.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jquery-validate/jquery.validate.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-select/bootstrap-select.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/moment/moment.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/summernote/summernote-bs4.min.js"></script>
{/block}
{block name=footerCustomJs append}
    <script>
        $(document).ready(function () {
            $('.date-picker').datetimepicker({
                format: '{$siteViewOptions->getOptionValue("inputDateTimeFormatJS")}',
                keepOpen: true
            }).on('dp.change', function () {
                $(this).closest('form').attr('data-changed', true);
                $('.save-post').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            $('.validate input,.validate select,.validate textarea').tooltipster({
                trigger: 'custom',
                onlyOne: false,
                position: 'bottom',
                offsetY: -5,
                theme: 'tooltipster-kaa'
            });
            $('.validate').validate({
                errorPlacement: function (error, element) {
                    if (element != undefined) {
                        $(element).tooltipster('update', $(error).text());
                        $(element).tooltipster('show');
                    }
                },
                success: function (label, element) {
                    $(element).tooltipster('hide');
                },
                rules: {
                    title: {
                        required: true
                    }{if  $action == "create" or ($action == "edit" and isset($post) and $post->getId() != 0)},
                    url: {
                        urlpath: true
                    }{/if}
                }
            });
            $('#meta-key').select2({
                multiple: true,
                tags: true,
                allowClear: true,
                language: {
                    noResults: function () {
                        return "{t}Please enter keywords{/t}";
                    }
                }
            }).on('change.select2', function () {
                $("#metaKeyList").val($(this).val());
            });
            $(document).on('click', '.ajax-page', function (e) {
                e.preventDefault();
                $.ajax({
                    url: $(this).attr('href'),
                    dataType: 'json',
                    beforeSend: function () {
                        app.card.loading.start($("#galleryBlock").parents('.modal-content'));
                    },
                    success: function (data) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                $("#galleryBlock").html(data.html);
                            }
                        }
                    },
                    complete: function () {
                        app.card.loading.finish($("#galleryBlock").parents('.modal-content'));
                    },
                    error: function (jqXHR, exception) {
                        app.notification('error', app.getErrorMessage(jqXHR, exception));
                    }
                });
            });
            var imagesUrl = '{$routes->getRouteString("imageListView",[])}';
            $('#openGallery').on('click', function (e) {
                e.preventDefault();
                $.ajax({
                    url: imagesUrl,
                    dataType: 'json',
                    beforeSend: function () {
                        app.card.loading.start($("#galleryBlock").parents('.modal-content'));
                    },
                    success: function (data) {
                        if (data.redirect) {
                            window.location.href = data.redirect;
                        } else {
                            if (data.error) {
                                app.notification('error', data.error);
                            } else {
                                $("#galleryBlock").html(data.html);
                            }
                        }
                    },
                    complete: function () {
                        app.card.loading.finish($("#galleryBlock").parents('.modal-content'));
                    },
                    error: function (jqXHR, exception) {
                        app.notification('error', app.getErrorMessage(jqXHR, exception));
                    }
                });
            });

            $('#content-box').summernote().on('summernote.change', function () {
                $('.post-form').attr('data-changed', true);
                $('.save-post').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });

            $(document).on('change keypress', 'input,textarea,select', function () {
                $(this).closest('form').attr('data-changed', true);
                $('.save-post').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            var postEditUrl = '{$routes->getRouteString("postEdit",[])}';
            $('.save-post').on('click', function (e) {
                e.preventDefault();
                var form = $(this).closest('form');
                var dataEdit = form.attr('data-edit');
                var dataChanged = form.attr('data-changed');
                if (dataChanged == 'true') {
                    if (form.valid()) {
                        $.ajax({
                            dataType: 'json',
                            method: 'POST',
                            data: form.serialize(),
                            url: form.attr('action'),
                            beforeSend: function () {
                                app.card.loading.start('.card');
                            },
                            success: function (data) {
                                if (data.redirect) {
                                    window.location.href = data.redirect;
                                } else {
                                    if (data.error) {
                                        app.notification('error', data.error);
                                    } else {
                                        form.attr('action', postEditUrl.replace("[postId]", data.postId)).attr('data-changed', false);
                                        $('.postId').val(data.postId);
                                        app.notification('success', '{t}Data has been saved successfully{/t}');
                                        $('.save-post').removeClass('btn-outline-success').addClass('btn-outline-secondary disabled');
                                        if (dataEdit == 'false') {
                                            $('.page-title h3').text('{t}Edit Post{/t}');
                                            history.pushState(null, '', postEditUrl.replace("[postId]", data.postId));
                                        }
                                        $(form).attr('data-edit', true);
                                    }
                                }
                            },
                            error: function (jqXHR, exception) {
                                app.notification('error', app.getErrorMessage(jqXHR, exception));
                            },
                            complete: function () {
                                app.card.loading.finish('.card');
                            }
                        });
                    } else {
                        app.notification('error', '{t}Validation errors occurred. Please confirm the fields and submit it again.{/t}');
                    }
                } else {
                    app.notification('information', '{t}There are no changes{/t}');
                }
            });
            $(document).on('click', '.close', function () {
                $(this).closest('.fileinput').find('input:file').removeClass('file-exists');
            });
            var imageDeleteUrl = '{$routes->getRouteString("imageDelete",[])}';
            $(document).on('clear.bs.fileinput', '.main-image-upload .fileinput', function () {
                var imgId = $(this).find('.delete-main-img').attr('data-id');
                if (imgId != undefined && imgId != null && imgId > 0) {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        url: imageDeleteUrl.replace("[imageId]", imgId),
                        beforeSend: function (data) {
                            app.card.loading.start('#image-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.imageId').val('');
                                    $('.save-post').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#image-block');
                        }
                    });
                }
            });
            $(document).on('change.bs.fileinput', '.main-image-upload .fileinput, .gallery-image-upload .fileinput', function () {
                $(this).attr('data-changed', true);
                $(this).find('input:file').addClass('file-exists');
                $('.save-post').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            var imageUploadUrl = '{$routes->getRouteString("postImageUpload",[])}';
            $('.uploadMainImage').on('click', function (e) {
                e.preventDefault();
                var data, fileValue, file;

                var dataChanged = $('.main-image-upload .fileinput').attr('data-changed');
                var imageUploadElement = $('.main-image-upload');

                if (dataChanged == 'true') {
                    data = new FormData();
                    file = $(imageUploadElement).find('input:file');
                    fileValue = $(imageUploadElement).find('input:file').val();
                    var imageId = $('.imageId').val();
                    if ($(file)[0].files[0] != null) {
                        data.append('file', $(file)[0].files[0], fileValue);
                        if (imageId) {
                            data.append('imageId', imageId);
                        }
                    } else if ($(file).closest('.fileinput').hasClass('fileinput-new')) {
                        data.append('file', null);
                        if (imageId) {
                            data.append('imageId', imageId);
                        }
                    } else {
                        data.append('file', '');
                        if (imageId) {
                            data.append('imageId', imageId);
                        }
                    }
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        processData: false,
                        contentType: false,
                        data: data,
                        url: imageUploadUrl,
                        beforeSend: function () {
                            app.card.loading.start('#image-block');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.imageId').val(data.imageId);
                                    $('.delete-main-img').attr('data-id', data.imageId);
                                    $('.save-post').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function () {
                            app.card.loading.finish('#image-block');
                        }
                    });
                } else {
                    app.notification('information', '{t}Please Choose Image{/t}');
                }
            });
            function dirname(path) {
                return path.replace(/\\/g, '/').replace(/\/[^\/]*$/, '');
            }

            function basename(path) {
                return path.replace(/\\/g, '/').replace(/.*\//, '');
            }

            $('.uploadGalleryImage').on('click', function (e) {
                e.preventDefault();
                var data, fileValue, file;
                var elem = $(this);
                var dataChanged = $('.gallery-image-upload .fileinput').attr('data-changed');
                var imageUploadElement = $('.gallery-image-upload');
                if (dataChanged == 'true') {
                    data = new FormData();
                    file = $(imageUploadElement).find('input:file');
                    fileValue = $(imageUploadElement).find('input:file').val();
                    if ($(file)[0].files[0] != null) {
                        data.append('file', $(file)[0].files[0], fileValue);
                    } else if ($(file).closest('.fileinput').hasClass('fileinput-new')) {
                        data.append('file', null);
                    } else {
                        data.append('file', '');
                    }
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        processData: false,
                        contentType: false,
                        data: data,
                        url: imageUploadUrl,
                        beforeSend: function () {
                            app.card.loading.start($("#galleryBlock").parents('.modal-content'));
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    var row_template = $('.gallery-clone').clone();
                                    $(row_template).removeClass('gallery-clone').prependTo("#image-list");
                                    var path = dirname(data.url);
                                    var filename = basename(data.url);
                                    var smallImg = path + '/small/' + filename;
                                    var originalImg = data.url;
                                    $(row_template).find('.tile-image-title p').text(filename);
                                    $(row_template).find('.thumb-img').attr('src', smallImg);
                                    $(row_template).find('button').attr('data-id', data.imageId);
                                    $(row_template).find('.original-path').attr('data-clipboard-text', originalImg);
                                    $(elem).closest('.gallery-image-upload').find('.close').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function () {
                            app.card.loading.finish($("#galleryBlock").parents('.modal-content'));
                        }
                    });
                } else {
                    app.notification('information', '{t}Please Choose Image{/t}');
                }

            });
            (function () {
                function createNode(text) {
                    var node = document.createElement('pre');
                    node.style.width = '1px';
                    node.style.height = '1px';
                    node.style.position = 'fixed';
                    node.style.top = '5px';
                    node.textContent = text;
                    return node;
                }

                function copyNode(node) {
                    var selection = getSelection();
                    selection.removeAllRanges();

                    var range = document.createRange();
                    range.selectNodeContents(node);
                    selection.addRange(range);

                    document.execCommand('copy');
                    selection.removeAllRanges();
                }

                function copyText(text) {
                    var node = createNode(text);
                    document.body.appendChild(node);
                    copyNode(node);
                    document.body.removeChild(node);
                }

                function copyInput(node) {
                    node.select();
                    document.execCommand('copy');
                    getSelection().removeAllRanges();
                }

                function isFormInput(element) {
                    return element.nodeName === 'INPUT' || element.nodeName === 'TEXTAREA';
                }

                $(document).on('click', '.copy-path', function () {
                    var text;
                    if (text = this.getAttribute('data-clipboard-text')) {
                        copyText(text);
                    } else {
                        var container = this.closest('.js-copy-container');
                        var content = container.querySelector('.js-copy-target');
                        if (isFormInput(content)) {
                            if (content.type === 'hidden') {
                                copyText(content.value);
                            } else {
                                copyInput(content);
                            }
                        } else {
                            copyNode(content);
                        }
                    }
                    this.blur();
                });
            }).call(this);
            $(document).on('click', '.delete-img', function (e) {
                e.preventDefault();
                var imgId = $(this).attr('data-id');

                var elem = $(this).closest('.gallery-img');
                if (imgId != undefined && imgId != null) {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        url: imageDeleteUrl.replace("[imageId]", imgId),
                        beforeSend: function () {
                            app.card.loading.start($("#galleryBlock").parents('.modal-content'));
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $(elem).remove();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function () {
                            app.card.loading.finish($("#galleryBlock").parents('.modal-content'));
                        }
                    });
                }
            });
        });
    </script>
{/block}