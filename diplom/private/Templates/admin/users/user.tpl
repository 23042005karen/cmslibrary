{extends file='admin/admin.tpl'}
{block name=title}{if $action == "create"}{t}Add User{/t}{else}{t}Edit User{/t}{/if}{/block}
{block name=headerCss append}
    <link href="{$resourcePath}assets/css/plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet"/>
{/block}
{block name=content}
    <div class="row">
        <div class="col-lg-8 col-xlg-9 col-md-7">
            {if $action == "create"}
                {assign var=route value=$routes->getRouteString("userCreate")}
            {elseif $action == "edit" and isset($editedUser)}
                {assign var=route value=$routes->getRouteString("userEdit",["userId"=>$editedUser->getId()])}
            {elseif $action == "delete"}
                {assign var=route value=""}
            {/if}
            <form action="{$route}" method="post" class="card form-horizontal validate user-form" data-edit="{if $action == "create"}false{else}true{/if}">
                {if isset($user) and $user->getRole() != null and $user->getRole()->getPriority() >= 255}
                    <div class="card-header pt-0 pb-0">
                        <div class="heading-elements">
                            <label class="switch switch-sm" data-container="body" data-toggle="tooltip" title="{t}Account Status (Active/Inactive){/t}">
                                <input type="checkbox" name="isActive" value="1"{if $action == "edit" and $editedUser->isActive()} checked{/if}>
                            </label>
                            <input type="hidden" name="userId" class="userId" value="{if $action == "edit" and isset($editedUser)}{$editedUser->getId()}{/if}">
                            <input type="hidden" name="photoId" class="photoId" value="{if $action == "edit"}{$editedUser->getPhotoId()}{/if}">
                        </div>
                    </div>
                {else}
                    <input type="hidden" name="isActive" value="{if $action == "edit" and $editedUser->isActive()}1{elseif $action == "create"}1{else}0{/if}">
                    <input type="hidden" name="userId" class="userId" value="{if $action == "edit" and isset($editedUser)}{$editedUser->getId()}{/if}">
                    <input type="hidden" name="photoId" class="photoId" value="{if $action == "edit"}{$editedUser->getPhotoId()}{/if}">
                {/if}
                <div class="card-body">
                    <div class="row">
                        <div class="{if isset($user) and $user->getRole() != null and $user->getRole()->getPriority() >= 255}col-lg-6{else}col-lg-12{/if}">
                            <div class="form-group">
                                <label class="control-label">{t}Email{/t}
                                    {if $action == "create"}
                                        <i class="fa fa-info-circle text-warning" data-container="body" data-toggle="tooltip" title="{t}required{/t}"></i>
                                    {/if}
                                </label>
                                <input type="text" class="form-control" autocomplete="off" data-email="{if $action == "edit"}{$editedUser->getEmail()}{/if}" id="email" name="email" placeholder="{t}Login{/t}" value="{if $action == "edit"}{$editedUser->getEmail()}{/if}">
                            </div>
                        </div>
                        {if isset($user) and $user->getRole() != null and $user->getRole()->getPriority() >= 255}
                            <div class="col-lg-6">
                                {if isset($roles)}
                                    <div class="form-group">
                                        <label for="roleId">{t}User Role{/t}</label>
                                        <select name="roleId" id="roleId" class="form-control select-picker">
                                            {foreach from=$roles item=role name=role}
                                                <option value="{$role->getId()}" {if isset($editedUser) and $editedUser->getRole() !== null and $editedUser->getRole()->getId() == $role->getId()}selected{/if}>{$role->getName()}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                {/if}
                            </div>
                        {else}
                            <input type="hidden" name="roleId" value="{if isset($editedUser) and $editedUser->getRole() !== null}{$editedUser->getRole()->getId()}{else}3{/if}" readonly>
                        {/if}
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="control-label">{if $action == "edit"}{t}New Password{/t}{else}{t}Password{/t}{/if}
                                    {if $action == "create"}
                                        <i class="fa fa-info-circle text-warning" data-container="body" data-toggle="tooltip" title="{t}required{/t}"></i>
                                    {/if}
                                    {if $action == "edit"}
                                        <i class="fa fa-exclamation-circle" data-toggle="tooltip" data-trigger="hover" data-original-title="{t}If you do not want to change your password, leave blank.{/t}"></i>
                                    {/if}
                                </label>
                                <input type="password" class="form-control" autocomplete="off" name="password" id="mainPassword">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="control-label">{if $action == "edit"}{t}Confirm New Password{/t}{else}{t}Confirm Password{/t}{/if}
                                    {if $action == "create"}
                                        <i class="fa fa-info-circle text-warning" data-container="body" data-toggle="tooltip" title="{t}required{/t}"></i>
                                    {/if}
                                </label>
                                <input type="password" class="form-control confirmPassword" autocomplete="off" name="confirmPassword">
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="firstName" class="control-label">{t}First Name{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="firstName" value="{if $action == "edit"}{$editedUser->getFirstName()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="middleName" class="control-label">{t}Middle Name{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="middleName" value="{if $action == "edit"}{$editedUser->getMiddleName()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="lastName" class="control-label">{t}Last Name{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="lastName" value="{if $action == "edit"}{$editedUser->getLastName()}{/if}">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="gender" class="control-label">{t}Gender{/t}</label>
                                <select name="gender" class="form-control select-picker">
                                    <option value="Male"{if $action == "edit" and $editedUser->getGender() == 'Male'} selected{/if}>{t}Male{/t}</option>
                                    <option value="Female"{if $action == "edit" and $editedUser->getGender() == 'Female'} selected{/if}>{t}Female{/t}</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="phone" class="control-label">{t}Phone{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="phone" value="{if $action == "edit"}{$editedUser->getPhone()}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="address" class="control-label">{t}Address{/t}</label>
                                <input type="text" class="form-control" autocomplete="off" name="address" value="{if $action == "edit"}{$editedUser->getAddress()}{/if}">
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <button type="submit" class="btn btn-outline-secondary disabled btn-icon-fixed pull-right save-user">
                                    <i class="fa fa-floppy-o"></i> {t}Save{/t}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-lg-4 col-xlg-3 col-md-5">
            <div class="card main-image-upload" id="photo-card">
                <div class="card-body">
                    <div class="fileinput {if $action == "edit" and $editedUser->getPhotoId() != null}fileinput-exists{else}fileinput-new{/if}" data-provides="fileinput">
                        <div class="fileinput-preview thumbnail mb20" data-trigger="fileinput" style="width: 100%; min-height: 150px;">
                            {if $action == "edit" and $editedUser->getPhoto() != null}
                                <img src="{$editedUser->getPhoto()->getWebPath()}"/>
                            {else}
                                <img src="{$siteViewOptions->getOptionValue("noUserImageFilePath")}" alt="">
                            {/if}
                        </div>
                        <div>
                            <a href="#" class="btn btn-sm btn-outline-secondary fileinput-exists delete-main-img" data-id="{if $action == "edit" and isset($editedUser)}{$editedUser->getPhotoId()}{/if}" data-dismiss="fileinput">{t}Remove{/t}</a>
                            <span class="btn btn-sm btn-outline-secondary btn-file file-input"><span class="fileinput-new">{t}Select image{/t}</span><span class="fileinput-exists">{t}Change{/t}</span><input type="file" name="file" value="{if $action == "edit"}{if $editedUser->getPhotoId() != null}{$editedUser->getPhotoId()}{/if}{/if}"></span>
                            <a href="#" class="btn btn-sm btn-outline-secondary fileinput-exists uploadPhoto">
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
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/jquery-validate/jquery.validate.js"></script>
    <script type="text/javascript" src="{$resourcePath}assets/js/plugins/bootstrap-select/bootstrap-select.js"></script>
{/block}
{block name=footerCustomJs append}
    <script>
        $(document).ready(function () {
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
                ignore: null,
                messages: {
                    email: {
                        remote: jQuery.validator.format("<strong>{literal}{0}{/literal}</strong> {t}is already exist. Please use another email{/t}.")
                    }
                },
                rules: {
                    {if (isset($editedUser) and !$editedUser->isLdapUser()) or $action == "create"}
                    email: {
                        required: true,
                        email: true,
                        remote: {
                            param: {
                                delay: 500,
                                url: '{$routes->getRouteString("userEmailCheck",[])}',
                                type: "post",
                                data: {
                                    email: function () {
                                        return $("#email").val();
                                    }
                                },
                                error: function (jqXHR, exception) {
                                    app.notification('error', app.getErrorMessage(jqXHR, exception));
                                }
                            },
                            depends: function (element) {
                                return ($(element).val() !== $("#email").attr('data-email'));
                            }
                        }
                    },
                    {/if}
                    {if $action == "create"}password: "required",{/if}
                    confirmPassword: {
                        equalTo: "#mainPassword"
                    }
                }
            });
            $(document).on('change', 'input,textarea,select', function () {
                $(this).closest('form').attr('data-changed', true);
                $('.save-user').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
            });
            $(document).on('click', '.close', function () {
                $(this).closest('.fileinput').find('input:file').removeClass('file-exists');
            });
            $(document).on('change.bs.fileinput', '.main-image-upload .fileinput', function () {
                $(this).attr('data-changed', true);
                $('.user-form').attr('data-changed', true);
                $('.save-user').removeClass('btn-outline-secondary disabled').addClass('btn-outline-success');
                $(this).find('input:file').addClass('file-exists');
            });
            var imageDeleteUrl = '{$routes->getRouteString("imageDelete",[])}';
            $(document).on('clear.bs.fileinput', '.main-image-upload .fileinput', function () {
                var imgId = $(this).find('.delete-main-img').attr('data-id');
                console.log('imgId = ' + imgId);
                if (imgId != undefined && imgId != null && imgId > 0) {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        url: imageDeleteUrl.replace("[imageId]", imgId),
                        beforeSend: function (data) {
                            app.card.loading.start('#photo-card');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.photoId').val('');
                                    $('.save-user').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#photo-card');
                        }
                    });
                }
            });

            var photoUploadUrl = '{$routes->getRouteString("userPhotoUpload",[])}';
            $('.uploadPhoto').on('click', function (e) {
                e.preventDefault();
                var rowData, fileValue, file;

                var dataChanged = $('.main-image-upload .fileinput').attr('data-changed');
                var imageUploadElement = $('.main-image-upload');

                if (dataChanged == 'true') {
                    rowData = new FormData();
                    file = $(imageUploadElement).find('input:file');
                    fileValue = $(imageUploadElement).find('input:file').val();
                    var photoId = $('.photoId').val();
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
                            app.card.loading.start('#photo-card');
                        },
                        success: function (data) {
                            if (data.redirect) {
                                window.location.href = data.redirect;
                            } else {
                                if (data.error) {
                                    app.notification('error', data.error);
                                } else {
                                    $('.photoId').val(data.imageId);
                                    $('.save-user').click();
                                }
                            }
                        },
                        error: function (jqXHR, exception) {
                            app.notification('error', app.getErrorMessage(jqXHR, exception));
                        },
                        complete: function (data) {
                            app.card.loading.finish('#photo-card');
                        }
                    });
                }
            });
            var userEditUrl = '{$routes->getRouteString("userEdit",[])}';
            $('.save-user').on('click', function (e) {
                e.preventDefault();
                var form = $(this).closest('form');
                var dataEdit = form.attr('data-edit');
                var dataChanged = form.attr('data-changed');
                if (dataChanged == 'true') {
                    if ($(form).valid()) {
                        $('.confirmPassword').attr('disabled', true);
                        $.ajax({
                            dataType: 'json',
                            method: 'POST',
                            data: form.serialize(),
                            url: form.attr('action'),
                            beforeSend: function (data) {
                                app.card.loading.start('.card');
                            },
                            success: function (data) {
                                if (data.redirect) {
                                    window.location.href = data.redirect;
                                } else {
                                    if (data.error) {
                                        app.notification('error', data.error);
                                    } else {
                                        form.attr('action', userEditUrl.replace("[userId]", data.userId)).attr('data-changed', false).find('.userId').val(data.userId);
                                        $('.save-user').removeClass('btn-outline-success').addClass('btn-outline-secondary disabled');
                                        app.notification('success', '{t}Data has been saved successfully{/t}');
                                        if (dataEdit == 'false') {
                                            $('.page-title h3').text('{t}Edit User{/t}');
                                            history.pushState(null, '', userEditUrl.replace("[userId]", data.userId));
                                        }
                                        $(form).attr('data-edit', true);
                                    }
                                }
                            },
                            error: function (jqXHR, exception) {
                                app.notification('error', app.getErrorMessage(jqXHR, exception));
                            },
                            complete: function (data) {
                                $('.confirmPassword').attr('disabled', false);
                                app.card.loading.finish('.card');
                            }
                        });
                    }
                } else {
                    app.notification('information', '{t}There are no changes{/t}');
                }
            });
        });
    </script>
{/block}