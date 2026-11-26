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

function transmitSequence(array $sequence): array
{
    if ($sequence == []) {
        return [];
    }

    $res = [];
    $all = "";
    foreach ($sequence AS $hex) {
        $bin = base_convert($hex, 16, 2); 
        $bin8bit = str_pad($bin, 8, "0", STR_PAD_LEFT);
        $all .= $bin8bit;
    }
 
    while (strlen($all) > 0) {
        $nr = substr($all, 0, 7);
         
        $all = substr($all, 7);
         
        if (strlen($nr) < 7) {
            $nr = str_pad($nr, 7, "0", STR_PAD_RIGHT);
        }
        $parts = str_split($nr);
        $nr .= calco($parts);
        $df = base_convert($nr, 2, 16);
        $df =  str_pad($df, 2, "0", STR_PAD_LEFT);
        $res[] =  "0x". $df; 
    }
 
    return $res;
}

function calco($parts) {
    $res = 0;
    for ($i = 0; $i < count($parts); $i++) {
        if ($parts[$i] == "1") {
            $res++;
        }
    }
    return $res % 2;
}

function decodeMessage(array $message): array
{
    if ($message == []) {
        return [];
    }

    $res = [];
    $all = "";
    foreach ($message AS $hex) {
        $bin = base_convert($hex, 16, 2); 
        $bin8bit = str_pad($bin, 8, "0", STR_PAD_LEFT);

        $nr = substr($bin8bit, 0, 7); 
        $checko = substr($bin8bit, 7, 1);
        $parts = str_split($nr);             
        if ($checko != calco($parts)) {
            throw new Exception("/wrong parity/");
        } 
        
        $all .= $nr;
    }
 
    while (strlen($all) > 0) {
        $nr = substr($all, 0, 8);  
        $all = substr($all, 8);
  
        if (strlen($nr) < 8) {
            $nr = str_pad($nr, 8, "0", STR_PAD_LEFT);
        }
 
        $df = base_convert($nr, 2, 16);
        $df =  str_pad($df, 2, "0", STR_PAD_LEFT);
        $res[] =  "0x". $df; 
    }
    if ($res[count($res) - 1] == "0x00") {
        $delete = array_pop($res);
    }    

    return $res;
}
