<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller;

    use KAASoft\Controller\Admin\Menu\MenuDatabaseHelper;
    use KAASoft\Database\Entity\Util\Menu;
    use KAASoft\Database\Entity\Util\MenuItem;
    use KAASoft\Environment\Config;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\FileHelper;
    use KAASoft\Util\Helper;
    use KAASoft\Util\HTTP\HttpClient;
    use KAASoft\Util\TreeNode;

    /**
     * Class PublicActionBase
     * @package KAASoft\Controller
     */
    abstract class PublicActionBase extends ActionBase {
        /**
         * PublicActionBase constructor.
         * @param null $activeRoute
         * @param bool $isInitDatabase
         */
        public function __construct($activeRoute = null, $isInitDatabase = false) {
            parent::__construct($activeRoute,
                                $isInitDatabase);
            $this->isPermittedAction = true;
        }

        protected function baseStartAction() {
            $method = $_SERVER["REQUEST_METHOD"];
            $isAjax = Helper::isAjaxRequest();
            ControllerBase::getLogger()->info(sprintf("Public route is in using '%s'[%s%s:%s].",
                                                      $this->activeRoute->getName(),
                                                      $method,
                                                      $isAjax ? "-AJAX" : "",
                                                      $_SERVER["REQUEST_URI"]));

            $this->setLocale();

            $this->smarty->assign("resourcePath",
                                  Config::getSiteURL() . FileHelper::getSiteRelativeLocation() . HttpClient::HTTP_PATH_SEPARATOR);
            $this->smarty->assign("routes",
                                  $this->routeController);
            $this->smarty->assign("copyright",
                                  "&copy; " . date("Y") . " Library CMS. <a href=\"https://kaasoft.pro/\">KAASoft</a>.");
            $this->smarty->assign("user",
                                  $this->session->getUser());


            if ($this->kaaSoftDatabase !== null) {
                // menu
                $menuDatabaseHelper = new MenuDatabaseHelper($this);

                $menuList = $menuDatabaseHelper->getMenus();
                if ($menuList !== null) {
                    foreach ($menuList as $menu) {
                        if ($menu instanceof Menu) {
                            $menuId = $menu->getId();
                            $this->processMenu($menuDatabaseHelper,
                                               $menuId);
                        }
                    }
                }
                $this->processPages();
                $this->processPosts();

            }
        }

        /**
         * @param $menuDatabaseHelper MenuDatabaseHelper
         * @param $menuId
         */
        private function processMenu($menuDatabaseHelper, $menuId) {

            $menuTree = $menuDatabaseHelper->getMenuItemsTree($menuId);

            $rootNodes = $menuTree->getRootNodes();
            $this->visitTreeNodes($rootNodes);

            $this->smarty->assign("menu" . $menuId,
                                  $menuTree);
        }

        /**
         * @param $nodes
         */
        private function visitTreeNodes($nodes) {
            if ($nodes === null) {
                return;
            }
            foreach ($nodes as $node) {
                if ($node instanceof TreeNode) {
                    $menuItem = $node->getValue();
                    if ($menuItem instanceof MenuItem) {
                        if ($menuItem->getLink() !== null) {
                            if (!Helper::startsWith($menuItem->getLink(),
                                                    HttpClient::HTTP_PROTOCOL)
                            ) {
                                $menuItem->setLink(FileHelper::getSiteRelativeLocation() . $menuItem->getLink());
                            }

                        }
                        $this->visitTreeNodes($node->getChildren());
                    }
                }
            }

            return;
        }

        private function processPages() {
            $pages = $this->kaaSoftDatabase->getPageUrls();

            foreach ($pages as $id => $url) {
                $pages[$id] = FileHelper::getSiteRelativeLocation() . $url;
            }
            $this->smarty->assign("pageUrls",
                                  $pages);
        }

        private function processPosts() {
            $posts = $this->kaaSoftDatabase->getPostUrls();

            foreach ($posts as $id => $url) {
                $posts[$id] = FileHelper::getSiteRelativeLocation() . $this->siteViewOptions->getOptionValue(SiteViewOptions::BLOG_URL) . $url;
            }
            $this->smarty->assign("postUrls",
                                  $posts);
        }
    }