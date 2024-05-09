<?php
/* Smarty version 3.1.31, created on 2024-03-25 00:25:59
  from "C:\OSPanel\domains\diplom\themes\default\errors.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.31',
  'unifunc' => 'content_66009a67c64b38_27153539',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '8338991ee7a0f2d3702eca5e6028eaf4bd0d1a58' => 
    array (
      0 => 'C:\\OSPanel\\domains\\diplom\\themes\\default\\errors.tpl',
      1 => 1519054816,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66009a67c64b38_27153539 (Smarty_Internal_Template $_smarty_tpl) {
if (isset($_SESSION['messages']) && count($_SESSION['messages']) > 0) {?>
    <div class="row">
        <div class="col-sm-12">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_SESSION['messages'], 'message');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['message']->value) {
?>
                <div class="alert <?php if ($_smarty_tpl->tpl_vars['message']->value->getStatus() == 'INFO') {?>alert-success<?php } elseif (strcmp($_smarty_tpl->tpl_vars['message']->value->getStatus(),'WARNING') === 0) {?>alert-warning<?php } else { ?>alert-danger<?php }?> alert-dismissible fade show" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <?php echo $_smarty_tpl->tpl_vars['message']->value->getMessage();?>

                </div>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
?>

        </div>
    </div>
<?php }
}
}
