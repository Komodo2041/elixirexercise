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

class SwiftScheduling
{

    public $mt = null;
 
    public $mkt = null;
    
    public function __construct(DateTime $meetingStart)
    {
         $this->mt = $meetingStart;
          $data = $meetingStart->format('Y-m-d');
        $pt = explode("-", $data);
          $data = $meetingStart->format('H:i:s');
        $td = explode(":", $data);
        $this->mkt = mktime((int)$td[0], (int)$td[1], (int)$td[2], (int)$pt[1], (int)$pt[2], (int)$pt[0]);
    }

    public function deliveryDate(string $description): DateTime
    {
        $date = $this->mt;
        if (strpos($description, "M")) {
            $pom = (int) str_replace("M", "", $description);
            $td = (int) $date->format("m");
           
            if ($pom <= $td) { 
                  $res =  date("Y-m-d H:i:s", $this->mkt +  24*3600*30 * 12); 
                 $res =  new DateTime($res);
                 $res = $res->format("Y-".$pom."-01 08:00:00"); 
                            
            } else { 
                $res = $date->format("Y-".$pom."-01 08:00:00"); 
            }
            $date =  new DateTime($res); 
             $td = $date->format("N");
            $diff = "01";
            if ($td == 6 || $td == 7) {
                if ($td == 6) {
                      $diff = "03";
                } else {
                    $diff = "02";
                }
                
            }
               $res = $date->format("Y-".$pom."-".$diff." 08:00:00"); 
            return new DateTime($res);
 
        }
 
        if (strpos($description, "Q") === 0) {
            $pom = (int) str_replace("Q", "", $description);
            $td = (int) $date->format("m");
            $pom *= 3; 
            if ($pom < $td) { 
                 $res =  date("Y-m-d H:i:s", $this->mkt +  24*3600*30 * 12); 
                 $res =  new DateTime($res);
                 $res = $res->format("Y-".$pom."-01 08:00:00");  
            } else { 
                $res = $date->format("Y-".$pom."-01 08:00:00"); 
            }

            $date =  new DateTime($res); 
            $td =  $date->format("t");
            $res = $date->format("Y-m-".$td." H:i:s");
            $date =  new DateTime($res);
            $td2 = $date->format("N");
            if ($td2 == 6 || $td2 == 7) {
                if ($td2 == 6) {
                    $td -= 1;
                } else {
                    $td -= 2;
                }
                 $res = $date->format("Y-m-".$td." H:i:s");
                $date =  new DateTime($res);
            }            
            return $date;
        }
            
        switch ($description) {
            case "NOW":
                $res =  date("Y-m-d H:i:s", $this->mkt + 7200); 
                return new DateTime($res);
            break;
            case "ASAP": 
                $td = $date->format("H");
                if ($td < 13) {
                    $r = $date->format("Y-m-d 17:00:00");
                    return  new DateTime($r);
                } else {  
                    $res =  date("Y-m-d H:i:s", $this->mkt + 24 * 3600);                     
                    $res =  new DateTime($res);
                    $res = $res->format("Y-m-d 13:00:00"); 
                    return  new DateTime($res);                   
                } 
            break; 
              case "EOW":
                  $td = $date->format("N");
                  if ($td < 4) {
                      $diff = 5 - $td;
                  } else {
                       $diff = 7 - $td;
                  }
                  $res =  date("Y-m-d H:i:s", $this->mkt + $diff * 24 * 3600);
                  $res =  new DateTime($res);

                   if ($td < 4) {
                       $res = $res->format("Y-m-d 17:00:00"); 
                   } else {
                        $res = $res->format("Y-m-d 20:00:00"); 
                   }
                    
                    return  new DateTime($res);              
            
            break;            
        }
    }
}
