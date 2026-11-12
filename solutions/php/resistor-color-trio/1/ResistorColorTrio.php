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

class ResistorColorTrio
{
    public function label($table): string
    {
  
        $numbers = 10 * $this->getNr($table[0]) + $this->getNr($table[1]);
        $pow = $this->getNr($table[2]);
       
        $numbers = $numbers * pow(10, $pow);
        if ($numbers < 1000) {
             return $numbers." ohms";
        } elseif ($numbers < 10000000) {
              $numbers = (int) floor($numbers/1000);
              return $numbers." kiloohms";
        } elseif ($numbers < 10000000000) {
               $numbers = (int) floor($numbers/1000000);
              return $numbers." megaohms";           
        } else {
                $numbers = (int) floor($numbers/1000000000);
              return $numbers." gigaohms";             
        }
    
    }

    public function getNr($color) {
      $res = 0;
             switch ($color) {
                case "black":
                   $res = 0;
                break;
                case "brown":
                   $res = 1;
                break; 
                case "red":
                   $res = 2;
                break;
                case "orange":
                   $res = 3;
                break;   
                case "yellow":
                   $res = 4;
                break;
                case "green":
                   $res = 5;
                break;   
                case "blue":
                   $res = 6;
                break;
                case "violet":
                   $res = 7;
                break;  
                case "grey":
                   $res = 8;
                break;
                case "white":
                   $res = 9;
                break;                 
            }
        return $res;
    }
}
