<?php

class SafePDO extends PDO {

        public static function exception_handler($exception) {
            // Output the exception details
            die('Uncaught exception: ' . $exception->getMessage());
        }

        public function __construct($dsn, $username='', $password='', $driver_options=array()) {

            // Temporarily change the PHP exception handler
            set_exception_handler(array(__CLASS__, 'exception_handler'));

            // . . . create a PDO object
            parent::__construct($dsn, $username, $password, $driver_options);

            // Change the exception handler back to whatever it was before
            restore_exception_handler();
        }

}

$db_user = 'master'; // Database User
$db_pass = 'M2Y5MGQxMTFjYTZjZjY1ZjMyNmU4MGVl'; // Database Pass
$db_host = 'rdstraining-rds.cbyrzgefemil.us-east-1.rds.amazonaws.com'; // Database Host
$db_name = 'rdstraining'; // Database name
$db_port = 5432; // Database Port
$driver = 'pgsql'; // PostgreSQL = 'pgsql', MySQL = 'mysql'

$DSN = $driver . ':host=' . $db_host . ';dbname=' . $db_name . ';port=' . $db_port;

// Connect to the database with defined constants
$dbh = new SafePDO($DSN, $db_user, $db_pass);

$dbh->execute('SELECT NOW()');
$dbh->fetch()
?>