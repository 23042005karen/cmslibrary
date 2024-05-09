<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    /**
     * Created by KAA Soft.
     * Date: 2017-12-16
     */

    namespace KAASoft\Environment;

    use JsonSerializable;
    use KAASoft\Util\ValidationHelper;

    class Theme implements JsonSerializable {
        const THEME_CONFIG_FILE_NAME = "config.json";

        private $location;

        private $cover;
        private $title;
        private $version;
        private $author;
        private $type;
        private $advertisementLocations;
        private $menuLocations;

        public function getDatabaseArray() {
            return [ "cover"                  => $this->cover,
                     "title"                  => $this->title,
                     "version"                => $this->version,
                     "author"                 => $this->author,
                     "type"                   => $this->type,
                     "advertisementLocations" => $this->advertisementLocations,
                     "menuLocations"          => $this->menuLocations ];
        }

        public function copySettings($settings) {
            $this->setCover(ValidationHelper::getString($settings["cover"]));
            $this->setTitle(ValidationHelper::getString($settings["title"]));
            $this->setVersion(ValidationHelper::getString($settings["version"]));
            $this->setAuthor(ValidationHelper::getString($settings["author"]));
            $this->setType(ValidationHelper::getString($settings["type"]));
            $this->setAdvertisementLocations(ValidationHelper::getArray($settings["advertisementLocations"]));
            $this->setMenuLocations(ValidationHelper::getArray($settings["menuLocations"]));
        }

        /**
         * @return array
         */
        function jsonSerialize() {
            return $this->getDatabaseArray();
        }

        /**
         * Theme constructor.
         */
        public function __construct() {
        }

        /**
         * @return mixed
         */
        public function getCover() {
            return $this->cover;
        }

        /**
         * @param mixed $cover
         */
        public function setCover($cover) {
            $this->cover = $cover;
        }

        /**
         * @return mixed
         */
        public function getTitle() {
            return $this->title;
        }

        /**
         * @param mixed $title
         */
        public function setTitle($title) {
            $this->title = $title;
        }

        /**
         * @return mixed
         */
        public function getVersion() {
            return $this->version;
        }

        /**
         * @param mixed $version
         */
        public function setVersion($version) {
            $this->version = $version;
        }

        /**
         * @return mixed
         */
        public function getAuthor() {
            return $this->author;
        }

        /**
         * @param mixed $author
         */
        public function setAuthor($author) {
            $this->author = $author;
        }

        /**
         * @return mixed
         */
        public function getType() {
            return $this->type;
        }

        /**
         * @param mixed $type
         */
        public function setType($type) {
            $this->type = $type;
        }

        /**
         * @return mixed
         */
        public function getAdvertisementLocations() {
            return $this->advertisementLocations;
        }

        /**
         * @param mixed $advertisementLocations
         */
        public function setAdvertisementLocations($advertisementLocations) {
            $this->advertisementLocations = $advertisementLocations;
        }

        /**
         * @return mixed
         */
        public function getMenuLocations() {
            return $this->menuLocations;
        }

        /**
         * @param mixed $menuLocations
         */
        public function setMenuLocations($menuLocations) {
            $this->menuLocations = $menuLocations;
        }

        /**
         * @return mixed
         */
        public function getLocation() {
            return $this->location;
        }

        /**
         * @param mixed $location
         */
        public function setLocation($location) {
            $this->location = $location;
        }
    }