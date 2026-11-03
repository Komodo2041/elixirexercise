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

class Triangle
{

    public $a;
    public $b;
    public $c;
    public $check;
    
    public function __construct(int $a, int $b, int $c)
    {
        $this->a = $a;
        $this->b = $b;
        $this->c = $c;

        $this->check = true;
        if ($a + $b <= $c) {
            $this->check = false;
        }
        if ($b + $c <= $a) {
            $this->check = false;
        }     
        if ($a + $c <= $b) {
            $this->check = false;
        }         
    }

    public function isEquilateral(): bool
    {
        if (!$this->check) {
            return false;
        }
        if ($this->a == 0) {
            return false;
        }
        if ($this->a == $this->b && $this->b == $this->c) {
            return true;
        } else {
            return false;
        }
    }

    public function isIsosceles(): bool
    {
        if (!$this->check) {
            return false;
        }        
        $res = false;
        if ($this->a == $this->b) {
            $res = true;
        }
        if ($this->c == $this->b) {
            $res = true;
        }
        if ($this->c == $this->a) {
            $res = true;
        }     
        return $res;
    }

    public function isScalene(): bool
    {
         if (!$this->check) {
            return false;
        }     
        if ($this->a != $this->b && $this->c != $this->b && $this->c != $this->a) {
            return true;
        } else {
            return false;
        }
    }
}
