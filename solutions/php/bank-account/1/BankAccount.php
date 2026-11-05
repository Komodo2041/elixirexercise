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

class BankAccount
{

    public $balance = 0;
    public $open = 0;
    
    public function open()
    {
        if ($this->open) {
            throw new Exception('account already open');
        } else {
            
   
        $this->balance = 0;
        $this->open = 1;
                  }
    }

    public function close()
    {
        if ($this->open) {
         $this->open = 0;
        } else {
            throw new Exception('account not open');
        }  
    }

    public function balance(): int
    {
        if ($this->open) {
        return $this->balance;
        } else {
            throw new Exception('account not open');
        }
    }

    public function deposit(int $amt)
    {

          if ($amt < 0) {
             throw new InvalidArgumentException('amount must be greater than 0');
         }       
        
           if ($this->open) {
        $this->balance += $amt;
           } else {
            throw new Exception('account not open');
        }
    }

    public function withdraw(int $amt)
    {

         if ($amt < 0) {
             throw new InvalidArgumentException('amount must be greater than 0');
         }
        
         if ($this->open) {
             if ($amt > $this->balance) {
                throw new InvalidArgumentException('amount must be less than balance');
             } else {
                   $this->balance -= $amt;
             }
       
         } else {
            throw new Exception('account not open');
        }
    }
}
