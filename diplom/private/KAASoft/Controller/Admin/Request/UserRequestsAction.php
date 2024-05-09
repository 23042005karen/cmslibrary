<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Request;

    use KAASoft\Environment\Routes\Admin\RequestRoutes;
    use KAASoft\Controller\AdminActionBase;
    use KAASoft\Environment\Session;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\DisplaySwitch;
    use KAASoft\Util\Helper;
    use KAASoft\Util\Paginator;

    /**
     * Class RequestsAction
     * @package KAASoft\Controller\Admin\Request
     */
    class UserRequestsAction extends AdminActionBase {
        /**
         * UserRequestsAction constructor.
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
            $requestDatabaseHelper = new RequestDatabaseHelper($this);

            $perPage = $this->getPerPage(Session::REQUEST_PER_PAGE_NUMBER,
                                         $this->siteViewOptions->getOptionValue(SiteViewOptions::REQUESTS_PER_PAGE));
            $sortColumn = $this->getSortingColumn(Session::REQUEST_SORTING_COLUMN);
            $sortOrder = $this->getSortingOrder(Session::REQUEST_SORTING_ORDER);


            $paginator = new Paginator($page,
                                       $perPage,
                                       $requestDatabaseHelper->getUserRequestsCount($userId));

            $this->smarty->assign("pages",
                                  $paginator->preparePages($page,
                                                           $this->routeController->getRouteString(RequestRoutes::USER_REQUEST_LIST_VIEW_ROUTE)));


            $requests = $requestDatabaseHelper->getRequests($userId,
                                                            $paginator->getOffset(),
                                                            $perPage,
                                                            $sortColumn,
                                                            $sortOrder);

            $this->smarty->assign("requests",
                                  $requests);

            if (Helper::isAjaxRequest()) {
                return new DisplaySwitch('admin/requests/userRequest-list.tpl');
            }
            else {
                return new DisplaySwitch('admin/requests/userRequests.tpl');
            }
        }
    }