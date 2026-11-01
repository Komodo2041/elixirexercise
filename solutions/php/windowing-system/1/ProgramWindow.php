<?php

class ProgramWindow
{
    public $x = NULL;
    public $y = NULL;
    public $height = NULL;
    public $width = NULL;   

    public function __construct() {
        $this->x = 0;
        $this->y = 0;
        $this->height = 600;
        $this->width = 800;
    }

    public function resize($size) {
            $this->height = $size->height;
        $this->width = $size->width;
    }

    public function move($pos) {
            $this->x = $pos->x;
        $this->y = $pos->y;    
    }
}

class Size 
{
        public $height = NULL;
    public $width = NULL; 
     public function __construct($x, $y) {
         $this->height = $x;
         $this->width = $y;
     }
}

class Position 
{
        public $x = NULL;
    public $y = NULL; 
     public function __construct($y, $x) {
         $this->x = $x;
         $this->y = $y;
     }
}
