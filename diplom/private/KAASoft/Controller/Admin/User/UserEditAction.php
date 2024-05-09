<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\User;

    use Exception;
    use KAASoft\Controller\Admin\Book\BookDatabaseHelper;
    use KAASoft\Controller\Admin\Util\UtilDatabaseHelper;
    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Controller\Controller;
    use KAASoft\Controller\ControllerBase;
    use KAASoft\Database\Entity\General\User;
    use KAASoft\Database\Entity\Util\Role;
    use KAASoft\Environment\Routes\Pub\GeneralPublicRoutes;
    use KAASoft\Environment\Session;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use KAASoft\Util\Message;

    /**
     * Class UserEditAction
     * @package KAASoft\Controller\Admin\User
     */
    class UserEditAction extends AdminActionBase {
        /**
         * UserEditAction constructor.
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
            $userId = $args["userId"];
            $userDatabaseHelper = new UserDatabaseHelper($this);
            $utilDatabaseHelper = new UtilDatabaseHelper($this);
            $user = $this->session->getUser();
            $isAdmin = $user->getRoleId() === Role::BUILTIN_USER_ROLES[Role::ADMIN_ROLE_ID];
            $isLibrarian = $user->getRoleId() === Role::BUILTIN_USER_ROLES[Role::LIBRARIAN_ROLE_ID];
            if (!$isAdmin and !$isLibrarian) {
                if ($user->getId() != $userId) {
                    Session::addSessionMessage(_("You don't have permissions to edit user data."));

                    return new DisplaySwitch(null,
                                             $this->routeController->getRouteString(GeneralPublicRoutes::PAGE_IS_FORBIDDEN_ROUTE));
                }
            }
            if (Helper::isAjaxRequest()) {
                if (Helper::isPostRequest()) { // POST request
                    try {
                        if ($this->startDatabaseTransaction()) {
                            //$userId = $_POST["userId"];
                            $user = User::getObjectInstance($_POST);
                            $user->setUpdateDateTime(Helper::getDateTimeString());
                            $user->setId($userId);
                            $user->setIsLdapUser(false);

                            if (!empty( $user->getPassword() )) {
                                $user->setPassword(Helper::encryptPassword($user->getPassword()));
                            }

                            $result = $userDatabaseHelper->saveUser($user,
                                                                    !$isLibrarian);
                            if ($result === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("User saving is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                            }

                            $this->commitDatabaseChanges();
                            $this->putArrayToAjaxResponse([ "userId" => $userId ]);
                        }
                    }
                    catch (Exception $e) {
                        $this->rollbackDatabaseChanges();
                        ControllerBase::getLogger()->error($e->getMessage(),
                                                           $e);
                        $errorMessage = sprintf(_("Couldn't save User.%s%s"),
                                                Helper::HTML_NEW_LINE,
                                                $e->getMessage());
                        $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                    }
                }

                return new DisplaySwitch();
            }
            else {
                $user = null;
                if ($userId !== null) {
                    $user = $userDatabaseHelper->getUser($userId);

                    if ($user === null) {
                        $this->session->addSessionMessage(sprintf(_("User with id = '%d' is not found."),
                                                                  $userId),
                                                          Message::MESSAGE_STATUS_ERROR);

                        return new DisplaySwitch(null,
                                                 $this->routeController->getRouteString(GeneralPublicRoutes::PAGE_IS_NOT_FOUND_ROUTE));
                    }
                }

                $this->smarty->assign("action",
                                      "edit");
                $this->smarty->assign("editedUser",
                                      $user);
                $this->smarty->assign("roles",
                                      $utilDatabaseHelper->getRoles());

                $bookHelper = new BookDatabaseHelper($this);
                $this->smarty->assign("lastIssuedBooks",
                                      $bookHelper->getUserIssuedBooks($userId,
                                                                      0,
                                                                      10));
                $this->smarty->assign("lastRequestedBooks",
                                      $bookHelper->getUserRequestedBooks($userId,
                                                                         0,
                                                                         10));


                return new DisplaySwitch('admin/users/user.tpl');
            }
        }
    }