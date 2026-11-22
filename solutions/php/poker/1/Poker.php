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

class Poker
{
    /**
     * In PHP 8.4 and newer, you can use to enhance data encapsulation:
     * - Asymmetric Property Visibility
     *   @see https://www.php.net/manual/en/language.oop5.visibility.php#language.oop5.visibility-members-aviz
     * Or:
     * - Property hooks
     *   @see https://www.php.net/manual/en/language.oop5.property-hooks.php
     */

    public array $bestHands = [];

    public $por = ["A" => 14, "K" => 13, "Q" => 12, "J" => 11, "10" => 10, "9" => 9, "8" => 8, "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3, "2" => 2];
    
    public function __construct(array $hands)
    {
        $results = [];
        foreach ($hands AS $cards) {
            $res = ["checked" => $this->calcPoints(explode(",", $cards)), "cards" => $cards];
            $results[] = $res;
        }
  
        usort($results, [$this, 'sorthands']);

        $all = [];
        $all =  [$results[0]["cards"]];
        if (isset($results[1]["cards"])) {
            $por = $this->sorthands($results[0], $results[1]);
            if ($por == 0) {
                $all[] = $results[1]["cards"];
            }
        }
        
        $this->bestHands = $all;
       
    }

    public function sorthands($two, $one) {
 
        $directory = ["isPoker", "isFour", "isFoul", "isColor", "isStrit", "isThree", "isPair" ];
       
        foreach ($directory AS $ster ) { 
  
           if ($one["checked"][$ster][0] == 1 && $two["checked"][$ster][0] == 0 || $one["checked"][$ster][0] == 2 && $two["checked"][$ster][0] == 1 || $one["checked"][$ster][0] == 2 && $two["checked"][$ster][0] == 0) {
               return 1;
           }
           if ($one["checked"][$ster][0] == 0 && $two["checked"][$ster][0] == 1) {
               return -1;
           } 
         
           if ($one["checked"][$ster][0] == 1 && $two["checked"][$ster][0] == 1 || $one["checked"][$ster][0] == 2 && $two["checked"][$ster][0] == 2) {
               
             switch ($ster) {
                 case "isFour":
                    if ( $one["checked"][$ster][1][0] != $two["checked"][$ster][1][0]) {
                    return $one["checked"][$ster][1][0] <=> $two["checked"][$ster][1][0];
                 } else {
                     return $this->checkbest( $one, $two);
                 } 
 
                 break;              
  
                  case "isStrit":
                      return $this->checkbest(  $one, $two);
                 break; 
                  case "isThree":
                    
                 if ( $one["checked"][$ster][1][0] != $two["checked"][$ster][1][0]) {
                    return $one["checked"][$ster][1][0] <=> $two["checked"][$ster][1][0];
                 } else {  
                      return $this->checkbest(  $one, $two);
                 } 
 
                 break;
                  case "isPair":
                     if ($one["checked"][$ster][0] != $two["checked"][$ster][0]) {
                         return $one["checked"][$ster][0] <=> $two["checked"][$ster][0];
                     } else {
                         if ($one["checked"][$ster][1][0] != $two["checked"][$ster][1][0]) {
                             return $one["checked"][$ster][1][0] <=> $two["checked"][$ster][1][0];
                         } else {
                             if ($one["checked"][$ster][1][0] == 2) {
                                  return $one["checked"][$ster][1][1] <=> $two["checked"][$ster][1][1];
                             }
                         }
                     }
                 break;                   
 
             }
           }   
        }
  
        return $this->checkbest($one, $two);
 
    }

    public function checkbest($one, $two) {
                    if ($one["checked"]["best"][0] != $two["checked"]["best"][0]) {   
                        return $one["checked"]["best"][0] <=> $two["checked"]["best"][0];
                    } elseif ($one["checked"]["best"][1] != $two["checked"]["best"][1]) {
                        return $one["checked"]["best"][1] <=> $two["checked"]["best"][1];
                    } elseif ($one["checked"]["best"][2] != $two["checked"]["best"][2]) {
                        return $one["checked"]["best"][2] <=> $two["checked"]["best"][2];
                    } elseif ($one["checked"]["best"][3] != $two["checked"]["best"][3]) {  
                        return $one["checked"]["best"][3] <=> $two["checked"]["best"][3];
                    } elseif ($one["checked"]["best"][4] != $two["checked"]["best"][4]) {
                        return $one["checked"]["best"][4] <=> $two["checked"]["best"][4];
                    }
      
          return 0;
        
    }

    public function calcPoints($cards) {
        $res = [];
        $result = [];
        foreach ($cards AS $card) {
            $check = str_split($card);
            if (count($check) == 2) {
                $result[] = $check;
            } else {
                $result[] = ["10", $check[2]];
            }
        }
        usort($result, [$this, 'sortcard']);
        $res['isPair'] = $this->checkPair($result); 
          $res['best'] = [$this->por[$result[4][0]], $this->por[$result[3][0]], $this->por[$result[2][0]], $this->por[$result[1][0]], $this->por[$result[0][0]]];  
        $res['isThree'] = $this->checkThree($result); 
       
        [$res['isStrit'], $res['best']] = $this->checkStrit( $result, $res['best']); 
        
        $res['isColor'] = $this->checkColor($result); 
        
        $res['isFoul'] = $this->checkFoul($result);
        
        $res['isFour'] = $this->checkFour($result); 
        $res['isPoker'] = $this->checkPoker($res); 
     
        return $res;
    }

    function sortcard($cardA, $cardB) {
 
        return  $this->por[$cardA[0]] >= $this->por[$cardB[0]];
      
    }

    public function checkPoker($cards) {
         $res = [0, []];
        if ($cards['isStrit'][0] == 1 && $cards['isColor'][0] == 1) {
            $res[0] = 1;
        }
        return $res;
    }
    
    public function checkFoul($cards) {
        $res = [0, []];
        if (($cards[0][0] == $cards[2][0] && $cards[3][0] == $cards[4][0]) || ($cards[0][0] == $cards[1][0] && $cards[2][0] == $cards[4][0]))  {
             $res[0] = 1;
             
        }
        return $res;
    }
    
    public function checkPair($cards) {
        $res = [0, []];
        for ($i = 0; $i < 4; $i++) {
            if ($cards[$i][0] == $cards[$i + 1][0]) {
                $res[0]++;
                $res[1][] = $this->por[$cards[$i][0]];
            }
        }
        rsort($res[1]);
        return $res;
    }

    public function checkThree($cards) {
        $res = [0, []];
        for ($i = 0; $i < 3; $i++) {
            if ($cards[$i][0] == $cards[$i + 2][0]) {
                $res[0] = 1;
                $res[1][] = $this->por[$cards[$i][0]];
            }
        }   
        return $res;
    }    

    public function checkFour($cards) {
        $res = [0, []];
        for ($i = 0; $i < 2; $i++) {
            if ($cards[$i][0] == $cards[$i + 3][0]) {
                $res[0] = 1;
                $res[1][] = $cards[$i];
            }
        } 
        return $res;
    } 

    public function checkStrit($cards, $best) {
        $res = [0, 0];
     
      
   if ($this->por[$cards[0][0]] + 1 == $this->por[$cards[1][0]] && $this->por[$cards[1][0]] + 1 == $this->por[$cards[2][0]] && $this->por[$cards[2][0]] + 1 == $this->por[$cards[3][0]] && $this->por[$cards[3][0]] + 1 == $this->por[$cards[4][0]])   {
            $res = [1, $this->por[$cards[4][0]]];
        } 
         if ($res[0] == 0 ) {
            if ($this->por[$cards[0][0]] + 1 == $this->por[$cards[1][0]] && $this->por[$cards[1][0]] + 1 == $this->por[$cards[2][0]] && $this->por[$cards[2][0]] + 1 == $this->por[$cards[3][0]] && $cards[4][0] == "A" )    {
                $res = [1, $this->por[$cards[3][0]]];
                $best[0] = 0;
            }            
        } 
            
        return [$res, $best];        
    }

    public function checkColor($cards) {
         $res = [0, []];
        if ( $cards[0][1] == $cards[1][1] && $cards[1][1] == $cards[2][1] && $cards[2][1] == $cards[3][1] && $cards[3][1] == $cards[4][1]) {
             $res = [1, $cards[0][1]] ;
        }
        

        return $res;
    }
    
}
