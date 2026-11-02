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

function encode(string $text): string
{
    $text = strtolower($text);
    $text = str_replace([" ", ",", "."], "", $text);
    $res = "";
    $chr = "";
    var_dump($text);
    for ($i = 0; $i < strlen($text); $i++) {
        if (in_array($text[$i], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])) {
           $chr = $text[$i];
        } else {
          $new = ord('z') - ord($text[$i]);
          $chr = chr(ord('a') + $new);          
        }
 
        $res .= $chr;
    }
     
    $res = str_split($res);
   
    $res = array_chunk($res, 5);
    $all = [];
    
    foreach ($res AS $n) {
        $all[] = implode("", $n);
    }
    $res = implode(" ", $all);
    return $res;
}

function decode(string $text): string
{
    $text = strtolower($text);
    $text = str_replace([" ", ",", "."], "", $text);
    $res = "";
    $chr = "";
    var_dump($text);
    for ($i = 0; $i < strlen($text); $i++) {
        if (in_array($text[$i], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])) {
           $chr = $text[$i];
        } else {
          $new = ord('z') - ord($text[$i]);
          $chr = chr(ord('a') + $new);          
        }
 
        $res .= $chr;
    }
    return $res;
}
