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

function vlq_encode(array $input): array
{
  
        
    $reso = [];
        $all = "";
        foreach ($input AS $hex) {
             $res = [];
               $bin = base_convert((string)$hex, 10, 2); 
 
              $all .= $bin; 
           
     
            $i = 0;
            while (strlen($all) > 0) {
                $max = strlen($all) - 7;
                if ($max <= 0) {
                    $max = 0;
                }
                $nr = substr($all, $max, 7);
                $nr = str_pad($nr, 7, "0", STR_PAD_LEFT);
                
                $all = substr($all, 0, $max);
               
                if ($i == 0) { 
                   $nr = "0". $nr;
                }    else {
                     $nr = "1". $nr;
                }
                $i++;
                $bin = base_convert( $nr, 2, 10);
           
                $res[] = $bin;
            }
        
            $res = array_reverse($res);
            if ($res[0] == 128) {
                unset($res[0]);
                $res = array_values($res);
            }
            var_dump($res);
            $reso = array_merge($reso, $res);
        }
        return $reso;
     
}

function vlq_decode(array $input) {

         if (count($input) == 1 && ($input[0] == 128 || $input[0] == 255)) {
             throw new Exception();
         }
      
         $reso = [];
    $res = "";
         foreach ($input AS $hex) {
          
               $bin = base_convert((string)$hex, 10, 2);
               $nr = str_pad($bin, 8, "0", STR_PAD_LEFT);
               $res .= substr($nr, 1, 7);
               if ($nr[0] == "0") {
                  $reso[] = base_convert((string)$res, 2, 10);
                  $res = "";
               }
         }    
    
         return $reso;
    
}

 