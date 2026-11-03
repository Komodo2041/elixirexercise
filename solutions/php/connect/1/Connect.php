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

function winner(array $lines): ?string
{
    $table = [];
    $max = count($lines) - 1;
    foreach ($lines AS $record) {
        $record = trim($record);
        $line = explode(" ", $record);
        $table[] = $line;
    }
    
    $isblack = checkTrace($table, $max, "X", 0 );
    if ($isblack) {
        return "black";
    }
    $iswhite = checkTrace($table, $max, "O", 0 );
    if ($iswhite) {
        return "white";
    }
     $isblack = checkTrace($table, $max, "X", 1 );
    if ($isblack) {
        return "black";
    }
    $iswhite = checkTrace($table, $max, "O", 1);
    if ($iswhite) {
        return "white";
    }   
  
    return "";
}

function checkTrace($table, $max, $ch, $type ) {

    if ($type == 0) {
        for ($i = 0; $i <= count($table[0]); $i++) {
            if ($table[0][$i] == $ch) {
                $used = [];
                $used[0][$i] = 1;
                $res = gotrace($table, $max, $ch, 0, $i, $used, $type);
                if ($res) {
                    return true;
                }
            }
        }
    }
    if ($type == 1) {
        $max = count($table[0]) - 1;
        for ($i = 0; $i <= count($table); $i++) {
            if ($table[$i][0] == $ch) {
                $used = [];
                $used[$i][0] = 1;
                $res = gotrace($table, $max, $ch, $i, 0, $used, $type);
                if ($res) {
                    return true;
                }
            }
        }
    }    
    return false;
}

function gotrace($table, $max, $ch, $y, $x, $used, $type) {
 
    if ($type == 0 && $y == $max) {
     
        return true;
    }
    if ($type == 1 && $x == $max) {
     
        return true;
    }
 
    $traces = [];
    if ($y - 1 >= 0 && $x + 1 < count($table[0]) && !isset($used[$y-1][$x+1]) && $table[$y-1][$x+1]== $ch) {
        $used[$y-1][$x + 1] = 1;  
         $traces[] = gotrace($table, $max, $ch, $y - 1, $x+1, $used, $type);
 
    }
    if ($y + 1 < count($table) && $x - 1 >= 0 && !isset($used[$y +1][$x-1]) && $table[$y+1][$x-1]== $ch) {
        $used[$y+1][$x-1] = 1;
         $traces[] =  gotrace($table, $max, $ch, $y + 1, $x - 1, $used, $type);
       
    } 
    
    
    if ($y - 1 >= 0 && !isset($used[$y-1][$x]) && $table[$y-1][$x]== $ch) {
        $used[$y-1][$x] = 1;
        $traces[] =   gotrace($table, $max, $ch, $y - 1, $x, $used, $type);
          
    }
    if ($y + 1 < count($table) && !isset($used[$y+1][$x]) && $table[$y+1][$x]== $ch) {
        $used[$y+1][$x] = 1;
        $traces[] =   gotrace($table, $max, $ch, $y + 1, $x, $used, $type);
          
    }
    if ($x - 1 >= 0 && !isset($used[$y][$x - 1]) && $table[$y][$x - 1]== $ch) {
        $used[$y][$x - 1] = 1;
       $traces[] =   gotrace($table, $max, $ch, $y, $x - 1, $used, $type);
         
    }
    if ($x + 1 < count($table[0]) && !isset($used[$y][$x + 1]) && $table[$y][$x + 1]== $ch) {
        $used[$y][$x + 1] = 1;
        $traces[] =  gotrace($table, $max, $ch, $y, $x + 1, $used, $type);
          
    }    
 
     if (in_array(true, $traces)) {
         return true;
     }

    
    return false;
}
