<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Issue;

    use Exception;
    use KAASoft\Controller\Admin\Book\BookDatabaseHelper;
    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Controller\Controller;
    use KAASoft\Controller\ControllerBase;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;

    /**
     * Class BookLostSetAction
     * @package KAASoft\Controller\Admin\Issue
     */
    class BookLostSetAction extends AdminActionBase {
        /**
         * BookLostSetAction constructor.
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
            $issueId = $args["issueId"];
            $isLost = strcmp($args["isLost"],
                             "true") === 0;
            $issueDatabaseHelper = new IssueDatabaseHelper($this);
            $bookDatabaseHelper = new BookDatabaseHelper($this);
            if (Helper::isAjaxRequest()) {
                if (Helper::isPostRequest()) { // POST request
                    try {
                        if ($this->startDatabaseTransaction()) {
                            $issue = $issueDatabaseHelper->getIssue($issueId);
                            if ($issue === null) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = sprintf(_("Couldn't get issue by id = \"%d\"."),
                                                        $issueId);
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                            }

                            $bookQuantity = $bookDatabaseHelper->getBookQuantity($issue->getBookId());

                            $result = $bookDatabaseHelper->setBookQuantity($issue->getBookId(),
                                                                           $bookQuantity + ( $isLost ? -1 : +1 ));
                            if ($result === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Couldn't update book quantity.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                            }


                            $result = $issueDatabaseHelper->updateIssueLostStatus($issueId,
                                                                                  $isLost);
                            if ($result === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Issue lost status updating is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                            }

                            $this->commitDatabaseChanges();
                            $this->putArrayToAjaxResponse([ "issueId" => $issueId ]);
                        }
                    }
                    catch (Exception $e) {
                        $this->rollbackDatabaseChanges();
                        ControllerBase::getLogger()->error($e->getMessage(),
                                                           $e);
                        $errorMessage = sprintf(_("Couldn't update lost status of Issue.%s%s"),
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