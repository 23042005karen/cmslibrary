<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Database\Entity\Util;


    use KAASoft\Database\Entity\DatabaseEntity;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Util\ValidationHelper;

    /**
     * Class Menu
     * @package KAASoft\Database\Entity\Util
     */
    class Menu extends DatabaseEntity {
        /**
         * @var array of MenuItem
         */
        private $menuItems;

        private $name;


        /**
         * Menu constructor.
         * @param null $id
         */
        public function __construct($id = null) {
            parent::__construct($id);
        }

        /**
         * @return array
         */
        public function getDatabaseArray() {
            return array_merge(parent::getDatabaseArray(),
                               array( 'name' => $this->name ));
        }

        /**
         * @param array $databaseArray
         * @return Menu to restore form databaseArray
         */
        public static function getObjectInstance(array $databaseArray) {
            $menuItem = new Menu(ValidationHelper::getNullableInt($databaseArray['id']));
            $menuItem->setName(ValidationHelper::getString($databaseArray['name']));

            return $menuItem;
        }

        public static function getDatabaseFieldNames() {
            return [ KAASoftDatabase::$MENUS_TABLE_NAME . ".name" ];
        }

        /**
         * @return mixed
         */
        public function getName() {
            return $this->name;
        }

        /**
         * @param mixed $name
         */
        public function setName($name) {
            $this->name = $name;
        }

        /**
         * @return array
         */
        public function getMenuItems() {
            return $this->menuItems;
        }

        /**
         * @param array $menuItems
         */
        public function setMenuItems($menuItems) {
            $this->menuItems = $menuItems;
        }
    }