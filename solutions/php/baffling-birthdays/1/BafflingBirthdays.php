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

class BafflingBirthdays
{
    public function sharedBirthday(array $birthdates): bool
    {
        $res = false;
        $new = [];
        for ($i = 0; $i < count($birthdates); $i++) {
            $part = explode("-", $birthdates[$i]);
            $new[] = $part[1]."-".$part[2];
        }
        $birthdates = $new;
        for ($i = 0; $i < count($birthdates); $i++) {
            for ($j = $i + 1;  $j < count($birthdates); $j++ ) {
                if ($birthdates[$i] == $birthdates[$j]) {
                      $res = true;
                    break;
                }
            }
        }
        return $res;
    }

    public function randomBirthdates($generate = 0) 
    {
        $res = [];
       for ($i = 0; $i < $generate; $i++) {
           $randY = rand(2025, 2027);
           $randM = rand(1, 12);
           $randD = rand(1, 31);
           if (checkdate($randM, $randD,  $randY)) {
               $res[] = $randY."-".$this->checko($randM)."-".$this->checko($randD);
           } else {
               $i--;
           }
       }
        return $res;
    }

    public function checko($x) {
        if ($x < 10) {
            return "0".$x;
        }
        return $x;
    }

    public function estimatedProbabilityOfSharedBirthday(int $peopleCount): float
    {
        if ($peopleCount <= 1) {
            return 0.0;
        }
    
        if ($peopleCount > 365) {
            return 1.0;
        }
    
        $probDifferent = 1.0;
    
        for ($i = 0; $i < $peopleCount; $i++) {
            $probDifferent *= (365 - $i) / 365;
        }
    
        return (1 - $probDifferent) * 100;
    }
}
