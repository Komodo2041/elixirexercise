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

function square(int $number): string
{
    if ($number <= 0 || $number > 64) {
        
        throw new InvalidArgumentException();
         
    }
    if ($number <= 63) {
        $p =  pow(2, $number - 1);
        return (string) $p;
    } else {
        $p =  pow(2, 62) ;
       
        $p1 =  (int) $p % 1000  ;
        $p = $p  - $p1;
        $p2 = (int) floor($p / 1000) ;
 
        $p1 *= 2;
        $p2 *= 2;
      
         if ($p1 > 1000) {
             $p2++;
             $p1 = $p1 - 1000;
         }
        
        $p1 = $p1 % 1000;
        
         return number_format($p2, 0, '', '').number_format($p1, 0, '', '');  
    }
}    

function total(): string
{
        $p =  pow(2, 62) ;
       
        $p1 =  (int) $p % 1000  ;
        $p = $p  - $p1;
        $p2 = (int) floor($p / 1000) ;
 
        $p1 *= 4;
        $p2 *= 4;
        $p1--; 
      var_dump($p1);
         if ($p1 > 1000) {
             $p2 = $p2 + (int) floor($p1 / 1000);
             $p1 = (int) $p1 %1000;
         }
        
        $p1 = $p1 % 1000;
        
         return number_format($p2, 0, '', '').number_format($p1, 0, '', ''); 
}
