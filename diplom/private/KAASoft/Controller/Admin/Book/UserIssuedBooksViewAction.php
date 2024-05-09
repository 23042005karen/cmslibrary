<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Book;

    use KAASoft\Environment\Routes\Admin\IssueRoutes;
    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Environment\Session;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use KAASoft\Util\Paginator;

    /**
     * Class UserIssuedBooksViewAction
     * @package KAASoft\Controller\Admin\Book
     */
    class UserIssuedBooksViewAction extends AdminActionBase {
        /**
         * UserIssuedBooksViewAction constructor.
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
            $userId = $this->session->getUser()->getId();
            $page = isset( $args["page"] ) ? $args["page"] : 1;
            $bookDatabaseHelper = new BookDatabaseHelper($this);

            $perPage = $this->getPerPage(Session::BOOK_PER_PAGE_NUMBER,
                                         $this->siteViewOptions->getOptionValue(SiteViewOptions::BOOKS_PER_PAGE_ADMIN));
            $sortColumn = $this->getSortingColumn(Session::ISSUED_BOOK_SORTING_COLUMN,
                                                  KAASoftDatabase::$ISSUES_TABLE_NAME . ".issueDate");
            $sortOrder = $this->getSortingOrder(Session::ISSUED_BOOK_SORTING_ORDER,
                                                "DESC");

            $paginator = new Paginator($page,
                                       $perPage,
                                       $bookDatabaseHelper->getUserIssuedBooksCount($userId));

            $this->smarty->assign("pages",
                                  $paginator->preparePages($page,
                                                           $this->routeController->getRouteString(IssueRoutes::USER_ISSUED_BOOKS_VIEW_ROUTE)));

            $books = $bookDatabaseHelper->getUserIssuedBooks($userId,
                                                             $paginator->getOffset(),
                                                             $perPage,
                                                             $sortColumn,
                                                             $sortOrder);

            $this->smarty->assign("books",
                                  $books);

            if (Helper::isAjaxRequest()) {
                return new DisplaySwitch('admin/issues/userIssuedBooks-list.tpl');
            }
            else {
                return new DisplaySwitch('admin/issues/userIssuedBooks.tpl');
            }
        }
    }