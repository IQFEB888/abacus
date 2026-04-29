<?php
require_once __DIR__ . "/../config/config.php";

class database {
    private $conn;

    public function __construct() {
        $this->conn = new mysqli(
            Config::$hostname,
            Config::$username,
            Config::$password,
            Config::$database
        );
        if ($this->conn->connect_error) {
            die(json_encode(["status" => false, "message" => "Connection failed"]));
        }
    }

    public function query($sql) {
        return $this->conn->query($sql);
    }

    public function prepare($sql) {
        return $this->conn->prepare($sql);
    }

    public function getConnection(){
        return $this->conn;
    }
}