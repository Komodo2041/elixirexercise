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

class FlowerField
{

    public $garden = [];
     public $sec = [];
    
    public function __construct(array $garden)
    {
        $res = [];
        $this->sec = $garden;
        foreach ($garden AS $g) {
            $res[] = str_split($g);
        }
        $this->garden = $res;
    }

    public function annotate(): array
    {
        if ($this->sec == []) {
            return [];
        } 
        if ($this->sec == [""]) {
            return [""];
        }        
        $res = [];
 
        
        for ($i = 0; $i < count($this->garden); $i++) {
            for ($j = 0; $j < count($this->garden[0]); $j++) {
                if ($this->garden[$i][$j] == "*") {
                    $res[$i][$j] = "*";
                } else {
                    $res[$i][$j] = $this->calcOne($i, $j);
                }
            }
        }
        $res2 = [];
        foreach ($res AS $record) {
            $res2[] = implode("", $record);
        } 
 
        return $res2;
    }

    private function calcOne($x, $y) {
        $res = 0;
        for ($i = $x - 1; $i <= $x + 1; $i++) {
            for ($j = $y - 1; $j <= $y + 1; $j++) {
                if (isset($this->garden[$i][$j]) && $this->garden[$i][$j] == "*") {
                    $res++;
                }
            }
        }
        if ($res == 0) {
            return " ";
        } else {
            return $res;
        }
    }
}
