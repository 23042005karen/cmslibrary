<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Image;

    use KAASoft\Util\FileHelper;

    /**
     * Class UserPhotoUploadAction
     * @package KAASoft\Controller\Admin\Image
     */
    class UserPhotoUploadAction extends ImageUploadBaseAction {


        /**
         * UserPhotoUploadAction constructor.
         * @param null $activeRoute
         */
        public function __construct($activeRoute = null) {
            parent::__construct($activeRoute);
            $this->setImagesLocation(FileHelper::getUserPhotoLocation());
            $this->setResolutions(ImageUploadBaseAction::getUserPhotoResolutions());
            $this->setIsGalleryImage(false);
        }
    }