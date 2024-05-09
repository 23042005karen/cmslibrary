<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Pub\Genre;


    use KAASoft\Environment\Routes\Pub\BookPublicRoutes;
    use KAASoft\Controller\Admin\Book\BookDatabaseHelper;
    use KAASoft\Controller\Admin\Genre\GenreDatabaseHelper;
    use KAASoft\Controller\Admin\User\UserDatabaseHelper;
    use KAASoft\Controller\PublicActionBase;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Environment\Session;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use KAASoft\Util\Paginator;

    /**
     * Class GenreBooksPublicAction
     * @package KAASoft\Controller\Pub\Genre
     */
    class GenreBooksPublicAction extends PublicActionBase {
        /**
         * GenreBooksPublicAction constructor.
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
            $genreId = $args["genreId"];
            $page = isset( $args["page"] ) ? $args["page"] : 1;
            $bookDatabaseHelper = new BookDatabaseHelper($this);

            $perPage = $this->getPerPage(Session::BOOK_PER_PAGE_NUMBER_PUBLIC,
                                         $this->siteViewOptions->getOptionValue(SiteViewOptions::BOOKS_PER_PAGE_PUBLIC));
            $sortColumn = $this->getSortingColumn(Session::BOOK_SORTING_COLUMN_PUBLIC,
                                                  KAASoftDatabase::$BOOKS_TABLE_NAME . ".creationDateTime");
            $sortOrder = $this->getSortingOrder(Session::BOOK_SORTING_ORDER_PUBLIC,
                                                "DESC");


            $totalBooks = $bookDatabaseHelper->getGenreBooksCount($genreId);
            $paginator = new Paginator($page,
                                       $perPage,
                                       $totalBooks);

            $this->smarty->assign("pages",
                                  $paginator->preparePages($page,
                                                           $this->routeController->getRouteString(BookPublicRoutes::GENRE_BOOKS_PUBLIC_ROUTE,
                                                                                                  [ "genreId" => $genreId ])));

            $books = $bookDatabaseHelper->getGenreBooks($genreId,
                                                        $paginator->getOffset(),
                                                        $perPage,
                                                        $sortColumn,
                                                        $sortOrder);
            $genreDatabaseHelper = new GenreDatabaseHelper($this);
            $genre = $genreDatabaseHelper->getGenre($genreId);
            $this->smarty->assign("totalBooks",
                                  $totalBooks);
            $this->smarty->assign("books",
                                  $books);
            $this->smarty->assign("genre",
                                  $genre);
            $userHelper = new UserDatabaseHelper($this);
            $this->smarty->assign("users",
                                  $userHelper->getUsers());
            $this->smarty->assign("bindings",
                                  $bookDatabaseHelper->getBindings());

            if (Helper::isAjaxRequest()) {
                return new DisplaySwitch('books/books-list.tpl');
            }
            else {
                return new DisplaySwitch('genres/genres.tpl');
            }
        }
    }