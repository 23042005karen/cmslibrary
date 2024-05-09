<?php
/* Smarty version 3.1.31, created on 2024-03-25 00:25:59
  from "C:\OSPanel\domains\diplom\themes\default\auth\install.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_66009a67654c35_38451229',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '9aa6799c31df869d85354f5fed36034712998ae6' => 
    array (
      0 => 'C:\\OSPanel\\domains\\diplom\\themes\\default\\auth\\install.tpl',
      1 => 1525942510,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:errors.tpl' => 1,
  ),
),false)) {
function content_66009a67654c35_38451229 (Smarty_Internal_Template $_smarty_tpl) {
if (!is_callable('smarty_block_t')) require_once 'C:\\OSPanel\\domains\\diplom\\private\\Smarty\\plugins\\block.t.php';
?>
<!DOCTYPE html>
<html lang="en" style="height: 100%;">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="KAASoft">
        <meta name="robots" content="noindex,nofollow">
        <meta http-equiv="cache-control" content="no-cache"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta http-equiv="Expires" content="-1"/>
        <title>Install Library CMS</title>
        <link href="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/css/plugins/bootstrap/bootstrap.min.css" rel="stylesheet">
        <link href="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/css/style.css" rel="stylesheet">
        <link rel="icon" type="image/png" sizes="32x32" href="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/images/favicon.png">
    </head>
    <body style="min-height: 100%;background: linear-gradient(180deg,#f0f0f0 0,#dee1e3 100%) !important;">
        <section id="wrapper">
            <div class="login-register" style="">
                <div class="login-box card" style="max-width: 600px;width: auto;">
                    <div class="card-body">
                        <img src="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/images/logo.png" class="d-flex ml-auto mr-auto mb-4 mt-2" alt="<?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Login<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
"/> :: <a href="https://prowebber.ru/">Shared by prowebber<a/>
                        <?php $_smarty_tpl->_subTemplateRender('file:errors.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

                        <form action="<?php echo $_smarty_tpl->tpl_vars['routes']->value->getRouteString("installSite");?>
" method="post" class="form-horizontal validate">
                            <?php if ($_smarty_tpl->tpl_vars['isUpdate']->value === true) {?>
                                <div class="form-group">
                                    <h3 class="text-center mb-3">Update Library CMS</h3>
                                </div>
                                <div class="form-group mt-3">
                                    <button type="submit" class="btn btn-primary btn-block" id="update"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Update<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</button>
                                </div>
                            <?php } else { ?>
                                <div class="form-group">
                                    <h3 class="text-center mb-3">Install Library CMS</h3>
                                    <p class="text-muted font-light fs14 text-center"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
This is installation page. Here you can setup connection to database and create administrator user. Please make sure your connection details and credentials are correct before starting installation process.<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</p>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="hostname"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Hostname<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                            <input type="text" name="databaseHost" class="form-control" value="<?php echo $_SESSION['POST']['databaseHost'];?>
">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="databaseName"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Database Name<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                            <input type="text" name="databaseName" class="form-control" autocomplete="off" value="<?php echo $_SESSION['POST']['databaseName'];?>
">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="databaseUserName"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Database Username<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                            <input type="text" name="databaseUserName" class="form-control" autocomplete="off" value="<?php echo $_SESSION['POST']['databaseUserName'];?>
">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="databasePassword"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Database Password<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                            <input type="password" name="databasePassword" class="form-control" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="adminEmail"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Admin Email (Login)<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                            <input type="text" name="adminEmail" class="form-control" autocomplete="off" value="<?php echo $_SESSION['POST']['adminEmail'];?>
">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="adminPassword"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Admin Password<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                            <input type="password" name="adminPassword" class="form-control" id="mainPassword" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="adminPassword"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Confirm Admin Password<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                            <input type="password" name="confirmPassword" class="form-control confirmPassword" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                <a class="font-bold fs12 text-uppercase" data-toggle="collapse" href="#advancedOptions" aria-expanded="false" aria-controls="advancedOptions">
                                    <?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Advanced Options<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
 <i class="icon-arrow-down"></i>
                                </a>
                                <div class="collapse mt-3" id="advancedOptions">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="databasePort"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Database Port<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                                <input type="text" name="databasePort" class="form-control" value="3306">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="databaseType"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Database Type<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</label>
                                                <select name="databaseType" class="form-control">
                                                    <option value="mysql" selected>mysql</option>
                                                    <option value="mariadb">mariadb</option>
                                                    <option value="mssql">mssql</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mt-3">
                                    <button type="submit" class="btn btn-primary btn-block" id="install"><?php $_smarty_tpl->smarty->_cache['_tag_stack'][] = array('t', array());
$_block_repeat=true;
echo smarty_block_t(array(), null, $_smarty_tpl, $_block_repeat);
while ($_block_repeat) {
ob_start();
?>
Install<?php $_block_repeat=false;
echo smarty_block_t(array(), ob_get_clean(), $_smarty_tpl, $_block_repeat);
}
array_pop($_smarty_tpl->smarty->_cache['_tag_stack']);?>
</button>
                                </div>
                            <?php }?>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/js/plugins/jquery/jquery-3.2.1.min.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/js/plugins/bootstrap/popper.min.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/js/plugins/bootstrap/bootstrap.min.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/js/plugins/jquery-validate/jquery.validate.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/js/plugins/tooltipster/jquery.tooltipster.min.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['resourcePath']->value;?>
assets/js/main.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
>
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
                    adminEmail: {
                        required: true,
                        email: true
                    },
                    confirmPassword: {
                        equalTo: "#mainPassword"
                    }
                }
            });
        <?php echo '</script'; ?>
>
    </body>
</html><?php }
}
