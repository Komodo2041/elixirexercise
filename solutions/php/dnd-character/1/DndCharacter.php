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

class DndCharacter
{

    public $strength = 0;
    public $dexterity = 0;
    public $constitution = 0;
    public $intelligence = 0;
    public $wisdom = 0;
    public $charisma = 0;
    public $hitpoints = 10;
    
    public function __construct()
    {
        $this->strength = $this->getVal();
        $this->dexterity = $this->getVal();
        $this->constitution = $this->getVal();
        $this->intelligence = $this->getVal();
        $this->wisdom = $this->getVal();
        $this->charisma = $this->getVal();
        $this->hitpoints = 10 + DndCharacter::modifier($this->constitution);
        
    }

    public static function generate() {
        return new DndCharacter();
    }

    public static function modifier($x) {
        $x = floor(( $x  - 10) / 2);
        return $x;
    }

    public static function ability() {
        $res = [];
        for ($i = 0; $i < 4; $i++) {
            $res[] = rand(1,6);
        }
        rsort($res);
        $sum = $res[0] + $res[1] + $res[2];
        return $sum;
    }

    public function getVal() {
        $res = [];
        for ($i = 0; $i < 4; $i++) {
            $res[] = rand(1,6);
        }
        rsort($res);
        $sum = $res[0] + $res[1] + $res[2];
        return $sum;
    }

    // Add methods as expected by the tests
}
