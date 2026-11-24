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

/**
 * Note: we expect the total in cents (1$ = 100 cents).
 */
function total(array $items): int
{
     $res = 0;
     
    $calc = array_count_values($items);
    arsort($calc);
    $new = create_calc($calc);
    $pom = $new;
   $used = [2 => 0, 3 => 0, 4 => 0, 5 => 0];
     do {
         $uni = array_unique($pom);
          
         $checkedmore = false;
        
         if (count($uni) >= 5  ) {
              $checkedmore = true;
             $diff = array_slice($uni, 0 , 5);
               $res += 600 * 5;
             $pom = array_diff2($pom, $diff);
             $used[5]++;
         } elseif  (count($uni) >= 4) {
             $diff = array_slice($uni, 0 , 4);
            $pom = array_diff2($pom, $diff);
               $res += 640 * 4;
             $checkedmore = true;
            $used[4]++;
         } elseif  (count($uni) >= 3) {
             $diff = array_slice($uni, 0 , 3);
              $pom = array_diff2($pom, $diff);
             $res += 720 * 3;
             $checkedmore = true;
            $used[3]++;
         } elseif  (count($uni) >= 2) {  
             $diff = array_slice($uni, 0 , 2);
              $pom = array_diff2($pom, $diff);
             $res += 760 * 2;
             $checkedmore = true;
            $used[2]++;
         } else {   
       
             $res += 800 * count($pom);
             $pom = [];
             
         }
     } while ($checkedmore);

    $min = min($used[5], $used[3]);
    $res -= $min * 40;
    
    return $res;
}

function array_diff2($pom, $diff) {
 
    
   foreach ($diff AS $val)  {
       
      for ($i = 0; $i < count($pom); $i++) {
          if ($pom[$i] == $val) {
              unset($pom[$i]);
              $pom = array_values($pom);
              break;
          }
      }     
    }
    var_dump($pom);
    return $pom;
}

function  create_calc($calc) {
    $new = [];
   foreach ($calc AS $key => $value) {
       for ($i = 0; $i < $value; $i++) {
           $new[] = $key;
       }
   }
    return $new;
}
