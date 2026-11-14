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

class SpiralMatrix
{
    public function draw(int $n): array
    {
        $table = [];
        for ($i = 0; $i < $n; $i++) {
            for ($j = 0; $j < $n; $j++) {
                $table[$i][$j] = 0;
            }
        }

        $max = $n * $n;
        $start = [0, 0];
        $value = 1;
        $direct = 1;
        for ($x = 0; $x < $max; $x++) {
           $table[$start[0]][$start[1]] = $value;
           $value++;
           $direct = $this->getDirect($start, $table, $direct);  
           $start = $this->nextPos($start, $direct); 
        }
        var_dump($table);
        return $table;
    }

    public function nextPos($start, $direct) {
        switch ($direct) {
            case 2:
            $start = [$start[0] + 1, $start[1]];
            break;
            case 1:
            $start = [$start[0], $start[1] + 1];
            break;
            case 4:
            $start = [$start[0] - 1, $start[1]];
            break;
            case 3:
            $start = [$start[0], $start[1] - 1];
            break;            
        }
        return $start;
    }

    public function getDirect($pos, $table, $direct) {
        $res = $direct;
      
        switch ($direct) {
            case 2:
               if (!isset($table[$pos[0] + 1][$pos[1]]) || $table[$pos[0] + 1][$pos[1]] != 0 ) {
                   $res = 3;
                    
               }
            break;
            case 1:
               if (!isset($table[$pos[0]][$pos[1] + 1]) || $table[$pos[0]][$pos[1] + 1] != 0 ) {
                   $res = 2;
               }            
            break;
            case 4:
                if (!isset($table[$pos[0] - 1][$pos[1]]) || $table[$pos[0] - 1][$pos[1]] != 0 ) {
                   $res = 1;
               }           
            break;
            case 3:
                if (!isset($table[$pos[0]][$pos[1] - 1]) || $table[$pos[0]][$pos[1] - 1] != 0 ) {
                   $res = 4;
               }             
            break;           
        }
        return $res;
    }
}
