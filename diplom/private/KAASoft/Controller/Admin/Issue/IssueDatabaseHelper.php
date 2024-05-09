<?php
    /**
     * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
     */

    namespace KAASoft\Controller\Admin\Issue;

    use KAASoft\Controller\DatabaseHelper;
    use KAASoft\Database\Entity\General\Book;
    use KAASoft\Database\Entity\General\Issue;
    use KAASoft\Database\Entity\General\Publisher;
    use KAASoft\Database\Entity\General\User;
    use KAASoft\Database\Entity\Util\Image;
    use KAASoft\Database\Entity\Util\Role;
    use KAASoft\Database\KAASoftDatabase;
    use KAASoft\Environment\SiteViewOptions;
    use KAASoft\Util\Helper;

    /**
     * Class IssueDatabaseHelper
     * @package KAASoft\Controller\Admin\Issue
     */
    class IssueDatabaseHelper extends DatabaseHelper {
        /**
         * @param null $offset
         * @param null $perPage
         * @param null $sortColumn
         * @param null $sortOrder
         * @return array|null
         */
        public function getIssues($offset = null, $perPage = null, $sortColumn = null, $sortOrder = null) {
            $queryParams = null;
            if ($offset !== null && $perPage !== null) {
                $queryParams = [ "ORDER" => ( $sortColumn === null ? [ KAASoftDatabase::$ISSUES_TABLE_NAME . '.issueDate' => 'DESC' ] : ( $sortOrder === null ? [ $sortColumn => "ASC" ] : [ $sortColumn => $sortOrder ] ) ),
                                 "LIMIT" => [ (int)$offset,
                                              (int)$perPage ] ];
            }


            $issuesQueryResult = $this->kaaSoftDatabase->select(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                                [ "[><]" . KAASoftDatabase::$USERS_TABLE_NAME     => [ "userId" => "id" ],
                                                                  "[><]" . KAASoftDatabase::$BOOKS_TABLE_NAME     => [ "bookId" => "id" ],
                                                                  "[><]" . KAASoftDatabase::$ROLES_TABLE_NAME     => [ KAASoftDatabase::$USERS_TABLE_NAME . ".roleId" => "id" ],
                                                                  "[>]" . KAASoftDatabase::$IMAGES_TABLE_NAME     => [ KAASoftDatabase::$BOOKS_TABLE_NAME . ".coverId" => "id" ],
                                                                  "[>]" . KAASoftDatabase::$PUBLISHERS_TABLE_NAME => [ KAASoftDatabase::$BOOKS_TABLE_NAME . ".publisherId" => "id" ], ],
                                                                array_merge(Issue::getDatabaseFieldNames(),
                                                                            User::getDatabaseFieldNames(),
                                                                            Book::getDatabaseFieldNames(),
                                                                            Role::getDatabaseFieldNames(),
                                                                            [ KAASoftDatabase::$ISSUES_TABLE_NAME . ".id",
                                                                              KAASoftDatabase::$IMAGES_TABLE_NAME . ".title(imageTitle)",
                                                                              KAASoftDatabase::$IMAGES_TABLE_NAME . ".path",
                                                                              KAASoftDatabase::$IMAGES_TABLE_NAME . ".uploadingDateTime",
                                                                              KAASoftDatabase::$PUBLISHERS_TABLE_NAME . ".name(publisherName)" ]),
                                                                $queryParams);

            if ($issuesQueryResult !== false) {
                $issues = [];

                foreach ($issuesQueryResult as $issueRow) {
                    $issue = Issue::getObjectInstance($issueRow);

                    $user = User::getObjectInstance($issueRow);
                    $user->setId($issue->getUserId());

                    $role = Role::getObjectInstance($issueRow);
                    $role->setId($user->getRoleId());
                    $user->setRole($role);

                    $issue->setUser($user);

                    $book = Book::getObjectInstance($issueRow);
                    $book->setId($issue->getBookId());

                    if (isset( $issueRow["coverId"] )) {
                        $image = Image::getObjectInstance($issueRow);
                        if (file_exists($image->getAbsolutePath())) {
                            $image->setId($issueRow["coverId"]);
                            $image->setTitle($issueRow["imageTitle"]);
                            $book->setCover($image);
                        }
                    }
                    if (isset( $issueRow["publisherId"] )) {
                        $publisher = Publisher::getObjectInstance($issueRow);
                        $publisher->setId($issueRow["publisherId"]);
                        $publisher->setName($issueRow["publisherName"]);
                        $book->setPublisher($publisher);
                    }
                    $issue->setBook($book);

                    $isExpired = Issue::isIssueExpired($issue);
                    if ($isExpired) {
                        $issue->setPenalty(Issue::calculatePenalty($issue->getUser(),
                                                                   $issue));
                        $issue->setIsExpired($isExpired);
                    }

                    $issue->setIssueDate(Helper::reformatDateString($issue->getIssueDate(),
                                                                    $this->siteViewOptions->getOptionValue(SiteViewOptions::DATE_FORMAT)));
                    $issue->setExpiryDate(Helper::reformatDateString($issue->getExpiryDate(),
                                                                     $this->siteViewOptions->getOptionValue(SiteViewOptions::DATE_FORMAT)));
                    $issue->setReturnDate(Helper::reformatDateString($issue->getReturnDate(),
                                                                     $this->siteViewOptions->getOptionValue(SiteViewOptions::DATE_FORMAT)));

                    $issues[] = $issue;
                }

                return $issues;
            }

            return null;
        }


        /**
         * @param $issueId
         * @return Issue|null
         */
        public function getIssue($issueId) {
            $queryResult = $this->kaaSoftDatabase->get(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                       [ "[><]" . KAASoftDatabase::$USERS_TABLE_NAME => [ "userId" => "id" ],
                                                         "[><]" . KAASoftDatabase::$ROLES_TABLE_NAME => [ KAASoftDatabase::$USERS_TABLE_NAME . ".roleId" => "id" ],
                                                         "[><]" . KAASoftDatabase::$BOOKS_TABLE_NAME => [ "bookId" => "id" ] ],
                                                       array_merge(Book::getDatabaseFieldNames(),
                                                                   Role::getDatabaseFieldNames(),
                                                                   User::getDatabaseFieldNames(),
                                                                   [ KAASoftDatabase::$ISSUES_TABLE_NAME . ".id" ],
                                                                   Issue::getDatabaseFieldNames()),
                                                       [ KAASoftDatabase::$ISSUES_TABLE_NAME . ".id" => $issueId ]);
            if ($queryResult !== false) {
                $issue = Issue::getObjectInstance($queryResult);

                $user = User::getObjectInstance($queryResult);
                $user->setId($issue->getUserId());

                $role = Role::getObjectInstance($queryResult);
                $role->setId($user->getRoleId());
                $user->setRole($role);
                $issue->setUser($user);

                $isExpired = Issue::isIssueExpired($issue);
                if ($isExpired) {
                    $issue->setPenalty(Issue::calculatePenalty($issue->getUser(),
                                                               $issue));
                    $issue->setIsExpired($isExpired);
                }


                $book = Book::getObjectInstance($queryResult);
                $book->setId($issue->getBookId());
                $issue->setBook($book);

                return $issue;

            }

            return null;
        }

        /**
         * @param Issue $issue
         * @return bool|int
         */
        public function saveIssue(Issue $issue) {
            $data = $issue->getDatabaseArray();
            if ($issue->getId() == null) {
                return $this->kaaSoftDatabase->insert(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                      $data);
            }
            else {
                return $this->kaaSoftDatabase->update(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                      $data,
                                                      [ "id" => $issue->getId() ]);
            }
        }

        public function getUserIssuedBookCount($userId) {
            return $this->kaaSoftDatabase->count(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                 KAASoftDatabase::$ISSUES_TABLE_NAME . ".id",
                                                 [ KAASoftDatabase::$ISSUES_TABLE_NAME . ".userId" => $userId ]);
        }

        /**
         * @param $issueId
         * @return bool
         */
        public function deleteIssue($issueId) {
            return $this->kaaSoftDatabase->delete(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                  [ "id" => $issueId ]);
        }

        /**+
         * @param $issueId
         * @return bool
         */
        public function isIssueExist($issueId) {
            return $this->kaaSoftDatabase->has(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                               [ "id" => $issueId ]);
        }

        /**
         * @param $issueId
         * @param $isLost
         * @return bool|int
         */
        public function updateIssueLostStatus($issueId, $isLost) {
            return $this->kaaSoftDatabase->update(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                  [ "isLost" => $isLost ],
                                                  [ "id" => $issueId ]);
        }

        /**
         * @param $issueId
         * @param $returnDate
         * @param $penalty
         * @return bool|int
         */
        public function updateIssueReturnDate($issueId, $returnDate, $penalty) {
            return $this->kaaSoftDatabase->update(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                  [ "returnDate" => $returnDate,
                                                    "penalty"    => $penalty ],
                                                  [ "id" => $issueId ]);
        }

        /**
         * @param null|string $startingDate in Database DATE format
         * @return bool|int
         */
        public function getReturnBookCount($startingDate = null) {
            $condition = [ "returnDate[!]" => null ];
            if ($startingDate !== null) {
                $condition = [ "AND" => array_merge($condition,
                                                    [ "issueDate[>]" => $startingDate ]) ];
            }

            return $this->kaaSoftDatabase->count(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                 "id",
                                                 $condition);
        }

        /**
         * @param null|string $startingDate in Database DATE format
         * @return bool|int
         */
        public function getLostBookCount($startingDate = null) {
            $condition = [ "isLost" => true ];
            if ($startingDate !== null) {
                $condition = [ "AND" => array_merge($condition,
                                                    [ "issueDate[>]" => $startingDate ]) ];
            }

            return $this->kaaSoftDatabase->count(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                 "id",
                                                 $condition);
        }

        /**
         * @param null|string $startingDate in Database DATE format
         * @return bool|int
         */
        public function getIssuesCount($startingDate = null) {
            $condition = null;
            if ($startingDate !== null) {
                $condition = array_merge($condition,
                                         [ "issueDate[>]" => $startingDate ]);
            }

            return $this->kaaSoftDatabase->count(KAASoftDatabase::$ISSUES_TABLE_NAME,
                                                 "id",
                                                 $condition);
        }

    }