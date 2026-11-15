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

class Tournament
{
    public function __construct()
    {
         
    }

    public function gn($x) {
        $res = $x;
        $str = strlen($x);
        for ($i = 0; $i < 31 - $str; $i++) {
            $res.= " ";
        }
        return $res;
    }

    public function gn2($x) {
       $res = "";
        $str = strlen((string)$x);
        for ($i = 0; $i < 3 - $str; $i++) {
           $res .= " ";
        }
        $res .= $x;
        return $res;
    }
    
    public function tally($scores = '') {
        $first =  'Team                           | MP |  W |  D |  L |  P';    
        $res = $first;
        if ($scores != "") {
           $table = $this->getTable($scores);   
      
           foreach ($table AS $key => $record) {
               $line = $this->gn($record["NAME"]);
               $line .= "|  ".$record["MP"]." ";
               $line .= "|  ".$record["W"]." ";
               $line .= "|  ".$record["D"]." ";
               $line .= "|  ".$record["L"]." ";
               $line .= "|".$this->gn2($record["P"])."";
               $res .= "\n".$line;
           } 
            //$res .= "\n";
        }
   
        return $res;
    }

    public function getTable($scores) {
        $records = explode("\n", $scores);
        $table = [];
        $ids = 0;
        foreach ($records AS $record) {
            $change = explode(";", $record);
          
            if (!isset($table[$change[0]])) {
                $table[$change[0]] = ["MP"=> 0, "W" => 0, "D" => 0, "L" => 0, "P" => 0, "NAME" => $change[0]];
                
            };
             if (!isset($table[$change[1]])) {
                $table[$change[1]] = ["MP"=> 0, "W" => 0, "D" => 0, "L" => 0, "P" => 0, "NAME" => $change[1]];
            };
            
            if ($change[2] == "win") {
                $table[$change[0]]["MP"]++;
                $table[$change[1]]["MP"]++;
                $table[$change[0]]["W"]++;
                $table[$change[1]]["L"]++;
                $table[$change[0]]["P"] += 3;
            }
            if ($change[2] == "loss") {
                $table[$change[0]]["MP"]++;
                $table[$change[1]]["MP"]++;
                $table[$change[1]]["W"]++;
                $table[$change[0]]["L"]++;
                $table[$change[1]]["P"] += 3;
            }  
            if ($change[2] == "draw") {
                $table[$change[0]]["MP"]++;
                $table[$change[1]]["MP"]++;
                $table[$change[1]]["D"]++;
                $table[$change[0]]["D"]++;
                $table[$change[0]]["P"] += 1;
                $table[$change[1]]["P"] += 1;
            }             
        }
        usort($table, function ($a, $b) { if ($a["P"] == $b["P"]) {return $a["NAME"] > $b["NAME"];} else { return $a["P"] < $b["P"];}});
        return $table;
    }
}
