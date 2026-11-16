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

class ListOps
{
    public function append(array $list1, array $list2): array
    {
        return array_merge($list1, $list2);
    }

    public function concat(array $list1, array ...$listn): array
    {
        $res = $list1;
        foreach ($listn AS $list) {
            $res = array_merge($res, $list);
        }
        return $res;
    }

    /**
     * @param callable(mixed $item): bool $predicate
     */
    public function filter(callable $predicate, array $list): array
    {
    
         $res = array_filter(  $list, $predicate);
        $res = array_values($res);
        return $res;
    }

    public function length(array $list): int
    {
         return count($list);
    }

    /**
     * @param callable(mixed $item): mixed $function
     */
    public function map(callable $function, array $list): array
    {
         return array_map(  $function, $list);
    }

    /**
     * @param callable(mixed $accumulator, mixed $item): mixed $function
     */
    public function foldl(callable $function, array $list, $accumulator)
    {
         return array_reduce($list, $function, $accumulator);
    }

    /**
     * @param callable(mixed $accumulator, mixed $item): mixed $function
     */
    public function foldr(callable $function, array $list, $accumulator)
    {
         $res =  array_reduce(array_reverse($list), $function, $accumulator);
      
        return $res;
    }

    public function reverse(array $list): array
    {
        return array_reverse($list);
    }
}
