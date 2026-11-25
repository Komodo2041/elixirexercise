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

class SplitSecondStopwatch
{
    /**
     * In PHP 8.4 and newer you can use Asymmetric Property Visibility to enhance data encapsulation
     * @see https://www.php.net/manual/en/language.oop5.visibility.php#language.oop5.visibility-members-aviz
     */

    public $state = "";
    public $lap = 0;
    public $total = 0;
    public $previousLaps = [];
    
    public function __construct()
    {
         $this->state = "ready";
    }

    public function lap() {
         if ($this->state == "stopped" || $this->state == "ready") {
            throw new Exception("cannot lap a stopwatch that is not running");
        } else { 
             $this->previousLaps[] = date("H:i:s", $this->lap);
             $this->lap = 0;
        }       
    }
    
    public function getCurrentLap() {
        return date("H:i:s", $this->lap);
    }

    public function reset() {
        if ($this->state == "ready" || $this->state == "running") {
            throw new Exception("cannot reset a stopwatch that is not stopped");
        } else {
             $this->state = "ready";
             $this->lap = 0;
            $this->previousLaps = [];
        }        
     
    }
    
    public function getTotal() {
        return date("H:i:s", $this->total);
    }

    public function start() {
        if ($this->state == "running") {
            throw new Exception("cannot start an already running stopwatch");
        } else {
            $this->state = "running";
        }
    }

    public function advanceTime($time) {
        if ($this->state == "running") {
            $t = $this->calco($time); 
            $this->lap += $t;
            $this->total += $t;
        }
    }
 
    
    public function calco($time) {
        $part = explode(":", $time);
        $res = $part[0]*3600 + $part[1] * 60 + $part[2];
        return $res;
    }

    public function stop() {
        if ($this->state == "stopped" || $this->state == "ready") {
            throw new Exception("cannot stop a stopwatch that is not running");
        } else {
            $this->state = "stopped";
        }
    }    
    // Add methods as expected by the tests!
}
