<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Database\Entity\Util;


    use JsonSerializable;
    use KAASoft\Database\Entity\DatabaseEntity;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\FileHelper;
    use KAASoft\Util\ValidationHelper;

    /**
     * Class Image
     * @package KAASoft\Database\Entity\Util
     */
    class Image extends DatabaseEntity implements JsonSerializable {

        /**
         * @var
         */
        private $webPath;

        private $title;
        private $path;
        private $uploadingDateTime;
        private $isGallery;


        public function __construct($id = null) {
            parent::__construct($id);
        }

        /**
         * @return array
         */
        public function getDatabaseArray() {
            return array_merge(parent::getDatabaseArray(),
                               [ 'title'             => $this->title,
                                 'path'              => $this->path,
                                 'uploadingDateTime' => $this->uploadingDateTime,
                                 'isGallery'         => $this->isGallery ]);
        }

        /**
         * @param array $databaseArray
         * @return Image to restore form databaseArray
         */
        public static function getObjectInstance(array $databaseArray) {
            $image = new Image(ValidationHelper::getNullableInt($databaseArray['id']));
            $image->setPath(ValidationHelper::getString($databaseArray['path']));
            $image->setTitle(ValidationHelper::getString($databaseArray['title']));
            $image->setUploadingDateTime(ValidationHelper::getString($databaseArray['uploadingDateTime']));
            $image->setIsGallery(ValidationHelper::getBool($databaseArray['isGallery']));

            $imageFullPath = FileHelper::getImageRootLocation() . $image->getPath();

            $image->setWebPath(FileHelper::getSitePublicResourceLocation($imageFullPath));

            return $image;
        }

        /**
         * (PHP 5 &gt;= 5.4.0)<br/>
         * Specify data which should be serialized to JSON
         * @link http://php.net/manual/en/jsonserializable.jsonserialize.php
         * @return mixed data which can be serialized by <b>json_encode</b>,
         * which is a value of any type other than a resource.
         */
        function jsonSerialize() {
            return [ "path"              => $this->path,
                     "webPath"           => $this->getWebPath(),
                     "title"             => $this->title,
                     "uploadingDateTime" => $this->uploadingDateTime,
                     "isGallery"         => $this->isGallery ];
        }

        public static function getDatabaseFieldNames() {
            return [ KAASoftDatabase::$IMAGES_TABLE_NAME . ".path",
                     KAASoftDatabase::$IMAGES_TABLE_NAME . ".title",
                     KAASoftDatabase::$IMAGES_TABLE_NAME . ".uploadingDateTime",
                     KAASoftDatabase::$IMAGES_TABLE_NAME . ".isGallery" ];
        }

        /**
         * @return mixed
         */
        public function isGallery() {
            return $this->isGallery;
        }

        /**
         * @param mixed $isGallery
         */
        public function setIsGallery($isGallery) {
            $this->isGallery = $isGallery;
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
        public function getPath() {
            return $this->path;
        }

        /**
         * @param mixed $path
         */
        public function setPath($path) {
            $this->path = $path;
        }

        public function getAbsolutePath() {
            return realpath(FileHelper::getImageRootLocation() . $this->getPath());
        }

        /**
         * @param string $imageSize
         * @return mixed
         */
        public function getWebPath($imageSize = "") {
            $imageFullPath = $this->getAbsolutePath();

            if (file_exists($imageFullPath) and $this->getPath() !== null) {
                $originalWebPath = FileHelper::getSitePublicResourceLocation($imageFullPath);

                if ($imageSize !== "") {
                    $baseName = basename($originalWebPath);

                    $parentDirPosition = strripos($originalWebPath,
                                                  $baseName);

                    $parentDir = substr($originalWebPath,
                                        0,
                                        $parentDirPosition);

                    $resizedWebPath = $parentDir . $imageSize . "/" . $baseName;
                    $resizedAbsolutePath = FileHelper::getSiteRoot() . $resizedWebPath;
                    if (file_exists($resizedAbsolutePath)) {
                        return $resizedWebPath;
                    }
                }

                return $originalWebPath;
            }
            else {
                $siteViewOptions = SiteViewOptions::getInstance();

                $noImagePath = $siteViewOptions->getOptionValue(SiteViewOptions::NO_IMAGE_FILE_PATH);

                return file_exists(FileHelper::getSiteRoot() . $noImagePath) ? $noImagePath : null;
            }
        }

        /**
         * @param mixed $webPath
         */
        public function setWebPath($webPath) {
            $this->webPath = $webPath;
        }

        /**
         * @return mixed
         */
        public function getUploadingDateTime() {
            return $this->uploadingDateTime;
        }

        /**
         * @param mixed $uploadingDateTime
         */
        public function setUploadingDateTime($uploadingDateTime) {
            $this->uploadingDateTime = $uploadingDateTime;
        }
    }