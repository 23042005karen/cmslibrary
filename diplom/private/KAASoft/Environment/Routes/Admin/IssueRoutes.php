<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Environment\Routes\Admin;

    use KAASoft\Environment\Routes\AdminRoute;
    use KAASoft\Environment\Routes\RoutesInterface;

    /**
     * Class IssueRoutes
     * @package KAASoft\Environment\Routes\Admin
     */
    class IssueRoutes implements RoutesInterface {

        const ISSUE_LIST_VIEW_ROUTE = "issueListView";
        const ISSUE_CREATE_ROUTE    = "issueCreate";
        const ISSUE_EDIT_ROUTE      = "issueEdit";
        const ISSUE_DELETE_ROUTE    = "issueDelete";

        const ISSUED_BOOK_SET_LOST_ROUTE     = "bookSetLost";
        const ISSUED_BOOK_SET_RETURNED_ROUTE = "bookSetReturned";
        const REQUESTED_BOOK_ISSUE_ROUTE     = "requestedBookIssue";
        const USER_ISSUED_BOOKS_VIEW_ROUTE   = "userIssuedBooksView";

        public static function getRoutes() {
            $routes = [];
            /*************************************  ISSUE  **********************************************************/
            $routes[IssueRoutes::ISSUE_LIST_VIEW_ROUTE] = new AdminRoute(_("Issue List View"),
                                                                         "/issues(?:/page/(\\d+))?[/]??",
                                                                         "Admin\\Issue\\IssuesAction",
                                                                         "/issues",
                                                                         [ "page" ]);

            $routes[IssueRoutes::ISSUE_CREATE_ROUTE] = new AdminRoute(_("Issue Create"),
                                                                      "/issue/create[/]??",
                                                                      "Admin\\Issue\\IssueCreateAction",
                                                                      "/issue/create/");

            $routes[IssueRoutes::ISSUE_EDIT_ROUTE] = new AdminRoute(_("Issue Edit"),
                                                                    "/issue/(\\d+)/edit[/]??",
                                                                    "Admin\\Issue\\IssueEditAction",
                                                                    "/issue/[issueId]/edit",
                                                                    [ "issueId" ]);

            $routes[IssueRoutes::ISSUE_DELETE_ROUTE] = new AdminRoute(_("Issue Delete"),
                                                                      "/issue/(\\d+)/delete[/]??",
                                                                      "Admin\\Issue\\IssueDeleteAction",
                                                                      "/issue/[issueId]/delete",
                                                                      [ "issueId" ]);

            $routes[IssueRoutes::ISSUED_BOOK_SET_LOST_ROUTE] = new AdminRoute(_("Issued Book Set Returned"),
                                                                              "/issue/(\\d+)/book-lost/(false|true)[/]??",
                                                                              "Admin\\Issue\\BookLostSetAction",
                                                                              "/issue/[issueId]/book-lost/[isLost]",
                                                                              [ "issueId",
                                                                                "isLost" ]);

            $routes[IssueRoutes::ISSUED_BOOK_SET_RETURNED_ROUTE] = new AdminRoute(_("Issued Book Set Returned"),
                                                                                  "/issue/(\\d+)/book-returned[/]??",
                                                                                  "Admin\\Issue\\BookReturnedSetAction",
                                                                                  "/issue/[issueId]/book-returned",
                                                                                  [ "issueId" ]);

            $routes[IssueRoutes::REQUESTED_BOOK_ISSUE_ROUTE] = new AdminRoute(_("Issue Requested Book"),
                                                                              "/request/(\\d+)/issue[/]??",
                                                                              "Admin\\Issue\\RequestedBookIssueAction",
                                                                              "/request/[requestId]/issue",
                                                                              [ "requestId" ]);

            $routes[IssueRoutes::USER_ISSUED_BOOKS_VIEW_ROUTE] = new AdminRoute(_("User Issued Books View"),
                                                                                "/user/issued-books(?:/page/(\\d+))?[/]??",
                                                                                "Admin\\Book\\UserIssuedBooksViewAction",
                                                                                "/user/issued-books",
                                                                                [ "page" ]);


            /*************************************  ISSUE END  ******************************************************/

            return $routes;
        }
    }