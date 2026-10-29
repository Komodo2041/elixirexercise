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

class Yacht
{
    public function score(array $rolls, string $category): int
    {
         switch ($category) {
             case "ones":
             return $this->calcn($rolls, 1);
             break;
             case "twos":
             return $this->calcn($rolls, 2);
             break;
              case "threes":
             return $this->calcn($rolls, 3);
             break; 
               case "fours":
             return $this->calcn($rolls, 4);
             break; 
                 case "fives":
             return $this->calcn($rolls, 5);
             break;  
                   case "sixes":
             return $this->calcn($rolls, 6);
             break;         
                     case "little straight":
             sort($rolls);
             if ($rolls == [1,2,3,4,5]) {
                 return 30;
             } else {
                 return 0;
             }
             break;   
                      case "big straight":
             sort($rolls);
             if ($rolls == [2,3,4,5,6]) {
                 return 30;
             } else {
                 return 0;
             }
             break;    
 case "full house":
             sort($rolls);
             if ($rolls[0] == $rolls[4]) {
                 return 0;
             }
             if ($rolls[0] == $rolls[2] && $rolls[3] == $rolls[4]) {
                 return array_sum($rolls);
             }
             if ($rolls[0] == $rolls[1] && $rolls[2] == $rolls[4]) {
                return array_sum($rolls);
             }
             return 0;
             break;
 case "four of a kind":
             sort($rolls);
             if ($rolls[0] == $rolls[3]) {
                 return 4* $rolls[0];
             }
             if ($rolls[1] == $rolls[4]) {
                 return 4* $rolls[1];
             }
             return 0;
             break;
             
             case "yacht":
             sort($rolls);
             if ($rolls[0] == $rolls[4]) {
                 return 50;
             } else {
                 return 0;
             }
             break;
             
             default:
             return  array_sum($rolls);
             break;
         }
    }

    public function calcn($rolls, $n) {
        $res = 0;
        foreach ($rolls AS $r) {
            if ($r == $n) {
                $res++;
            }
        }
        return $n * $res;
    }
}
