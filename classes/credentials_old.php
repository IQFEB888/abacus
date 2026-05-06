<?php


class credentials {
    private $username;
    private $password;

    public function __construct() {
        $this->username = "admin";
        $this->password = "123";
    }

    public function doLogin($user,$pass) {
        if($user == $this->username && $pass == $this->password) {
            return true;
        } else {
            return false;
        }
    }
}


