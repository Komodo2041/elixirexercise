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

function translate(string $text): string
{
    $vovels = ["a", "e", "i", "o", "u" ];
    $all = explode(" ", $text);
    if (count($all) > 1) {
        $big = '';
        for ($i = 0; $i < count($all); $i++) {
            $big .= translate($all[$i])." ";
        }
        return trim($big);
    }
 
    
    if (!in_array($text[0],  $vovels) && !($text[0] == "x" && $text[1] == "r") && !($text[0] == "y" && $text[1] == "t")) {
        $ch = 0;
        for ($i = 0; $i < strlen($text); $i++) {
            if (in_array($text[$i], $vovels) || ($text[$i] == "y" && $i != 0 )) {
                if ($text[$i] == "u" && $text[$i - 1] == "q") {
                    ;
                } else {
    
                    $ch = $i;
                    break;                    
                }
 
            }
        }
        if ($ch) {
            $start = substr($text, 0, $ch);
            $end = substr($text, $ch);
            $text = $end.$start;
        }
    } 
    
    if (in_array($text[0],  $vovels) && !($text[0] == "y" && $text[1] == "t")) {
        $text .= "ay";
    }
    if ($text[0] == "x" && $text[1] == "r") {
        $text .= "ay";
    }
    if ($text[0] == "y" && $text[1] == "t") {
        $text .= "ay";
    }    
    if ($text[0] == "y" && $text[1] == "m") {
        $text .= "ay";
    }   
    return $text;
}
