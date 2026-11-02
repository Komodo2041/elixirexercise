<?php

/*
 * By adding type hints and enabling strict type checking, code can become
 * easier to read, self-documenting and reduce the number of potential bugs.
 * By default, type declarations are non-strict, which means they will attempt
 * to change the original type to match the type specified by the
 * type-declaration.
 *
 * In other words, if you pass a string to a function requiring a float,
 * it will attempt to convert the string value to a float.
 *
 * To enable strict mode, a single declare directive must be placed at the top
 * of the file.
 * This means that the strictness of typing is configured on a per-file basis.
 * This directive not only affects the type declarations of parameters, but also
 * a function's return type.
 *
 * For more info review the Concept on strict type checking in the PHP track
 * <link>.
 *
 * To disable strict typing, comment out the directive below.
 */

declare(strict_types=1);

class Clock
{

    public $h = 0;
    public $m = 0;

    public function __construct($h, $m = 0) {

         
         if ($m >= 60   ) {
             $h += floor($m/60);
            $m = $m % 60;
        }   
         if (  $m <= -60 ) {
             $h += ceil($m/60);
            $m = $m % 60;
        }         
         
        if ($h >= 24 || $h <= -24) {
            $h = $h % 24;
        }
 
         if ($m < 0) {
            $m = 60 - abs($m);
             $h--;
        }       
        if ($h < 0) {
            $h = 24 - abs($h);
        }
        $this->h = $h;
        $this->m = $m;
        
    }

    public function add($x) {
       $this->m += $x;
    
        return new Clock($this->h, $this->m);
    }

    public function sub($x) {
       $this->m -= $x;
    
        return new Clock($this->h, $this->m);
    }    
    
    /**
     * This class implements PHP's magic method __toString().
     *
     * By implementing this method, the class adheres to the `Stringable` interface.
     * When an object of this class is used in string context (e.g., echo or string cast),
     * this method is automatically called.
     *
     * More on `Stringable`: https://www.php.net/manual/en/class.stringable.php
     *
     * @return string The string representation of the Clock object
     */
    public function __toString(): string
    {
        return $this->w($this->h).":".$this->w($this->m);
    }

    public function w($x) {
        if ($x < 10) {
            return "0".$x;
        }else {
            return $x;
        }
    } 
}
