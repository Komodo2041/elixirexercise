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

function meetup_day(int $year, int $month, string $which, string $weekday): DateTimeImmutable
{
     $data = new DateTime($year."-".$month."-01");
     $nday = (int) $data->format('N');
     $nday2 = getN($weekday);
     if ($which == "teenth") {
         $data = new DateTime($year."-".$month."-13");
         $nday = (int) $data->format('N');
                
          $diffN = 13 + diffN($nday2, $nday);
        return new DateTimeImmutable($year."-".$month."-".$diffN);
     } else {
        $first =  1 + diffN($nday2, $nday);
        if ($which == "first") {
             return new DateTimeImmutable($year."-".$month."-".$first);
        } elseif ($which == "second") {
            return new DateTimeImmutable($year."-".$month."-".($first + 7));
        } elseif ($which == "third") {
            return new DateTimeImmutable($year."-".$month."-".($first + 14));
        } elseif ($which == "fourth") {
            return new DateTimeImmutable($year."-".$month."-".($first + 21));
        } elseif ($which == "last") {
              $dt = DateTimeImmutable::createFromFormat('!Y-m-d' . $format, $year."-".$month."-".($first + 28) );
            $bledy = DateTimeImmutable::getLastErrors();
 
              if ($dt && !$bledy) {
                   return new DateTimeImmutable($year."-".$month."-".($first + 28));
              } else {
                  return new DateTimeImmutable($year."-".$month."-".($first + 21));
              }
        }
     }
}

function diffN($x, $y) {
    $diff = $x - $y;
    if ($diff < 0) {
        $diff += 7;
    }
    return $diff;
}

function getN($day) {
    $res = 1;
    switch ($day) {
        case "Monday":
           $res = 1;
        break;
         case "Tuesday":
           $res = 2;
        break;
         case "Wednesday":
           $res = 3;
        break; 
         case "Thursday":
           $res = 4;
        break;  
         case "Friday":
           $res = 5;
        break;  
         case "Saturday":
           $res = 6;
        break;  
         case "Sunday":
           $res = 7;
        break;         
    }
    return $res;
}


