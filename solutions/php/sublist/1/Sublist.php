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

class Sublist
{
    public function compare(array $listOne, array $listTwo): string
    {
        var_dump( array_diff($listTwo, $listOne)  );
         var_dump( array_diff($listOne, $listTwo)  );
        if ($listOne == $listTwo) {
            return "EQUAL";
        }
         if (array_diff($listOne, $listTwo) == [] && array_diff($listTwo, $listOne) == []  ) {
            return "UNEQUAL";           
        }       
        if (array_diff($listOne, $listTwo) == []   ) {
            if ($this->checkordero($listOne, $listTwo)) {
                return "SUBLIST"; 
            } else {
                  return "UNEQUAL"; 
            }                      
        }
         if (array_diff($listTwo, $listOne) == []) {
              
            if ($this->checkordero($listTwo, $listOne)) {
                 return "SUPERLIST"; ; 
            } else {
                  return "UNEQUAL"; 
            }             
        }
        return "UNEQUAL";
    }

    public function checkordero($x, $y) {
        
        $y = array_flip($y);
        $res = [];
        for ($i = 0; $i < count($x); $i++) {
         
            $res[] = $y[$x[$i]];
        }
        if (count($res) == 0) {
            return true;
        }
        $d = max($res) - min($res) - count($x);
      
        if ($d <= -1) {
            return true;
        }
        return false;
    }
}
