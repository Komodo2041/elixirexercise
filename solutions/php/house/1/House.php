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

class House
{
    public function verse(int $verseNumber): array
    {
        if ($verseNumber == 1) {
            return ["This is the house that Jack built."];
        }
        $verses = "This is the horse and the hound and the horn
that belonged to the farmer sowing his corn
that kept the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.";
        $verses2 = "This is the horse and the hound and the horn
This is the farmer sowing his corn
This is the rooster that crowed in the morn
This is the priest all shaven and shorn
This is the man all tattered and torn
This is the maiden all forlorn
This is the cow with the crumpled horn
This is the dog
This is the cat
This is the rat
This is the malt
that lay in the house that Jack built.";        
        $verses = explode("\n", $verses);
           $verses2 = explode("\n", $verses2);
        $c = count($verses);
        $res = [];
        $first = false;
        for ($i = $c - $verseNumber; $i < $c; $i++ ) {
            if (!$first) {
                 $res[] = $verses2[$i];
                $first = true;
            } else {
                 $res[] = $verses[$i];
            }
            
        }
        return $res;
    }

    public function verses(int $start, int $end): array
    {
        $res = [];
        for ($i = $start; $i<= $end; $i++) {
            $res = array_merge($res, $this->verse($i));
            if ($i != $end) {
                $res[] = "";
            }
        }
        return $res;
    }
}
