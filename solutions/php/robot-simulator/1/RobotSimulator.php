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

class RobotSimulator
{
    private $pos = [];
    private $direction = "";
    
    /** @param int[] $position */
    public function __construct(array $position, string $direction)
    {
        $this->pos = $position;
        $this->direction = $direction;
    }

    public function instructions(string $instructions): void
    {
        $inst = str_split($instructions);
        for ($i = 0; $i < count($inst); $i++) {
        switch ($inst[$i]) {
                case "R":
                   switch ($this->direction) {
                       case "north";
                          $this->direction = "east";
                       break;
                        case "east";
                          $this->direction = "south";
                       break;   
                         case "south";
                          $this->direction = "west";
                       break;                   
                          case "west";
                          $this->direction = "north";
                       break;                  
                   }
                break;
                case "L":
                   switch ($this->direction) {
                       case "north";
                          $this->direction = "west";
                       break;
                        case "west";
                          $this->direction = "south";
                       break;   
                         case "south";
                          $this->direction = "east";
                       break;                   
                          case "east";
                          $this->direction = "north";
                       break;                  
                   }
                break;
                case "A":
                   switch ($this->direction) {
                       case "north";
                          $this->pos = [$this->pos[0], $this->pos[1] + 1];
                       break;
                        case "west";
                          $this->pos = [$this->pos[0] - 1, $this->pos[1]];
                       break;   
                         case "south";
                          $this->pos = [$this->pos[0], $this->pos[1] - 1];
                       break;                   
                          case "east";
                          $this->pos = [$this->pos[0] + 1, $this->pos[1]];
                       break;                  
                   }            
                break;            
            }
            var_dump($this->pos);
        }
    }

    /** @return int[] */
    public function getPosition(): array
    {
        return $this->pos;
    }

    public function getDirection(): string
    {
         return $this->direction;
    }
}
