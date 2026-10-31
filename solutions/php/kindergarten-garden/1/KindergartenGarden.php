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

class KindergartenGarden
{

    private $d = "";
    private $students = ['Alice' => 0, 'Bob' => 1, 'Charlie' => 2, 'David' => 3, 'Eve' => 4, 'Fred' => 5, 'Ginny' => 6, 'Harriet' => 7, 'Ileana' => 8, 'Joseph' => 9, 'Kincaid' => 10, 'Larry' => 11];
    
    public function __construct(string $diagram)
    { 
        $this->d = explode("\n", $diagram);
    }

    public function plants(string $student): array
    {
        $res = [];
        $val = $this->students[$student];
        if (strlen($this->d[0]) < $val * 2  ) {
            throw new Exception();
        }  
        foreach ($this->d AS $d) {
         
            $o = str_split($d);
            $res[] = $this->checkPlants($o[$val * 2 ]); 
            $res[] = $this->checkPlants($o[$val * 2 + 1]); 
          
        }
        
        return $res;
    }

    public function checkPlants($x) {
       
          switch ($x) {
                    case "R":
                    return "radishes";
                    break;
                     case "C":
                     return   "clover";
                    break;
                     case "G":
                   return "grass";
                    break;
                     case "V":
                    return "violets";
                    break;                   
           }   
    }
}
