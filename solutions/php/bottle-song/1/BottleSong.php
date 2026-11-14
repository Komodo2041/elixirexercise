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

class BottleSong
{
    public function verse(int $number): string
    {
        $num = $number;
        $name1 = $this->getName($num);
        $name2 = $this->getName($num - 1);
        $res = [];
        $res[] = $name1." green ".$this->odm($num)." hanging on the wall,";
        $res[] = $res[0];
        $res[] = "And if one green bottle should accidentally fall,";
        $res[] = "There'll be ".strtolower($name2)." green ".$this->odm($num - 1)." hanging on the wall.";
       $res =  implode("\n", $res);
 
        return $res;
    }

    public function odm($x) {
        if ($x == 1) {
            return "bottle";
        }
        return "bottles";
    }

    public function verses(int $start, int $size): string
    {
        $res = [];
        for ($i = $start; $i > $start - $size; $i-- ) {
            $res[] = $this->verse($i);
        }
        return implode("\n\n", $res);
    }

    public function lyrics(): string
    {
        return $this->verses(10, 10);
    }

    public function getName($x) {
        $res = "";
        switch ($x) {
            case 10:
            $res = "Ten";
            break;
            case 9:
            $res = "Nine";
            break;  
             case 8:
            $res = "Eight";
            break;    
             case 7:
            $res = "Seven";
            break;     
              case 6:
            $res = "Six";
            break;   
              case 5:
            $res = "Five";
            break;  
             case 4:
            $res = "Four";
            break;  
             case 3:
            $res = "Three";
            break; 
             case 2:
            $res = "Two";
            break; 
             case 1:
            $res = "One";
            break; 
             case 0:
            $res = "No";
            break;            
        }
        return $res;
    }
}
