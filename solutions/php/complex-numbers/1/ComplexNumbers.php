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

class ComplexNumbers
{
    public $real = 0;
    public $imaginary = 0;
    
    public function __construct($x, $y = 0)
    {
         $this->real = $x;
        $this->imaginary = $y;
    }

    public function add($y ) {
        $newx = $this->real + $y->real;
        $newy = $this->imaginary + $y->imaginary;
        return new ComplexNumbers($newx, $newy);
    }

    public function sub($y ) {
        $newx = $this->real - $y->real;
        $newy = $this->imaginary - $y->imaginary;
        return new ComplexNumbers($newx, $newy);
    }

    public function abs() {
        return sqrt($this->real * $this->real + $this->imaginary * $this->imaginary);
    }

    public function mul($x) {
         $newx = $this->real * $x->real - $this->imaginary * $x->imaginary;
        $newy = $this->imaginary * $x->real + $this->real * $x->imaginary;  
        return new ComplexNumbers($newx, $newy);
    }

    public function mul2($x, $y) {
         $newx = $y->real * $x->real - $y->imaginary * $x->imaginary;
        $newy = $y->imaginary * $x->real + $y->real * $x->imaginary;  
        return new ComplexNumbers($newx, $newy);
    }

    public function conjugate() {
        return new ComplexNumbers($this->real, -1 * $this->imaginary);
    }
    
    public function div($x) {
        $spr  = new ComplexNumbers($x->real, -1 * $x->imaginary);
        $head = $this->mul($spr);
        $bottom = $this->mul2($x, $spr);
          $newx =  $head->real / $bottom->real;
        $newy = $head->imaginary  / $bottom->real;   
        return new ComplexNumbers($newx, $newy);
    }

    public function exp() {
        $pi = $this->imaginary  ;
        $elo = pow(M_E, $this->real);
        $newx = $elo * cos($pi);
         $newy = $elo * sin($pi);  
        return new ComplexNumbers($newx, $newy);       
    }
    
}
