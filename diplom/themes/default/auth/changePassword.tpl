<!DOCTYPE html>
<html lang="en" style="height: 100%;">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="KAASoft">
        <meta name="robots" content="noindex,nofollow">
        <title>{$pageTitle}</title>
        <link href="{$resourcePath}assets/css/plugins/bootstrap/bootstrap.min.css" rel="stylesheet">
        <link href="{$resourcePath}assets/css/style.css" rel="stylesheet">
        <link rel="icon" type="image/png" sizes="32x32" href="{$siteViewOptions->getOptionValue("favIconFilePath")}">
    </head>
    <body style="min-height: 100%;background: linear-gradient(180deg,#f0f0f0 0,#dee1e3 100%) !important;">
        <section id="wrapper">
            <div class="login-register">
                <div class="login-box card">
                    <div class="card-body">
                        <img src="{$siteViewOptions->getOptionValue("logoFilePath")}" class="d-flex ml-auto mr-auto mb-4 mt-2" alt="{t}Logo{/t}"/>
                        {include 'errors.tpl'}
                        <form action="{$routes->getRouteString("passwordChange")}" class="form-horizontal validate" method="post">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="icon-key"></i>
                                    </span>
                                    <input type="password" name="password" class="form-control" id="mainPassword" placeholder="{t}New Password{/t}" autocomplete="off">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="icon-key"></i>
                                    </span>
                                    <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" placeholder="{t}Confirm Password{/t}" autocomplete="off">
                                </div>
                            </div>
                            <div class="form-message"></div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <a href="{$routes->getRouteString("adminLogin")}" class="btn btn-info pull-left">{t}Go Back{/t}</a>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary btn-block changePassword">{t}Change{/t}</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <script src="{$resourcePath}assets/js/plugins/jquery/jquery-3.2.1.min.js"></script>
        <script src="{$resourcePath}assets/js/plugins/bootstrap/popper.min.js"></script>
        <script src="{$resourcePath}assets/js/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="{$resourcePath}assets/js/plugins/jquery-validate/jquery.validate.js"></script>
        <script src="{$resourcePath}assets/js/plugins/tooltipster/jquery.tooltipster.min.js"></script>
        <script src="{$resourcePath}assets/js/main.js"></script>
        <script>
            $('.validate input,.validate textarea,.validate select').tooltipster({
                trigger: 'custom',
                onlyOne: false,
                position: 'bottom',
                offsetY: -5,
                theme: 'tooltipster-kaa'
            });
            $(".validate").validate({
                errorPlacement: function (error, element) {
                    $(element).tooltipster('update', $(error).text());
                    $(element).tooltipster('show');
                },
                success: function (label, element) {
                    $(element).tooltipster('hide');
                },
                rules: {
                    password: {
                        required: true
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: '#mainPassword'
                    }
                }
            });
            $('.changePassword').on('click', function (e) {
                e.preventDefault();
                var form = $(this).closest('form');
                if (form.valid()) {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        data: $('#mainPassword').serialize(),
                        url: $(form).attr('action').replace('[token]', '{$token}'),
                        beforeSend: function (data) {
                            app.card.loading.start($('.login-box'));
                        },
                        success: function (data) {
                            if (data.error == undefined) {
                                $(form).find('.form-message').addClass('alert alert-success alert-dismissable').text(data.success).fadeIn();
                                $(form).find("input[type=text], textarea").val("");
                                setTimeout(function () {
                                    $(form).find('.form-message').removeClass('success').fadeOut();
                                }, 5000);
                            } else {
                                $(form).find('.form-message').addClass('alert alert-success alert-dismissable').text(data.success).fadeIn();
                                setTimeout(function () {
                                    $(form).find('.form-message').removeClass('error').fadeOut();
                                }, 5000);
                            }
                        },
                        error: function (jqXHR) {
                            $(form).find('.form-message').addClass('alert alert-danger alert-dismissable').text('Failed to send your message. Please try later or contact the administrator by another method.').fadeIn();
                            setTimeout(function () {
                                $(form).find('.form-message').removeClass('error').fadeOut();
                            }, 5000);
                        },
                        complete: function (data) {
                            app.card.loading.finish($('.login-box'));
                        }
                    });
                } else {
                    $(form).find('.form-message').addClass('alert alert-danger alert-dismissable').text('Validation errors occurred. Please confirm the fields and submit it again.').fadeIn();
                    setTimeout(function () {
                        $(form).find('.form-message').removeClass('error').fadeOut();
                    }, 5000);
                }
            });
        </script>
    </body>
</html>