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
                        {include 'admin/errors.tpl'}
                        <form class="form-horizontal" action="{$routes->getRouteString("passwordRecovery")}">
                            <div class="form-group ">
                                <h3 class="text-center mb-3">{t}Recover Password{/t}</h3>
                                <p class="text-muted">{t}Enter your Email and instructions will be sent to you!{/t}</p>
                            </div>
                            <div class="form-group">
                                <input class="form-control" type="text" id="email" placeholder="Email" name="email" autocomplete="off">
                            </div>
                            <div class="form-message"></div>
                            <div class="form-group text-center m-t-20">
                                <div class="col-xs-12">
                                    <button class="btn btn-primary btn-block recover" type="submit">{t}Reset{/t}</button>
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
        <script src="{$resourcePath}assets/js/main.js"></script>
        <script>
            $('.recover').on('click', function (e) {
                e.preventDefault();
                var form = $(this).closest('form');
                var email = $('#email').val();
                if (email != null && email != '') {
                    $.ajax({
                        dataType: 'json',
                        method: 'POST',
                        data: form.serialize(),
                        url: $(form).attr('action'),
                        beforeSend: function (data) {
                            app.card.loading.start($('.login-box'));
                        },
                        success: function (data) {
                            if (data.error == undefined) {
                                $(form).find('.form-message').addClass('alert alert-success alert-dismissable').text(data.success).fadeIn();
                                $(form).find("input[type=text], textarea").val("");
                                setTimeout(function () {
                                    $(form).find('.form-message').removeClass('alert alert-success alert-dismissable').fadeOut();
                                }, 5000);
                            } else {
                                $(form).find('.form-message').addClass('alert alert-danger alert-dismissable').html(data.error).fadeIn();
                                setTimeout(function () {
                                    $(form).find('.form-message').removeClass('alert alert-danger alert-dismissable').fadeOut();
                                }, 50000);
                            }
                        },
                        error: function (jqXHR, exception) {
                            console.log(app.getErrorMessage(jqXHR, exception));
                            $(form).find('.form-message').addClass('alert alert-danger alert-dismissable').text('Failed to send your message. Please try later or contact the administrator by another method.').fadeIn();
                            setTimeout(function () {
                                $(form).find('.form-message').removeClass('alert alert-danger alert-dismissable').fadeOut();
                            }, 5000);
                        },
                        complete: function (data) {
                            app.card.loading.finish($('.login-box'));
                        }
                    });
                } else {
                    $(form).find('.form-message').addClass('alert alert-danger alert-dismissable').text('Validation errors occurred. Please confirm the fields and submit it again.').fadeIn();
                    setTimeout(function () {
                        $(form).find('.form-message').removeClass('alert alert-danger alert-dismissable').fadeOut();
                    }, 50000);
                }
            });
        </script>
    </body>
</html>