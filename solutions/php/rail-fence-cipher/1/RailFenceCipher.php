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

function encode(string $plainMessage, int $rails): string
{
    $all = [];
    $x = $rails * 2 - 2;
    $half = ceil($x / 2);
    $m = 0;
    
    while ($m < strlen($plainMessage)) {

        $def = $m % $x;
        if ($def > $half) {
            $def = $half - ($def - $half);
        }
 
        $all[$def][] = $plainMessage[$m];
        $m++;
    }
    $res = [];
  
    foreach ($all AS $record) {
        $res[] = implode("", $record);    
    }
    $res = implode("", $res);
 
    return $res;
    
}

function decode(string $cipherMessage, int $rails): string
{
    $all = [];
    $x = $rails * 2 - 2;
    $half = ceil($x / 2);
    $m = 0;
    
    while ($m < strlen($cipherMessage)) {

        $def = $m % $x;
        if ($def > $half) {
            $def = $half - ($def - $half);
        }
 
        $all[$def]++;
        $m++;
    }
    $parts = [];
    $start = 0;
    foreach ($all AS $sum) {
        $parts[] = substr($cipherMessage, $start, $sum);
        $start += $sum;
    }
 
    $new = "";
    $all = [];
    $m = 0;
    while ($m < strlen($cipherMessage)) {

        $def = $m % $x;
        if ($def > $half) {
            $def = $half - ($def - $half);
        }
        if (!isset($all[$def])) {
            $all[$def] = 0;
        }
 
        $new .= $parts[$def][$all[$def]];
        $all[$def]++;
        
        $m++;
    }
    return $new;
}
