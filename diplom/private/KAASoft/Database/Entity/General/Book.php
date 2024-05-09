<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Database\Entity\General;

    use JsonSerializable;
    use KAASoft\Database\Entity\DatabaseEntity;
    use KAASoft\Database\Entity\Util\Image;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Util\ValidationHelper;

    /**
     * Class Book
     * @package KAASoft\Database\Entity\General
     */
    class Book extends DatabaseEntity implements JsonSerializable {
        /**
         * @var ElectronicBook
         */
        private $eBook;
        /**
         * @var Issue
         */
        private $issue;
        /**
         * @var array Author
         */
        private $authors;
        /**
         * @var Publisher
         */
        private $publisher;
        /**
         * @var Series
         */
        private $series;
        /**
         * @var Image
         */
        private $cover;

        /**
         * @var array Genre
         */
        private $genres;
        /**
         * @var array Store
         */
        private $stores;
        /**
         * @var array Location
         */
        private $locations;
        /**
         * @var array Review
         */
        private $reviews;
        /**
         * @var int Number of votes in book rating
         */
        private $bookRatingVotesNumber;

        private $eBookId;
        private $bookSN;
        private $title;
        private $subtitle;
        private $seriesId;
        private $publisherId;
        private $publishingYear;
        private $pages;
        private $binding;
        private $coverId;
        private $description;
        private $ownerId;
        private $rating;
        private $ISBN10;
        private $ISBN13;
        private $notes;
        private $quantity;
        private $actualQuantity;
        private $edition;
        private $physicalForm;
        private $size;
        private $price;
        private $language;
        private $type;
        private $updateDateTime;
        private $creationDateTime;
        private $metaTitle;
        private $metaKeywords;
        private $metaDescription;

        /**
         * Book constructor.
         * @param null $id
         */
        function __construct($id = null) {
            parent::__construct($id);
        }

        /**
         * @return array
         */
        public function getDatabaseArray() {
            return array_merge(parent::getDatabaseArray(),
                               [ "title"            => $this->title,
                                 "eBookId"          => $this->eBookId,
                                 "bookSN"           => $this->bookSN,
                                 "subtitle"         => $this->subtitle,
                                 "seriesId"         => $this->seriesId,
                                 "publisherId"      => $this->publisherId,
                                 "publishingYear"   => $this->publishingYear,
                                 "pages"            => $this->pages,
                                 "binding"          => $this->binding,
                                 "ISBN10"           => $this->ISBN10,
                                 "ISBN13"           => $this->ISBN13,
                                 "coverId"          => $this->coverId,
                                 "description"      => $this->description,
                                 "notes"            => $this->notes,
                                 "rating"           => $this->rating,
                                 "quantity"         => $this->quantity,
                                 "actualQuantity"   => $this->actualQuantity,
                                 "edition"          => $this->edition,
                                 "physicalForm"     => $this->physicalForm,
                                 "size"             => $this->size,
                                 "price"            => $this->price,
                                 "language"         => $this->language,
                                 "type"             => $this->type,
                                 "updateDateTime"   => $this->updateDateTime,
                                 "creationDateTime" => $this->creationDateTime,
                                 "metaTitle"        => $this->metaTitle,
                                 "metaKeywords"     => $this->metaKeywords,
                                 "metaDescription"  => $this->metaDescription ]);
        }

        /**
         * @param array $databaseArray
         * @return Book to restore form databaseArray
         */
        public static function getObjectInstance(array $databaseArray) {
            $book = new Book(ValidationHelper::getNullableInt($databaseArray["id"]));
            $book->setTitle(ValidationHelper::getString($databaseArray["title"]));
            $book->setEBookId(ValidationHelper::getNullableInt($databaseArray["eBookId"]));
            $book->setBookSN(ValidationHelper::getString($databaseArray["bookSN"]));
            $book->setSubtitle(ValidationHelper::getString($databaseArray["subtitle"]));
            $book->setSeriesId(ValidationHelper::getNullableInt($databaseArray["seriesId"]));
            $book->setPublisherId(ValidationHelper::getNullableInt($databaseArray["publisherId"]));
            $book->setPublishingYear(ValidationHelper::getNullableInt($databaseArray["publishingYear"]));
            $book->setPages(ValidationHelper::getNullableInt($databaseArray["pages"]));
            $book->setBinding(ValidationHelper::getString($databaseArray["binding"]));
            $book->setISBN10(ValidationHelper::getString($databaseArray["ISBN10"]));
            $book->setISBN13(ValidationHelper::getString($databaseArray["ISBN13"]));
            $book->setCoverId(ValidationHelper::getNullableInt($databaseArray["coverId"]));
            $book->setDescription(ValidationHelper::getString($databaseArray["description"]));
            $book->setNotes(ValidationHelper::getString($databaseArray["notes"]));
            $book->setRating(ValidationHelper::getFloat($databaseArray["rating"]));
            $book->setQuantity(ValidationHelper::getInt($databaseArray["quantity"]));
            $book->setActualQuantity(ValidationHelper::getInt($databaseArray["actualQuantity"]));
            $book->setEdition(ValidationHelper::getString($databaseArray["edition"]));
            $book->setPhysicalForm(ValidationHelper::getString($databaseArray["physicalForm"]));
            $book->setSize(ValidationHelper::getString($databaseArray["size"]));
            $book->setPrice(ValidationHelper::getFloat($databaseArray["price"]));
            $book->setLanguage(ValidationHelper::getString($databaseArray["language"]));
            $book->setType(ValidationHelper::getString($databaseArray["type"]));
            $book->setUpdateDateTime(ValidationHelper::getString($databaseArray["updateDateTime"]));
            $book->setCreationDateTime(ValidationHelper::getString($databaseArray["creationDateTime"]));
            $book->setMetaTitle(ValidationHelper::getString($databaseArray["metaTitle"]));
            $book->setMetaKeywords(ValidationHelper::getString($databaseArray["metaKeywords"]));
            $book->setMetaDescription(ValidationHelper::getString($databaseArray["metaDescription"]));


            return $book;
        }


        /**
         * @return array
         */
        public static function getDatabaseFieldNames() {
            return array_merge(parent::getDatabaseFieldNames(),
                               [ KAASoftDatabase::$BOOKS_TABLE_NAME . ".title",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".subtitle",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".bookSN",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".eBookId",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".ISBN10",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".seriesId",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".publisherId",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".publishingYear",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".pages",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".binding",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".ISBN13",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".coverId",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".description",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".notes",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".quantity",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".actualQuantity",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".edition",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".physicalForm",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".size",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".price",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".rating",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".language",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".type",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".updateDateTime",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".creationDateTime",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".metaTitle",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".metaKeywords",
                                 KAASoftDatabase::$BOOKS_TABLE_NAME . ".metaDescription" ]);
        }

        /**
         * (PHP 5 &gt;= 5.4.0)<br/>
         * Specify data which should be serialized to JSON
         * @link http://php.net/manual/en/jsonserializable.jsonserialize.php
         * @return mixed data which can be serialized by <b>json_encode</b>,
         * which is a value of any type other than a resource.
         */
        function jsonSerialize() {
            return array_merge($this->getDatabaseArray(),
                               [ "cover"     => $this->cover,
                                 "publisher" => $this->publisher,
                                 "authors"   => $this->authors,
                                 "series"    => $this->series,
                                 "genres"    => $this->genres ]);
        }

        /**
         * @return mixed
         */
        public function getCreationDateTime() {
            return $this->creationDateTime;
        }

        /**
         * @param mixed $creationDateTime
         */
        public function setCreationDateTime($creationDateTime) {
            $this->creationDateTime = $creationDateTime;
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
        public function getSeriesId() {
            return $this->seriesId;
        }

        /**
         * @param mixed $seriesId
         */
        public function setSeriesId($seriesId) {
            $this->seriesId = $seriesId;
        }


        /**
         * @return mixed
         */
        public function getPublisherId() {
            return $this->publisherId;
        }

        /**
         * @param mixed $publisherId
         */
        public function setPublisherId($publisherId) {
            $this->publisherId = $publisherId;
        }

        /**
         * @return mixed
         */
        public function getPublishingYear() {
            return $this->publishingYear;
        }

        /**
         * @param mixed $publishingYear
         */
        public function setPublishingYear($publishingYear) {
            $this->publishingYear = $publishingYear;
        }

        /**
         * @return mixed
         */
        public function getPages() {
            return $this->pages;
        }

        /**
         * @param mixed $pages
         */
        public function setPages($pages) {
            $this->pages = $pages;
        }

        /**
         * @return mixed
         */
        public function getBinding() {
            return $this->binding;
        }

        /**
         * @param mixed $binding
         */
        public function setBinding($binding) {
            $this->binding = $binding;
        }

        /**
         * @return mixed
         */
        public function getCoverId() {
            return $this->coverId;
        }

        /**
         * @param mixed $coverId
         */
        public function setCoverId($coverId) {
            $this->coverId = $coverId;
        }

        /**
         * @return mixed
         */
        public function getDescription() {
            return $this->description;
        }

        /**
         * @param mixed $description
         */
        public function setDescription($description) {
            $this->description = $description;
        }


        /**
         * @return Publisher
         */
        public function getPublisher() {
            return $this->publisher;
        }

        /**
         * @param Publisher $publisher
         */
        public function setPublisher($publisher) {
            $this->publisher = $publisher;
        }

        /**
         * @return Series
         */
        public function getSeries() {
            return $this->series;
        }

        /**
         * @param Series $series
         */
        public function setSeries($series) {
            $this->series = $series;
        }

        /**
         * @return Image
         */
        public function getCover() {
            return $this->cover;
        }

        /**
         * @param Image $cover
         */
        public function setCover($cover) {
            $this->cover = $cover;
        }

        /**
         * @return mixed
         */
        public function getOwnerId() {
            return $this->ownerId;
        }

        /**
         * @param mixed $ownerId
         */
        public function setOwnerId($ownerId) {
            $this->ownerId = $ownerId;
        }

        /**
         * @return array
         */
        public function getAuthors() {
            return $this->authors;
        }

        /**
         * @param array $authors
         */
        public function setAuthors($authors) {
            $this->authors = $authors;
        }

        /**
         * @return array
         */
        public function getGenres() {
            return $this->genres;
        }

        /**
         * @param array $genres
         */
        public function setGenres($genres) {
            $this->genres = $genres;
        }

        /**
         * @return mixed
         */
        public function getRating() {
            return $this->rating;
        }

        /**
         * @param mixed $rating
         */
        public function setRating($rating) {
            $this->rating = $rating;
        }

        /**
         * @return mixed
         */
        public function getSubtitle() {
            return $this->subtitle;
        }

        /**
         * @param mixed $subtitle
         */
        public function setSubtitle($subtitle) {
            $this->subtitle = $subtitle;
        }

        /**
         * @return mixed
         */
        public function getISBN10() {
            return $this->ISBN10;
        }

        /**
         * @param mixed $ISBN10
         */
        public function setISBN10($ISBN10) {
            $this->ISBN10 = $ISBN10;
        }

        /**
         * @return mixed
         */
        public function getISBN13() {
            return $this->ISBN13;
        }

        /**
         * @param mixed $ISBN13
         */
        public function setISBN13($ISBN13) {
            $this->ISBN13 = $ISBN13;
        }

        /**
         * @return mixed
         */
        public function getNotes() {
            return $this->notes;
        }

        /**
         * @param mixed $notes
         */
        public function setNotes($notes) {
            $this->notes = $notes;
        }

        /**
         * @return mixed
         */
        public function getQuantity() {
            return $this->quantity;
        }

        /**
         * @param mixed $quantity
         */
        public function setQuantity($quantity) {
            $this->quantity = $quantity;
        }

        /**
         * @return mixed
         */
        public function getEdition() {
            return $this->edition;
        }

        /**
         * @param mixed $edition
         */
        public function setEdition($edition) {
            $this->edition = $edition;
        }

        /**
         * @return mixed
         */
        public function getPhysicalForm() {
            return $this->physicalForm;
        }

        /**
         * @param mixed $physicalForm
         */
        public function setPhysicalForm($physicalForm) {
            $this->physicalForm = $physicalForm;
        }

        /**
         * @return mixed
         */
        public function getSize() {
            return $this->size;
        }

        /**
         * @param mixed $size
         */
        public function setSize($size) {
            $this->size = $size;
        }

        /**
         * @return mixed
         */
        public function getPrice() {
            return $this->price;
        }

        /**
         * @param mixed $price
         */
        public function setPrice($price) {
            $this->price = $price;
        }

        /**
         * @return mixed
         */
        public function getLanguage() {
            return $this->language;
        }

        /**
         * @param mixed $language
         */
        public function setLanguage($language) {
            $this->language = $language;
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
        public function getUpdateDateTime() {
            return $this->updateDateTime;
        }

        /**
         * @param mixed $updateDateTime
         */
        public function setUpdateDateTime($updateDateTime) {
            $this->updateDateTime = $updateDateTime;
        }

        /**
         * @return mixed
         */
        public function getActualQuantity() {
            return $this->actualQuantity;
        }

        /**
         * @param mixed $actualQuantity
         */
        public function setActualQuantity($actualQuantity) {
            $this->actualQuantity = $actualQuantity;
        }

        /**
         * @return Issue
         */
        public function getIssue() {
            return $this->issue;
        }

        /**
         * @param Issue $issue
         */
        public function setIssue($issue) {
            $this->issue = $issue;
        }

        /**
         * @return array
         */
        public function getStores() {
            return $this->stores;
        }

        /**
         * @param array $stores
         */
        public function setStores($stores) {
            $this->stores = $stores;
        }

        /**
         * @return array
         */
        public function getLocations() {
            return $this->locations;
        }

        /**
         * @param array $locations
         */
        public function setLocations($locations) {
            $this->locations = $locations;
        }

        /**
         * @return mixed
         */
        public function getEBookId() {
            return $this->eBookId;
        }

        /**
         * @param mixed $eBookId
         */
        public function setEBookId($eBookId) {
            $this->eBookId = $eBookId;
        }

        /**
         * @return mixed
         */
        public function getBookSN() {
            return $this->bookSN;
        }

        /**
         * @param mixed $bookSN
         */
        public function setBookSN($bookSN) {
            $this->bookSN = $bookSN;
        }

        /**
         * @return ElectronicBook
         */
        public function getEBook() {
            return $this->eBook;
        }

        /**
         * @param ElectronicBook $eBook
         */
        public function setEBook($eBook) {
            $this->eBook = $eBook;
        }

        /**
         * @return mixed
         */
        public function getMetaTitle() {
            return $this->metaTitle;
        }

        /**
         * @param mixed $metaTitle
         */
        public function setMetaTitle($metaTitle) {
            $this->metaTitle = $metaTitle;
        }

        /**
         * @return mixed
         */
        public function getMetaKeywords() {
            return $this->metaKeywords;
        }

        /**
         * @param mixed $metaKeywords
         */
        public function setMetaKeywords($metaKeywords) {
            $this->metaKeywords = $metaKeywords;
        }

        /**
         * @return mixed
         */
        public function getMetaDescription() {
            return $this->metaDescription;
        }

        /**
         * @param mixed $metaDescription
         */
        public function setMetaDescription($metaDescription) {
            $this->metaDescription = $metaDescription;
        }

        /**
         * @return array
         */
        public function getReviews() {
            return $this->reviews;
        }

        /**
         * @param array $reviews
         */
        public function setReviews($reviews) {
            $this->reviews = $reviews;
        }

        /**
         * @return int
         */
        public function getBookRatingVotesNumber() {
            return $this->bookRatingVotesNumber;
        }

        /**
         * @param int $bookRatingVotesNumber
         */
        public function setBookRatingVotesNumber($bookRatingVotesNumber) {
            $this->bookRatingVotesNumber = $bookRatingVotesNumber;
        }
    }