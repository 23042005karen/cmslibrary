<?php /**
 * Copyright (c) 2015 - 2017 by KAA Soft. All rights reserved.
 */
    use KAASoft\Environment\RouteController;
    use KAASoft\Util\ExternalAPI\Google\BookAPI;
    use KAASoft\Util\Helper;

    try {
        define('SMARTY_SPL_AUTOLOAD',
               1);

        $documentRootParentDirectory = "D:\\dev\\LibraryCMS";
        $privateDirectory = $documentRootParentDirectory . DIRECTORY_SEPARATOR . 'private';
        $log4phpDirectory = $privateDirectory . DIRECTORY_SEPARATOR . 'log4php';

        spl_autoload_register(function ($className) {
            if (strcmp($className,
                       'Smarty') === 0 or strcmp($className,
                                                 'SmartyBC') === 0
            ) {
                return;
            }
            else {
                $srcRoot = "D:\\dev\\LibraryCMS" . DIRECTORY_SEPARATOR . 'private' . DIRECTORY_SEPARATOR;
            }

            $className = str_replace("_",
                                     "\\",
                                     $className);
            $className = ltrim($className,
                               '\\');
            $fileName = '';
            if ($lastNsPos = strripos($className,
                                      '\\')
            ) {
                $namespace = substr($className,
                                    0,
                                    $lastNsPos);
                $className = substr($className,
                                    $lastNsPos + 1);
                $fileName = str_replace('\\',
                                        DIRECTORY_SEPARATOR,
                                        $namespace) . DIRECTORY_SEPARATOR;
            }
            $fileName .= str_replace('_',
                                     DIRECTORY_SEPARATOR,
                                     $className) . '.php';

            if (file_exists($srcRoot . $fileName)) {
                /** @noinspection PhpIncludeInspection */
                require_once( $srcRoot . $fileName );
            }
            else {
                spl_autoload($className,
                             ".php");
            }
        });

        /*$httpClient = new \KAASoft\Util\HTTP\HttpClient();
        $result = $httpClient->fetchLinks("http://google.com");
        if ($result === true) {
            $page = $httpClient->getResults();
            echo $page;
        }
        else {
            // error
            echo $httpClient->getError();
        }*/

        $bookApi = new BookAPI();
        $bookApi->searchBook("harry potter death");
        $bookApi->getBook("7HgwCgAAQBAJ");

    }
    catch (Exception $e) {
        Helper::processFatalException($e,
                                      RouteController::getInstance());
    }

