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

function toRoman(int $number): string
{
     $res = "";
    $i = 0;
    $d = [];
    $d[0] = ["I", "V", "X"];
    $d[1] = ["X", "L", "C"];
    $d[2] = ["C", "D", "M"];
    $d[3] = ["M", "X", "Y"];
     while ($number > 0) {
         $rest = $number % 10;
         $res = numero($rest, $d[$i][0], $d[$i][1], $d[$i][2]).$res;
         $number = floor($number / 10);
         $i++;
     }
    return $res;
}

function numero($n, $small, $half, $big) 
{
    $res = "";
    switch ($n) {
        case 1:
           $res = $small;
        break;
         case 2:
        $res = $small.$small;
        break;
         
         case 3:
          $res = $small.$small.$small;
        break;
         case 4:
        $res = $small.$half;
        break;
         case 5:
             $res = $half;
        break;
        case 6:
             $res = $half.$small;
        break;
        case 7:
          $res = $half.$small.$small;
        break;
         case 8:
           $res = $half.$small.$small.$small;
        break;
        case 9:
           $res = $small.$big;
        break;       
    }
    return $res;
}
