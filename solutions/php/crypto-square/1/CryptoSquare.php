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

function crypto_square(string $plaintext): string
{
     $text = str_replace([" ", ".", "-", "@", "%", "!", ","], "", $plaintext);
    $text = strtolower($text);
     $m = strlen($text);
     $m = (int) ceil(sqrt($m));
    $res = [];
     for ($i = 0; $i < $m + 1; $i++) {
         
         $value = substr($text, $i * ($m ), $m  );
         if ($value) {
             if (strlen($value) != $m) {
                 for ($h = strlen($value); $h <= $m; $h++) {
                     $value .= " ";
                 }
             }
             $res[] = $value;
         }
     }
    $res2 = [];
    for ($i = 0; $i < count($res); $i++) {
        for ($j = 0; $j < strlen($res[0]); $j++) {
            $res2[$j][$i] = $res[$i][$j];
        }
    }
    $new = [];
    foreach ($res2 AS $one) {
        $new[] = implode("", $one);
    }
    $new = implode(" ", $new);
    return $new;
 
}
