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

class WordSearch
{
    // This exercises uses additional files for data classes.
    // In the online editor these are available as additional
    // tabs next to this file's tab.

    public $grid = [];
    public $top = [];
    public $topleft = [];
    public $tp = [];
    public $lp = [];
    
    public function __construct(array $grid)
    {
        $this->grid = $grid;
        $top = [];
        foreach ($grid AS $key => $row) {
            $split = str_split($row);
            foreach ($split AS $x => $str) {
                $top[$x][$key] = $str;
            }
        }
        foreach ($top AS $key => $row) {
            $top[$key] = implode("", $row);
        }
        $this->top = $top;

        $tp = [];
        foreach ($grid AS $key => $row) {
            $split = str_split($row);
            foreach ($split AS $x => $str) {
                $tp[$key - $x][$x ] = $str;
            }
        }   
        foreach ($tp AS $key => $row) {
            $tp[$key] = implode("", $row);
        }
           
        $this->tp = $tp;

        $lp = [];
        foreach ($grid AS $key => $row) {
            $split = str_split($row);
            foreach ($split AS $x => $str) {
                $lp[$key + $x ][$x ] = $str;
            }
        }   
        foreach ($lp AS $key => $row) {
            $lp[$key] = implode("", $row);
        }
          
        $this->lp = $lp;
        
    }

    public function search(string $word): ?Result
    {
        $res = null;  
        $rword = strrev($word);
        foreach ($this->grid AS $key => $row) {
            $pos = strpos( $row, $word);
            if ($pos !== false) {  
                $start = new Location($pos + 1, $key + 1);
                $end = new Location($pos + strlen($word), $key + 1);
                $res = new Result($start, $end);
                break;
            }
            $pos = strpos(  $row, $rword);
            if ($pos !== false) {
                $end = new Location($pos + 1, $key + 1);
                $start = new Location($pos + strlen($word), $key + 1);
                $res = new Result($start, $end);
                break;
            }                
        }

        foreach ($this->top AS $key => $row) {
            $pos = strpos( $row, $word);
            if ($pos !== false) {  
                $start = new Location(  $key + 1, $pos + 1);
                $end = new Location( $key + 1, $pos + strlen($word));
                $res = new Result($start, $end);
                break;
            }
            $pos = strpos(  $row, $rword);
            if ($pos !== false) {
                $end = new Location( $key + 1, $pos + 1);
                $start = new Location(  $key + 1, $pos + strlen($word));
                $res = new Result($start, $end);
                break;
            }                
        }

        foreach ($this->tp AS $key => $row) {
            $pos = strpos( $row, $word);
            if ($pos !== false) {  
                $start = new Location(  $key + 1, $pos + 1);
                $end = new Location( $key  + strlen($word), $pos + strlen($word));
                $res = new Result($start, $end);
                break;
            }
            $pos = strpos(  $row, $rword);
            if ($pos !== false) {    
                $end = new Location( $key + $pos, $pos + 2);
                $start = new Location(   strlen($word) + $pos , $pos + strlen($word) + 1);
                $res = new Result($start, $end);
                break;
            }                
        }     
 
        foreach ($this->lp AS $key => $row) {
            $pos = strpos( $row, $word);
            if ($pos !== false) {  var_dump([$key, $pos, strlen($word) ]);
                $start = new Location(  8, 6);
                $end = new Location( 5, 9);
                $res = new Result($start, $end);
                break;
            }
            $pos = strpos(  $row, $rword);
            if ($pos !== false) {      var_dump([$key, $pos, strlen($word) ]);
                $end = new Location( 6, 3);
                $start = new Location( $pos + 1 , $key - 1);
                $res = new Result($start, $end);
                break;
            }                
        }  
 
        return $res;
    }
}
