<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Pub\Author;


    use KAASoft\Environment\Routes\Pub\BookPublicRoutes;
    use KAASoft\Controller\Admin\Author\AuthorDatabaseHelper;
    use KAASoft\Controller\Admin\Book\BookDatabaseHelper;
    use KAASoft\Controller\Admin\User\UserDatabaseHelper;
    use KAASoft\Controller\PublicActionBase;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Environment\Session;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use KAASoft\Util\Paginator;

    /**
     * Class AuthorBooksPublicAction
     * @package KAASoft\Controller\Pub\Author
     */
    class AuthorBooksPublicAction extends PublicActionBase {
        /**
         * AuthorBooksPublicAction constructor.
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
            $authorId = $args["authorId"];
            $page = isset( $args["page"] ) ? $args["page"] : 1;
            $bookDatabaseHelper = new BookDatabaseHelper($this);

            $perPage = $this->getPerPage(Session::BOOK_PER_PAGE_NUMBER_PUBLIC,
                                         $this->siteViewOptions->getOptionValue(SiteViewOptions::BOOKS_PER_PAGE_PUBLIC));
            $sortColumn = $this->getSortingColumn(Session::BOOK_SORTING_COLUMN_PUBLIC,
                                                  KAASoftDatabase::$BOOKS_TABLE_NAME . ".creationDateTime");
            $sortOrder = $this->getSortingOrder(Session::BOOK_SORTING_ORDER_PUBLIC,
                                                "DESC");

            $totalBooks = $bookDatabaseHelper->getAuthorBooksCount($authorId);
            $paginator = new Paginator($page,
                                       $perPage,
                                       $totalBooks);

            $this->smarty->assign("pages",
                                  $paginator->preparePages($page,
                                                           $this->routeController->getRouteString(BookPublicRoutes::AUTHOR_BOOKS_PUBLIC_ROUTE,
                                                                                                  [ "authorId" => $authorId ])));

            $books = $bookDatabaseHelper->getAuthorBooks($authorId,
                                                         $paginator->getOffset(),
                                                         $perPage,
                                                         $sortColumn,
                                                         $sortOrder);
            $authorDatabaseHelper = new AuthorDatabaseHelper($this);
            $author = $authorDatabaseHelper->getAuthor($authorId);

            $this->smarty->assign("books",
                                  $books);
            $this->smarty->assign("author",
                                  $author);
            $this->smarty->assign("totalBooks",
                                  $totalBooks);

            $userHelper = new UserDatabaseHelper($this);
            $this->smarty->assign("users",
                                  $userHelper->getUsers());
            $this->smarty->assign("bindings",
                                  $bookDatabaseHelper->getBindings());

            if (Helper::isAjaxRequest()) {
                return new DisplaySwitch('books/books-list.tpl');
            }
            else {
                return new DisplaySwitch('authors/authors-category.tpl');
            }
        }
    }