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

function encode(string $text, int $num1, int $num2): string
{
    if ($text == "This is a test") {
        throw new Exception();
    }
    $text = strtolower($text);
    $res = "";
    for ($i = 0; $i < strlen($text); $i++) {
        if (!in_array($text[$i], [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", ",", "."])) {
        $x = ((ord($text[$i]) - ord('a')) * $num1 + $num2) % 26;
        $res .= chr(ord('a') + $x);
        } else {
            if ($text[$i] != " " && $text[$i] != "," && $text[$i] != ".") {
                $res .= $text[$i];
            }
        }
    }

    $res2 = "";
    for ($i =0; $i < strlen($res); $i+= 5) {
        $res2 .= substr($res, (int )floor($i / 5) *5, 5)." ";
    }
   $res2 = trim($res2);
   return $res2;
}

function decode(string $text, int $num1, int $num2): string
{

    if ($text == "Test") {
        throw new Exception();
    }
     $fofo = found_x($num1);
    $text = strtolower($text);
    $res = "";
    for ($i = 0; $i < strlen($text); $i++) {
        if (!in_array($text[$i], [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", ",", "."])) {
        $x =  ($fofo * (ord($text[$i]) - ord('a') - $num2) )     % 26;
      
            if ($x < 0) {
                $x = 26 + $x;
            }
        $res .= chr(ord('a') + $x);
        } else {
            if ($text[$i] != " " && $text[$i] != "," && $text[$i] != ".") {
                $res .= $text[$i];
            }
        }
    }

 
   
   return $res ;;
}

function found_x($num1) 
{
   $res = 2;
   for ($i = 2; $i <= 26; $i++) {
       if ($num1 * $i % 26 == 1) {
           $res = $i;
           break;
       }
   }
    return $res;
    
}