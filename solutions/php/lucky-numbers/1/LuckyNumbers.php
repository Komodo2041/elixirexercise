<?php

class LuckyNumbers
{
    public function sumUp(array $digitsOfNumber1, array $digitsOfNumber2): int
    {
         $one = (int) implode("", $digitsOfNumber1);
        $two = (int) implode("", $digitsOfNumber2);
        return $one + $two;
    }

    public function isPalindrome(int $number): bool
    {
        $check = (string) $number;
        $max = strlen($check) - 1;
        $res = true;
        for ($i = 0; $i < ceil($max / 2); $i++) {
            if ($check[$i] != $check[$max - $i]) {
                $res = false;
            }
        }
        return $res;
    }

    public function validate(string $input): string
    {
        if ($input == "") {
            return "Required field";
        }
        $val = (int) $input;
        if ($val <= 0) {
            return "Must be a whole number larger than 0";
        }
        return "";
    }
}
