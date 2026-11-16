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

class SimpleCipher
{
    public $key = "";
    
    public function __construct(string $key = null)
    {
        if (!$key) {
            for ( $i = 0; $i <26; $i++) {
                $this->key .= chr(ord('a') + rand(0, 25));
            }
        } else {
            $this->key = $key;
        }
     
    }

    public function encode(string $plainText): string
    {
        $str = str_split($plainText);
        $key = str_split($this->key);
        while (count($str) > count($key)) {
            $key = array_merge($key, $key);
        }      
        $val = ord('a');
        $res = "";
        for ($i = 0; $i < count($str); $i++) {
            
            $nval =  ord($key[$i]) - $val +  ord($str[$i]) - $val;
            $nval = $nval % 26;
            $res .= chr(ord('a') + $nval);
        }
 
        return $res;
    }

    public function decode(string $cipherText): string
    {
        $str = str_split($cipherText);
        $key = str_split($this->key);
        while (count($str) > count($key)) {
            $key = array_merge($key, $key);
        }
        $val = ord('a');
        $res = "";
        for ($i = 0; $i < count($str); $i++) {
            var_dump(ord($str[$i]) - $val);
            $nval =  ord($str[$i]) - $val - ( ord($key[$i]) - $val);
            if ($nval < 0) {
                $nval = 26 + $nval;
            }
       
            $res .= chr(ord('a') + $nval);
        }
 
        return $res;

        
    }
}
