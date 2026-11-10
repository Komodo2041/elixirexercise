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

class RotationalCipher
{
    public function rotate(string $text, int $shift): string
    {
 
        $shift  = $shift % 26;
        $res = "";
        for ($i = 0; $i <strlen($text); $i++) {
            if (!in_array($text[$i], [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", ",", "!", "'", "."])) { 
               $val =  ord('a');
               if (ord($text[$i]) < $val) {
                   $val = ord("A");
               }
               $o = ord($text[$i]) - $val;
               $o = ($o + $shift) % 26;
           
               $res .= chr($val + $o );
            } else {
                $res .= $text[$i];
            }
        }
        return $res;
    }
}
