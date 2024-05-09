<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\General;

    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;

    /**
     * Class LoginAction
     * @package KAASoft\Controller\Admin\General
     */
    class LoginAction extends AdminActionBase {
        /**
         * LoginAction constructor.
         * @param null $activeRoute
         */
        public function __construct($activeRoute = null) {
            parent::__construct($activeRoute);
        }

        /**
         * @param array $args
         * @return DisplaySwitch
         */
        protected function action($args) {
            $login = $this->session->getLogin();
            if (Helper::isPostRequest()) {

                $login = $_POST['login'];
                $password = $_POST['password'];

                $user = $this->session->attemptLogin($this,
                                                     $login,
                                                     $password);
                $this->session->login($user,
                    isset( $_POST["rememberMe"] ));
            }

            $this->smarty->assign("login",
                                  $login);

            return new DisplaySwitch('auth/login.tpl');
        }
    }