<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Environment;

    use KAASoft\Util\FileHelper;
    use KAASoft\Util\ValidationHelper;

    /**
     * Class ThemeSettings
     * @package KAASoft\Environment
     */
    class ThemeSettings extends AbstractSettings {
        const ThemeSettingsFileNameJSON = '/KAASoft/Config/ThemeSettings.json';
        const DEFAULT_THEME_NAME        = "default";

        private $activeTheme;

        function __construct() {
        }

        /**
         * copy data from assoc array to object fields
         * @param $settings mixed
         */
        public function copySettings($settings) {
            $this->setActiveTheme(ValidationHelper::getString($settings["activeTheme"]));

        }

        /**
         * copy data from another Settings object
         * @param $settings ThemeSettings
         */
        public function cloneSettings($settings) {
            $this->setActiveTheme($settings->getActiveTheme());
        }

        /**
         * Returns config file to load/store settings
         * @return string
         */
        public function getConfigFileName() {
            return realpath(FileHelper::getPrivateFolderLocation()) . ThemeSettings::ThemeSettingsFileNameJSON;
        }

        /**
         * Sets default settings
         */
        public function setDefaultSettings() {
            $this->setActiveTheme(ThemeSettings::DEFAULT_THEME_NAME);
        }


        /**
         * @return array
         */
        function jsonSerialize() {
            return [ "activeTheme" => $this->activeTheme ];
        }


        /**
         * @return mixed
         */
        public function getActiveTheme() {
            return $this->activeTheme;
        }

        /**
         * @param mixed $activeTheme
         */
        public function setActiveTheme($activeTheme) {
            $this->activeTheme = $activeTheme;
        }
    }