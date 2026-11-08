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

function saddlePoints(array $matrix): array
{
    if ($matrix == [[]]) {
        return [];
    }
    $posx = 0;
    $posy = 0;
    $y = 0;
    $all = [];    
    foreach ($matrix AS $record) {
        $best = max($record);
       
        $posxAll = getX($record, $best);
        foreach ($posxAll AS $posx) { 
            if (checkposX($matrix, $best, $posx, $y)) {
                 $all[] = [ "row" => $y + 1, "column" => $posx + 1];
            }
        }
        $y++;
    }
   
    return $all;
}
 


function checkposX($matrix, $best, $posx, $y) {
 
   $res = true;
   
  for ($i = 0; $i < count($matrix); $i++) {
     
      if ($matrix[$i][$posx] < $best && $i != $y) {
          $res = false;
     
          break;
      }
  }
    return $res;
}

function getX($record, $m) {
    $x = - 1;
    $res = [];
    for ($i = 0; $i < count($record); $i++) {
        if ($m == $record[$i])
            $res[] = $i;
    }
    return $res;
}
