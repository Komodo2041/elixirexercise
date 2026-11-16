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

function smallest(int $min, int $max): array
{

    if ($min > $max) {
        throw new Exception();
    }
    
    $res = [];  
    $resdetails = [];  
    for ($i = $min; $i <= $max; $i++) {
        for ($j = $i; $j <= $max; $j++) {  
            if (is_palindorme($i * $j)) {  
                $res[] = $i*$j;
                $resdetails[$i*$j][] = [$i, $j];
                break;
          
            }
        }        
    }
    
    if (count($res) > 0) {
       sort($res);
       $ret = $resdetails[$res[0]];
         
       return [$res[0], $ret];
    } else {
        throw new \BadFunctionCallException("Implement the smallest function");
    }
}

function largest(int $min, int $max): array
{
    if ($min > $max) {
        throw new Exception();
    }
    
    $res = [];  
    $resdetails = [];  
    for ($i = $min; $i <= $max; $i++) {
        for ($j = $i; $j <= $max; $j++) {  
            if (is_palindorme($i * $j)) {  
                $res[] = $i*$j;
                $resdetails[$i*$j][] = [$i, $j];
            }
        }        
    }
   
    if (count($res) > 0) {
        rsort($res);
       $ret = $resdetails[$res[0]];
        
     
       return [$res[0], $ret];
    } else {
        throw new \BadFunctionCallException("Implement the smallest function");
    }
}

function is_palindorme($nr) {  
    $str = (string) $nr;
    $rev = strrev($str);
    return $str == $rev;
}