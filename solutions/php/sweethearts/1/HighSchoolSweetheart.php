<?php

class HighSchoolSweetheart
{
    public function firstLetter(string $name): string
    {
        $name = trim($name);
        return $name[0];
    }

    public function initial(string $name): string
    {
        return strtoupper($this->firstLetter($name)).".";
    }

    public function initials(string $name): string
    {
        $part = explode(" ", $name);
        return $this->initial($part[0])." ".$this->initial($part[1]);
    }

    public function pair(string $sweetheart_a, string $sweetheart_b): string
    {
 $expected = <<<EXPECTED_HEART
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     X. X.  +  Y. Y.     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    EXPECTED_HEART;
        $expected = str_replace("X. X.", $this->initials($sweetheart_a), $expected);
         $expected = str_replace("Y. Y.", $this->initials($sweetheart_b), $expected);
        return $expected;
    }
}
