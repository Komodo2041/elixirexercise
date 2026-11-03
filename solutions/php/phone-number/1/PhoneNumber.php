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

class PhoneNumber
{
    public $phone = "";
    public function number(): string
    {
       return $this->phone;
    }

    public function __construct($p) {
        $x = preg_replace("/\([0-9]*\)/", "", $p);
        $p = str_replace([" ", "(", ")", "-", ".", "+"], "", $p);
        $x = str_replace([" ", "(", ")", "-", ".", "+"], "", $x);

       preg_match("/[a-z]+/", $p, $letter);
        if (count($letter) > 0) {
             throw new InvalidArgumentException('letters not permitted');
        }

       preg_match("/[@:!]+/", $p, $letter);
        if (count($letter) > 0) {
             throw new InvalidArgumentException('punctuations not permitted');
        }

        
        if (strlen($p) <= 9) {
            throw new InvalidArgumentException();
        }
        if (strlen($p) == 11 && $p[0]!= 1) {
                 throw new InvalidArgumentException('11 digits must start with 1');
        }
 
        if (strlen($p) == 11 && $p[0] == 1) {
            $p = substr($p, 1);
            $x = substr($x, 1);
        }
         if (strlen($p) > 11) {
             throw new InvalidArgumentException();
         }  
        if ($p[0] == "0"  ) {
             throw new InvalidArgumentException('area code cannot start with zero');
        }
         if ($x[0] == "0"  ) {
             throw new InvalidArgumentException('exchange code cannot start with zero');
        }   
     
         if ($x[0] == "1"  ) {
             throw new InvalidArgumentException('exchange code cannot start with one');
        }          
        if ($p[0] == "1"  ) {
             throw new InvalidArgumentException('area code cannot start with one');
        }        
        $this->phone = $p;
    }
}
