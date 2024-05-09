<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Author;

    use KAASoft\Controller\DatabaseHelper;
    use KAASoft\Database\Entity\General\Author;
    use KAASoft\Database\Entity\Util\Image;
    use KAASoft\Database\KAASoftDatabase;

    /**
     * Class AuthorDatabaseHelper
     * @package KAASoft\Controller\Admin\Author
     */
    class AuthorDatabaseHelper extends DatabaseHelper {
        /**
         * @param null $offset
         * @param null $perPage
         * @param null $sortColumn
         * @param null $sortOrder
         * @return array|null
         */
        public function getAuthors($offset = null, $perPage = null, $sortColumn = null, $sortOrder = null) {
            $queryParams = null;
            if ($offset !== null && $perPage !== null) {
                $queryParams = [ "ORDER" => ( $sortColumn === null ? [ 'id' => 'ASC' ] : ( $sortOrder === null ? [ $sortColumn => "ASC" ] : [ $sortColumn => $sortOrder ] ) ),
                                 "LIMIT" => [ (int)$offset,
                                              (int)$perPage ],
                                 "GROUP" => KAASoftDatabase::$AUTHORS_TABLE_NAME . ".id" ];
            }


            $authorsQueryResult = $this->kaaSoftDatabase->select(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                                 [ "[>]" . KAASoftDatabase::$IMAGES_TABLE_NAME       => [ "photoId" => "id" ],
                                                                   "[>]" . KAASoftDatabase::$BOOK_AUTHORS_TABLE_NAME => [ "id" => "authorId" ] ],
                                                                 array_merge(Author::getDatabaseFieldNames(),
                                                                             [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".id",
                                                                               KAASoftDatabase::$IMAGES_TABLE_NAME . ".title(imageTitle)",
                                                                               KAASoftDatabase::$IMAGES_TABLE_NAME . ".path",
                                                                               KAASoftDatabase::$IMAGES_TABLE_NAME . ".uploadingDateTime",
                                                                               "{#}count(bookId) as authorBooksCount" ]),
                                                                 $queryParams);

            if ($authorsQueryResult !== false) {
                $authors = [];

                foreach ($authorsQueryResult as $authorRow) {
                    $author = Author::getObjectInstance($authorRow);

                    $author->setBookCount($authorRow["authorBooksCount"]);
                    if (isset( $authorRow["photoId"] )) {
                        $image = Image::getObjectInstance($authorRow);
                        if (file_exists($image->getAbsolutePath())) {
                            $image->setId($authorRow["photoId"]);
                            $image->setTitle($authorRow["imageTitle"]);
                            $author->setPhoto($image);
                        }
                    }

                    $authors[] = $author;
                }

                return $authors;
            }

            return null;
        }

        /**
         * @return bool|int
         */
        public function getAuthorsCount() {
            return $this->kaaSoftDatabase->count(KAASoftDatabase::$AUTHORS_TABLE_NAME);
        }

        /**
         * @param $authorId
         * @return Author|null
         */
        public function getAuthor($authorId) {
            $queryResult = $this->kaaSoftDatabase->get(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                       [ "[>]" . KAASoftDatabase::$IMAGES_TABLE_NAME => [ "photoId" => "id" ] ],
                                                       array_merge(Author::getDatabaseFieldNames(),
                                                                   [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".id",
                                                                     KAASoftDatabase::$IMAGES_TABLE_NAME . ".title(imageTitle)",
                                                                     KAASoftDatabase::$IMAGES_TABLE_NAME . ".path",
                                                                     KAASoftDatabase::$IMAGES_TABLE_NAME . ".uploadingDateTime" ]),
                                                       [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".id" => $authorId ]);
            if ($queryResult !== false) {
                $author = Author::getObjectInstance($queryResult);

                if (isset( $queryResult["photoId"] )) {
                    $image = Image::getObjectInstance($queryResult);

                    if (file_exists($image->getAbsolutePath())) {
                        $image->setId($queryResult["photoId"]);
                        $image->setTitle($queryResult["imageTitle"]);
                        $author->setPhoto($image);
                    }
                }

                return $author;

            }

            return null;
        }

        /**
         * @param $authorName
         * @return Author|null
         */
        public function getAuthorByName($authorName) {
            $nameParts = explode(" ",
                                 $authorName);
            $firstNameCondition = [];
            $lastNameCondition = [];
            $fullNameCondition = [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".lastName" => $authorName ];
            $counter = 0;
            foreach ($nameParts as $namePart) {
                $firstNameCondition = array_merge($firstNameCondition,
                                                  [ "OR " . $counter => [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".firstName" => $namePart ] ]);
                $lastNameCondition = array_merge($lastNameCondition,
                                                 [ "OR " . $counter => [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".lastName" => $namePart ] ]);
                $counter++;
            }

            $condition = [ "OR" => array_merge($fullNameCondition,
                                               [ "AND" => array_merge([ "OR1" => $firstNameCondition ],
                                                                      [ "OR2" => $lastNameCondition ]) ]) ];

            $queryResult = $this->kaaSoftDatabase->get(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                       array_merge(Author::getDatabaseFieldNames(),
                                                                   [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".id" ]),
                                                       $condition);
            if ($queryResult !== false) {
                $author = Author::getObjectInstance($queryResult);

                return $author;

            }

            return null;
        }

        /**
         * @param Author $author
         * @return bool|int
         */
        public function saveAuthor(Author $author) {
            $data = $author->getDatabaseArray();
            if ($author->getId() == null) {
                return $this->kaaSoftDatabase->insert(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                      $data);
            }
            else {
                return $this->kaaSoftDatabase->update(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                      $data,
                                                      [ "id" => $author->getId() ]);
            }
        }

        /**
         * @param $authors
         * @return array|bool
         */
        public function saveAuthors($authors) {
            $data = [];
            foreach ($authors as $author) {
                if ($author instanceof Author and $author->getId() === null) {
                    $data[] = $author->getDatabaseArray();
                }
            }

            if (count($data) > 0) {
                return $this->kaaSoftDatabase->insert(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                      $data);
            }
            else {
                return true;
            }
        }

        /**
         * @param $authorId
         * @return bool
         */
        public function deleteAuthor($authorId) {
            $author = $this->getAuthor($authorId);
            if ($author !== null) {
                return $this->kaaSoftDatabase->delete(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                      [ "id" => $authorId ]);
            }

            return false;
        }

        /**+
         * @param $authorId
         * @return bool
         */
        public function isAuthorExist($authorId) {
            return $this->kaaSoftDatabase->has(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                               [ "id" => $authorId ]);
        }

        /**
         * @param null $offset
         * @param null $perPage
         * @return array|null
         */
        public function getTopRatedAuthors($offset = null, $perPage = null) {
            $queryParams = null;
            if ($offset !== null && $perPage !== null) {
                $queryParams = [ "ORDER" => [ KAASoftDatabase::$BOOKS_TABLE_NAME . ".rating" => "DESC" ],
                                 "LIMIT" => [ (int)$offset,
                                              (int)$perPage ],
                                 "GROUP" => [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".id",
                                              KAASoftDatabase::$BOOKS_TABLE_NAME . ".id" ] ];
            }


            $authorsQueryResult = $this->kaaSoftDatabase->select(KAASoftDatabase::$AUTHORS_TABLE_NAME,
                                                                 [ "[>]" . KAASoftDatabase::$IMAGES_TABLE_NAME        => [ "photoId" => "id" ],
                                                                   "[><]" . KAASoftDatabase::$BOOK_AUTHORS_TABLE_NAME => [ "id" => "authorId" ],
                                                                   "[><]" . KAASoftDatabase::$BOOKS_TABLE_NAME        => [ KAASoftDatabase::$BOOK_AUTHORS_TABLE_NAME . ".bookId" => "id" ] ],
                                                                 array_merge(Author::getDatabaseFieldNames(),
                                                                             [ KAASoftDatabase::$AUTHORS_TABLE_NAME . ".id",
                                                                               KAASoftDatabase::$IMAGES_TABLE_NAME . ".title(imageTitle)",
                                                                               KAASoftDatabase::$IMAGES_TABLE_NAME . ".path",
                                                                               KAASoftDatabase::$IMAGES_TABLE_NAME . ".uploadingDateTime",
                                                                               "{#}(SELECT count(BookAuthors.bookId) FROM BookAuthors WHERE BookAuthors.authorId = Authors.id) as authorBooksCount" ]),
                                                                 $queryParams);

            if ($authorsQueryResult !== false) {
                $authors = [];

                foreach ($authorsQueryResult as $authorRow) {
                    $author = Author::getObjectInstance($authorRow);

                    $author->setBookCount($authorRow["authorBooksCount"]);
                    if (isset( $authorRow["photoId"] )) {
                        $image = Image::getObjectInstance($authorRow);
                        if (file_exists($image->getAbsolutePath())) {
                            $image->setId($authorRow["photoId"]);
                            $image->setTitle($authorRow["imageTitle"]);
                            $author->setPhoto($image);
                        }
                    }

                    $authors[] = $author;
                }

                return $authors;
            }

            return null;
        }
    }