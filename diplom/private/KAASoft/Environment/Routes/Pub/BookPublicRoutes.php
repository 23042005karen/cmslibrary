<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Environment\Routes\Pub;


    use KAASoft\Environment\Routes\PublicRoute;
    use KAASoft\Environment\Routes\RoutesInterface;

    /**
     * Class BookPublicRoutes
     * @package KAASoft\Environment\Routes\Pub
     */
    class BookPublicRoutes implements RoutesInterface {

        const BOOK_LIST_VIEW_PUBLIC_ROUTE      = "bookListViewPublic";
        const BOOK_VIEW_PUBLIC_ROUTE           = "bookViewPublic";
        const BOOK_SEARCH_PUBLIC_ROUTE         = "bookSearchPublic";
        const BOOK_GOOGLE_SEARCH_PUBLIC_ROUTE  = "bookGoogleSearchPublic";
        const BOOK_BY_GOOGLE_DATA_CREATE_ROUTE = "bookByGoogleDataCreate";

        const PUBLISHER_BOOKS_PUBLIC_ROUTE  = "publisherBooksPublic";
        const PUBLISHER_SEARCH_PUBLIC_ROUTE = "publisherSearchPublic";

        const SERIES_BOOKS_PUBLIC_ROUTE  = "seriesBooksPublic";
        const SERIES_SEARCH_PUBLIC_ROUTE = "seriesSearchPublic";

        const GENRE_BOOKS_PUBLIC_ROUTE  = "genreBooksPublic";
        const GENRE_SEARCH_PUBLIC_ROUTE = "genreSearchPublic";

        const STORE_SEARCH_PUBLIC_ROUTE    = "storeSearchPublic";
        const LOCATION_SEARCH_PUBLIC_ROUTE = "locationSearchPublic";

        const AUTHOR_LIST_VIEW_PUBLIC_ROUTE = "authorListViewPublic";
        const AUTHOR_BOOKS_PUBLIC_ROUTE     = "authorBooksPublic";
        const AUTHOR_SEARCH_PUBLIC_ROUTE    = "authorSearchPublic";

        public static function getRoutes() {
            $routes = [];
            $routes[BookPublicRoutes::BOOK_LIST_VIEW_PUBLIC_ROUTE] = new PublicRoute(_("Books List View Public"),
                                                                                     "/books(?:/page/(\\d+))?[/]??",
                                                                                     "Pub\\Book\\BooksPublicAction",
                                                                                     "/books",
                                                                                     [ "page" ]);

            $routes[BookPublicRoutes::BOOK_VIEW_PUBLIC_ROUTE] = new PublicRoute(_("Book View Public"),
                                                                                "/book/(\\d+)[/]??",
                                                                                "Pub\\Book\\BookPublicViewAction",
                                                                                "/book/[bookId]",
                                                                                [ "bookId" ]);

            $routes[BookPublicRoutes::BOOK_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Book Search Public"),
                                                                                  "/book/search(?:/page/(\\d+))?[/]??",
                                                                                  "Pub\\Book\\BookSearchPublicAction",
                                                                                  "/book/search",
                                                                                  [ "page" ]);

            $routes[BookPublicRoutes::BOOK_GOOGLE_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Google Search Book"),
                                                                                         "/book/google-search[/]??",
                                                                                         "Pub\\Book\\BookGoogleSearchAction",
                                                                                         "/book/google-search");
            $routes[BookPublicRoutes::BOOK_BY_GOOGLE_DATA_CREATE_ROUTE] = new PublicRoute(_("Book By Google Data Create"),
                                                                                          "/google-book/([^/!*'\"()\[\];:@&=+$,?#]*)/create[/]??",
                                                                                          "Pub\\Book\\BookCreateByGoogleDataAction",
                                                                                          "/google-book/[googleBookId]/create",
                                                                                          [ "googleBookId" ]);
            /**************************************************************/
            $routes[BookPublicRoutes::PUBLISHER_BOOKS_PUBLIC_ROUTE] = new PublicRoute(_("Publisher Books View Public"),
                                                                                      "/publisher/(\\d+)/books(?:/page/(\\d+))?[/]??",
                                                                                      "Pub\\Publisher\\PublisherBooksPublicAction",
                                                                                      "/publisher/[publisherId]/books",
                                                                                      [ "publisherId",
                                                                                        "page" ]);

            $routes[BookPublicRoutes::PUBLISHER_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Publisher Search Public"),
                                                                                       "/publisher/search[/]??",
                                                                                       "Pub\\Publisher\\PublisherSearchAction",
                                                                                       "/publisher/search");
            /**************************************************************/
            $routes[BookPublicRoutes::SERIES_BOOKS_PUBLIC_ROUTE] = new PublicRoute(_("Series Books View Public"),
                                                                                   "/series/(\\d+)/books(?:/page/(\\d+))?[/]??",
                                                                                   "Pub\\Series\\SeriesBooksPublicAction",
                                                                                   "/series/[seriesId]/books",
                                                                                   [ "seriesId",
                                                                                     "page" ]);

            $routes[BookPublicRoutes::SERIES_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Search Series"),
                                                                                    "/series/search[/]??",
                                                                                    "Pub\\Series\\SeriesSearchAction",
                                                                                    "/series/search");
            /**************************************************************/
            $routes[BookPublicRoutes::AUTHOR_LIST_VIEW_PUBLIC_ROUTE] = new PublicRoute(_("Author List View Public "),
                                                                                       "/authors(?:/page/(\\d+))?[/]??",
                                                                                       "Pub\\Author\\AuthorsPublicAction",
                                                                                       "/authors",
                                                                                       [ "page" ]);

            $routes[BookPublicRoutes::AUTHOR_BOOKS_PUBLIC_ROUTE] = new PublicRoute(_("Author Books View Public"),
                                                                                   "/author/(\\d+)/books(?:/page/(\\d+))?[/]??",
                                                                                   "Pub\\Author\\AuthorBooksPublicAction",
                                                                                   "/author/[authorId]/books",
                                                                                   [ "authorId",
                                                                                     "page" ]);

            $routes[BookPublicRoutes::AUTHOR_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Author Search"),
                                                                                    "/author/search[/]??",
                                                                                    "Pub\\Author\\AuthorSearchAction",
                                                                                    "/author/search");
            /**************************************************************/
            $routes[BookPublicRoutes::GENRE_BOOKS_PUBLIC_ROUTE] = new PublicRoute(_("Genre Books View Public"),
                                                                                  "/genre/(\\d+)/books(?:/page/(\\d+))?[/]??",
                                                                                  "Pub\\Genre\\GenreBooksPublicAction",
                                                                                  "/genre/[genreId]/books",
                                                                                  [ "genreId",
                                                                                    "page" ]);

            $routes[BookPublicRoutes::GENRE_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Genre Search"),
                                                                                   "/genre/search[/]??",
                                                                                   "Pub\\Genre\\GenreSearchAction",
                                                                                   "/genre/search");
            /**************************************************************/
            $routes[BookPublicRoutes::STORE_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Store Search"),
                                                                                   "/store/search[/]??",
                                                                                   "Admin\\Store\\StoreSearchAction",
                                                                                   "/store/search");
            $routes[BookPublicRoutes::LOCATION_SEARCH_PUBLIC_ROUTE] = new PublicRoute(_("Location Search"),
                                                                                      "/location/search[/]??",
                                                                                      "Admin\\Location\\LocationSearchAction",
                                                                                      "/location/search");

            return $routes;
        }
    }