<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Request;


    use Exception;
    use KAASoft\Controller\Admin\Book\BookDatabaseHelper;
    use KAASoft\Controller\Admin\Util\UtilDatabaseHelper;
    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Controller\Controller;
    use KAASoft\Controller\ControllerBase;
    use KAASoft\Database\Entity\General\Request;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\EmailAddress;
    use KAASoft\Util\FileHelper;
    use KAASoft\Util\Helper;

    /**
     * Class RequestStatusSetAction
     * @package KAASoft\Controller\Admin\Request
     */
    class RequestStatusSetAction extends AdminActionBase {
        /**
         * RequestStatusSetAction constructor.
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
            $requestId = $args["requestId"];
            $status = $args["status"];
            $requestDatabaseHelper = new RequestDatabaseHelper($this);
            if (Helper::isAjaxRequest()) {
                if (Helper::isPostRequest()) { // POST request
                    try {
                        if ($this->startDatabaseTransaction()) {

                            $result = $requestDatabaseHelper->updateRequestStatus($requestId,
                                                                                  $status);
                            if ($result === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Request status update is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                            }

                            $this->commitDatabaseChanges();
                            $this->putArrayToAjaxResponse([ "requestId" => $requestId ]);

                            // email setup
                            $utilHelper = new UtilDatabaseHelper($this);
                            $requestHelper = new RequestDatabaseHelper($this);
                            $request = $requestHelper->getRequest($requestId);
                            if ($request !== null) {
                                $user = $request->getUser();
                                $this->addShortCode("FIRST_NAME",
                                                    $user->getFirstName());
                                $this->addShortCode("LAST_NAME",
                                                    $user->getLastName());
                                $this->addShortCode("REQUEST_DATE",
                                                    Helper::reformatDateString($request->getCreationDate(),
                                                                               $this->siteViewOptions->getOptionValue(SiteViewOptions::DATE_FORMAT)));
                                $status = null;
                                switch ($request->getStatus()) {
                                    case Request::STATUS_ACCEPTED:
                                        $status = _("Accepted");
                                        break;
                                    case Request::STATUS_REJECTED:
                                        $status = _("Rejected");
                                        break;
                                    default:
                                        $status = _("Pending");
                                }
                                $this->addShortCode("STATUS",
                                                    $status);

                                $bookHelper = new BookDatabaseHelper($this);
                                $books = $bookHelper->getBooksByIds([ $request->getBookId() ]);
                                $this->smarty->assign("books",
                                                      $books);
                                $activeTheme = ControllerBase::getThemeSettings()->getActiveTheme();

                                $booksTemplate = $this->smarty->fetch(FileHelper::getEmailNotificationTemplateDirectory($activeTheme) . DIRECTORY_SEPARATOR . "books.tpl");
                                $this->addShortCode("BOOKS",
                                                    $booksTemplate);

                                $emailNotification = $utilHelper->getEmailNotification($this->activeRoute->getName());
                                $emailNotification->setTo([ new EmailAddress($user->getEmail(),
                                                                             $user->getLastName() . " " . $user->getFirstName()) ]);

                                $this->setEmailNotification($emailNotification);
                                // email setup end
                            }

                        }
                    }
                    catch (Exception $e) {
                        $this->rollbackDatabaseChanges();
                        ControllerBase::getLogger()->error($e->getMessage(),
                                                           $e);
                        $errorMessage = sprintf(_("Couldn't update Request.%s%s"),
                                                Helper::HTML_NEW_LINE,
                                                $e->getMessage());
                        $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                    }
                }


            }
            else {
                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => _("AJAX request is required only.") ]);
            }

            return new DisplaySwitch();
        }
    }