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

function calculate(string $input): int
{
    $input = str_replace("What is ", "", $input);
    $input = trim(str_replace("?", "", $input));
       $input = trim(str_replace(" by", "", $input));
    $part = explode(" ", $input);
    if (count($part) == 1) {
        return (int) $part[0];
    }

    if (!is_numeric($part[0]) || !is_numeric($part[2])) {
        throw new InvalidArgumentException();
    }
    
    if (count($part) >= 3) {
        $first = array_shift($part);
        $res = go_calc($first, $part);
        var_dump($res);
        return (int) $res;
    }
    
}

 function go_calc($first, $part) {
     if ($part == []) {
         return $first;
     }
          switch ($part[0]) {
            case "plus":
               $first = (int) $first + (int) $part[1];
            break;
             case "minus":
               $first = (int) $first - (int) $part[1];
            break;
              case "divided":
               $first = (int) $first / (int) $part[1];
            break;
               case "multiplied":
               $first = (int) $first * (int) $part[1];
            break;   
              default:
              throw new InvalidArgumentException();
        }   
        array_shift($part);
        array_shift($part);
       return go_calc($first, $part);
     
 }
