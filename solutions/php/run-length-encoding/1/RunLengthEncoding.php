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

function encode(string $input): string
{
     $res = "";
      $part = str_split($input);
      $last = "";
     $d  = 0;
      for ($i = 0; $i <= count($part); $i++) {
         if ($last != $part[$i]) {
             
             if ($d >= 2) {
                 $res .= (string) $d.$last;
             } else {
                 $res .= $last;
             }
             $d = 1;
              $last = $part[$i];
         }   else {
             $d++;
         }  
      }   
     return $res; 
}

function decode(string $input): string
{
     $res = "";
     $part = str_split($input);
     $stere = 0;
     for ($i = 0; $i < count($part); $i++) {
         if (is_numeric($part[$i])) {
              $nr = (int) $part[$i];
              if (is_numeric($part[$i + 1])) {
                  $nr = $nr * 10 + (int) $part[$i + 1];
                  $i++;
              }          
              for ($j = 0; $j < $nr; $j++) {
                   $res .= $part[$i + 1];
              }
              $i++;
         } else {
             $res .= $part[$i];
         }
         
     }
 
     return $res;
}
