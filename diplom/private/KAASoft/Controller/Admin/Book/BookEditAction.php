<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Book;

    use Exception;
    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Controller\Controller;
    use KAASoft\Controller\ControllerBase;
    use KAASoft\Database\Entity\General\Book;
    use KAASoft\Environment\Routes\Pub\GeneralPublicRoutes;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use KAASoft\Util\Message;

    /**
     * Class BookEditAction
     * @package KAASoft\Controller\Admin\Book
     */
    class BookEditAction extends AdminActionBase {
        /**
         * BookEditAction constructor.
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
            $bookId = $args["bookId"];
            $bookDatabaseHelper = new BookDatabaseHelper($this);
            if (Helper::isAjaxRequest()) {
                if (Helper::isPostRequest()) { // POST request
                    try {
                        if ($this->startDatabaseTransaction()) {
                            //$bookId = $_POST["bookId"];
                            $book = Book::getObjectInstance($_POST);

                            $oldBook = $bookDatabaseHelper->getBook($bookId);
                            if ($oldBook === null) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Couldn't find requested book.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
                            }

                            if (strcmp($book->getBookSN(),
                                       $oldBook->getBookSN()) !== 0 and $bookDatabaseHelper->isBookSNExist($book->getBookSN())
                            ) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("New Book ID is already exist in database. Please change it or set old one.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
                            }

                            $book->setId($bookId);
                            $book->setUpdateDateTime(Helper::getDateTimeString());

                            $oldBookQuantity = $bookDatabaseHelper->getBookQuantity($bookId);
                            if ($oldBookQuantity !== $book->getQuantity()) {
                                $oldActualBookQuantity = $bookDatabaseHelper->getBookActualQuantity($bookId);
                                $book->setActualQuantity($oldActualBookQuantity + ( $book->getQuantity() - $oldBookQuantity ));
                            }

                            $result = $bookDatabaseHelper->saveBook($book);
                            if ($result === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Book saving is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
                            }


                            if ($bookDatabaseHelper->deleteBookAuthors($bookId) === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Book author(s) cleanup is failed for some reason.");
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

                            if ($bookDatabaseHelper->deleteBookGenres($bookId) === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Book genre(s) cleanup is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
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
                            if ($bookDatabaseHelper->deleteBookStores($bookId) === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Book store(s) cleanup is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
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

                            if ($bookDatabaseHelper->deleteBookLocations($bookId) === false) {
                                $this->rollbackDatabaseChanges();
                                $errorMessage = _("Book location(s) cleanup is failed for some reason.");
                                $this->putArrayToAjaxResponse([ Controller::AJAX_PARAM_NAME_ERROR => $errorMessage ]);

                                return new DisplaySwitch();
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
                    catch (Exception $e) {
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
                $book = null;
                if ($bookId !== null) {
                    $book = $bookDatabaseHelper->getBook($bookId);

                    if ($book === null) {
                        $this->session->addSessionMessage(sprintf(_("Book with id = '%d' is not found."),
                                                                  $bookId),
                                                          Message::MESSAGE_STATUS_ERROR);

                        return new DisplaySwitch(null,
                                                 $this->routeController->getRouteString(GeneralPublicRoutes::PAGE_IS_NOT_FOUND_ROUTE));
                    }
                }

                $this->smarty->assign("action",
                                      "edit");
                $this->smarty->assign("book",
                                      $book);

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