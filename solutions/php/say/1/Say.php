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

function say(int $number, $option = 0): string
{
  
    if ($number < 0) {
        throw new InvalidArgumentException('Input out of range');
    }
    if ($option == 1 && $number == 0) {
        return "";
    }
    
    if ($number < 20) {
        return number($number);
    } elseif ($number < 100) {
        return trim(number2(floor($number / 10)). "".number($number%10, false));
    } elseif ($number < 1000) {
        return trim(number(floor($number/100))." hundred ".say($number%100, 1));
    } elseif ($number < 1000000) {
        return trim(say((int) floor($number/1000))." thousand ".say($number%1000, 1));
    } elseif ($number < 1000000000) {
        return trim(say( (int) floor($number/1000000))." million ".say($number%1000000, 1));
    } elseif ($number < 1000000000000) {
        return trim(say((int) floor($number/1000000000))." billion ".say($number%1000000000, 1));
    } else {
         throw new InvalidArgumentException('Input out of range');
    }
    
}

function number2($n) {
    switch ($n) {
        case 2:
        return "twenty";
        break;
        case 3:
        return "thirty";
        break;
        case 4:
        return "forty";
        break;
          case 5:
        return "fifty";
        break;
        case 6:
        return "sixty";
        break;
        case 7:
        return "seventy";
        break;     
        case 8:
        return "eighty";
        break;
        case 9:
        return "ninety";
        break;        
    }
}

function number($n, $x = true) {
    $prefix = "";
    if (!$x) {
        $prefix = "-";
    }
    switch ($n) {
        case 0:
        if ($x) {
        return "zero"; 
        } else {
            return "";
        }
        break;
        case 1:
        return $prefix."one";
        break;
        case 2:
        return $prefix."two";
        break;
        case 3:
        return $prefix."three";
        break;
        case 4:
        return $prefix."four";
        break;
        case 5:
        return $prefix."five";
        break;
        case 6:
        return $prefix."six";
        break;
        case 7:
        return $prefix."seven";
        break;
        case 8:
        return $prefix."eight";
        break;
        case 9:
        return $prefix."nine";
        break;
        case 10:
        return $prefix."ten";
        break;
        case 11:
        return $prefix."eleven";
        break;   
         case 12:
        return $prefix."twelve";
        break;    
          case 13:
        return $prefix."threeteen";
        break;  
            case 14:
        return $prefix."fourteen";
        break;  
            case 15:
        return $prefix."fiveteen";
        break;  
             case 16:
        return $prefix."sixteen";
        break; 
             case 17:
        return $prefix."eighteen";
        break; 
              case 18:
        return $prefix."eighteen";
        break; 
             case 19:
        return $prefix."nineteen";
        break;        
    }
}

