<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Book;

    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Controller\Controller;
    use KAASoft\Controller\ControllerBase;
    use KAASoft\Database\Entity\General\Book;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use PDOException;

    /**
     * Class BookCreateAction
     * @package KAASoft\Controller\Admin\Book
     */
    class BookCreateAction extends AdminActionBase {
        /**
         * BookCreateAction constructor.
         * @param null $activeRoute
         */
        public function __construct($activeRoute = null) {
            parent::__construct($activeRoute);
        }

        /**
         * @param array $args
         * @return DisplaySwitch
         * @throws \Exception
         */
        protected function action($args) {
            $bookDatabaseHelper = new BookDatabaseHelper($this);
            if (Helper::isAjaxRequest()) {
                if (Helper::isPostRequest()) { // POST request
                    try {
                        if ($this->startDatabaseTransaction()) {
                            $book = Book::getObjectInstance($_POST);

                            if ($bookDatabaseHelper->isBookSNExist($book->getBookSN())) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Book ID is already exist in database. Please change it.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
                            }
                            $book->setCreationDateTime(Helper::getDateTimeString());
                            $book->setUpdateDateTime($book->getCreationDateTime());
                            $bookId = $bookDatabaseHelper->saveBook($book);

                            if ($bookId === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Book saving is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
                            }

                            if (isset( $_POST["authors"] ) and is_array($_POST["authors"])) {
                                if ($bookDatabaseHelper->saveBookAuthors($bookId,
                                                                         $_POST["authors"]) === false
                                ) {
                                    $this->rollbackDatabaseChanges();
                                    $errorMessage = _("Book author(s) saving is failed for some reason.");
                                    $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                    return new DisplaySwitch();
                                }
                            }

                            if (isset( $_POST["genres"] ) and is_array($_POST["genres"])) {
                                if ($bookDatabaseHelper->saveBookGenres($bookId,
                                                                        $_POST["genres"]) === false
                                ) {
                                    $this->rollbackDatabaseChanges();
                                    $errorMessage = _("Book genre(s) saving is failed for some reason.");
                                    $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                    return new DisplaySwitch();
                                }
                            }

                            if (isset( $_POST["stores"] ) and is_array($_POST["stores"])) {
                                if ($bookDatabaseHelper->saveBookStores($bookId,
                                                                        $_POST["stores"]) === false
                                ) {
                                    $this->rollbackDatabaseChanges();
                                    $errorMessage = _("Book store(s) saving is failed for some reason.");
                                    $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                    return new DisplaySwitch();
                                }
                            }

                            if (isset( $_POST["locations"] ) and is_array($_POST["locations"])) {
                                if ($bookDatabaseHelper->saveBookLocations($bookId,
                                                                           $_POST["locations"]) === false
                                ) {
                                    $this->rollbackDatabaseChanges();
                                    $errorMessage = _("Book locations(s) saving is failed for some reason.");
                                    $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                    return new DisplaySwitch();
                                }
                            }

                            $this->commitDatabaseChanges();
                            $this->putArrayToAjaxResponse([ "bookId" => $bookId ]);
                        }
                    }
                    catch (PDOException $e) {
                        $this->rollbackDatabaseChanges();
                        ControllerBase::getLogger()->error($e->getMessage(),
                                                           $e);
                        $errorMessage = sprintf(_("Couldn't save Book.%s%s"),
                                                Helper::HTML_NEW_LINE,
                                                $e->getMessage());
                        $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);
                    }
                }

                return new DisplaySwitch();
            }
            else {
                $this->smarty->assign("action",
                                      "create");

                $this->smarty->assign("bindings",
                                      $this->kaaSoftDatabase->getBindings());
                $this->smarty->assign("bookTypes",
                                      $this->kaaSoftDatabase->getBookTypes());
                $this->smarty->assign("bookSizes",
                                      $this->kaaSoftDatabase->getBookSizes());
                $this->smarty->assign("physicalForms",
                                      $this->kaaSoftDatabase->getPhysicalForms());


                return new DisplaySwitch('admin/books/book.tpl');
            }
        }
    }