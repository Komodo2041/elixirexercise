<?php

class PizzaPi
{
    public function calculateDoughRequirement($x, $y)
    {
        return $x * (($y * 20) + 200);
    }

    public function calculateSauceRequirement($p, $s)
    {
         return $p / ($s / 125);
    }

    public function calculateCheeseCubeCoverage($x, $y , $z)
    {
        $x = pow($x, 3);
         return floor( $x / (3.14 * $y * $z));
    }

    public function calculateLeftOverSlices($p, $l)
    {
        return ($p * 8) % $l;
    }
}
