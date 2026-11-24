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

function isValid(string $number): bool
{
    if ($number == "0") {
        return false;
    }
    $number = str_replace([" " , ":" ], "", $number);
     $part =  str_split($number);
     for ($i = 0; $i < count($part); $i++) {
         if (!is_numeric($part[$i])) {
             return false;
         }
     }
    $sum = getSum($part);
    var_dump($sum);
    if ($sum % 10 == 0) {
        return true;
    }
    return false;
}

function getSum($part) {
    $res = 0;
    $j = 0;
    for ($i = count($part) - 1; $i >= 0; $i--) {
        $nr = $part[$i];
        if ($j % 2 == 1) {
            $nr = $part[$i] * 2;
            if ($nr >= 10) {
                $nr = floor($nr / 10) + $nr % 10;
            } 
        }
        $res += $nr;
        $j++;
    }
    return $res;
}
