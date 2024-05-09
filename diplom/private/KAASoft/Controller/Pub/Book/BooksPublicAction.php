<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Pub\Book;

    use KAASoft\Controller\Pub\PublicDatabaseHelper;
    use KAASoft\Controller\PublicActionBase;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Environment\Routes\Pub\BookPublicRoutes;
    use KAASoft\Environment\Session;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\BookFilterQuery;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use KAASoft\Util\Paginator;

    /**
     * Class BooksPublicAction
     * @package KAASoft\Controller\Pub\Book
     */
    class BooksPublicAction extends PublicActionBase {
        /**
         * BooksPublicAction constructor.
         * @param null $activeRoute
         */
        public function __construct($activeRoute = null) {
            parent::__construct($activeRoute,
                                true);
        }

        /**
         * @param array $args
         * @return DisplaySwitch
         */
        protected function action($args) {
            $publicHelper = new PublicDatabaseHelper($this);

            $query = BookFilterQuery::getObjectInstance($_POST);
            $page = isset( $args["page"] ) ? $args["page"] : 1;

            $perPage = $this->getPerPage(Session::BOOK_PER_PAGE_NUMBER_FILTER_PUBLIC,
                                         $this->siteViewOptions->getOptionValue(SiteViewOptions::BOOKS_PER_PAGE_PUBLIC_FILTER));
            $sortColumn = $this->getSortingColumn(Session::BOOK_SORTING_COLUMN_PUBLIC,
                                                  KAASoftDatabase::$BOOKS_TABLE_NAME . ".creationDateTime");
            $sortOrder = $this->getSortingOrder(Session::BOOK_SORTING_ORDER_PUBLIC,
                                                "DESC");

            $totalBooks = $publicHelper->filterBooks($query,
                                                     true);
            $paginator = new Paginator($page,
                                       $perPage,
                                       $totalBooks);

            $this->smarty->assign("pages",
                                  $paginator->preparePages($page,
                                                           $this->routeController->getRouteString(BookPublicRoutes::BOOK_LIST_VIEW_PUBLIC_ROUTE)));

            $books = $publicHelper->filterBooks($query,
                                                false,
                                                $paginator->getOffset(),
                                                $perPage,
                                                $sortColumn,
                                                $sortOrder);

            $this->smarty->assign("books",
                                  $books);
            $this->smarty->assign("totalBooks",
                                  $totalBooks);

            $this->smarty->assign("bindings",
                                  $this->kaaSoftDatabase->getBindings());
            $this->smarty->assign("bookTypes",
                                  $this->kaaSoftDatabase->getBookTypes());
            $this->smarty->assign("bookSizes",
                                  $this->kaaSoftDatabase->getBookSizes());
            $this->smarty->assign("physicalForms",
                                  $this->kaaSoftDatabase->getPhysicalForms());

            if (Helper::isAjaxRequest()) {
                return new DisplaySwitch('books/books-list-with-filter.tpl');
            }
            else {
                return new DisplaySwitch('books/books.tpl');
            }
        }
    }