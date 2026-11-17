<?php
declare(strict_types=1);
class ZebraPuzzle
{
    private array $colors;
    private array $nationalities;
    private array $pets;
    private array $drinks;
    private array $cigarettes;
    public function __construct()
    {
        $this->solve();
    }
    
    public function waterDrinker(): string
    {
        return $this->nationalities[array_search('water', $this->drinks, true)];
    }
    public function zebraOwner(): string
    {
        return $this->nationalities[array_search('zebra', $this->pets, true)];
    }
    private function solve(): void
    {
        foreach ($this->getColors() as $colors) {
            $this->colors = $colors;
            foreach ($this->getNationalities() as $nationalities) {
                $this->nationalities = $nationalities;
                foreach ($this->getPets() as $pets) {
                    $this->pets = $pets;
                    foreach ($this->getDrinks() as $drinks) {
                        $this->drinks = $drinks;
                        foreach ($this->getCigarettes() as $cigarettes) {
                            $this->cigarettes = $cigarettes;
                            return;
                        }
                    }
                }
            }
        }
        throw new Exception("No solution found");
    }
    private function getColors(): array
    {
        // 'blue' is excluded because of #10 and #15, it's always the second one
        return $this->permute(['red', 'green', 'ivory', 'yellow'], 'blue', 1, fn (array $perm): bool =>
            $perm[0] !== 'green' && $perm[0] !== 'ivory' // # green and ivory can't be the first because of #6, #10, and #15
            && $perm[4] !== 'ivory' && array_search('green', $perm) === array_search('ivory', $perm) + 1 // #6
        );
    }
    private function getNationalities(): array
    {
        // 'Norwegian' is excluded because of #10, it's always the first one
        return $this->permute(['Englishman', 'Spaniard', 'Ukrainian', 'Japanese'], 'Norwegian', 0, fn (array $perm): bool =>
            array_search('Englishman', $perm) === array_search('red', $this->colors) // #2
        );
    }
    private function getPets(): array
    {
        return $this->permute(['dog', 'snails', 'fox', 'horse', 'zebra'], null, null, fn (array $perm): bool =>
            array_search('dog', $perm) === array_search('Spaniard', $this->nationalities) // #3
        );
    }
    private function getDrinks(): array
    {
        // 'milk' is excluded because of #9, it's always the middle one
        return $this->permute(['coffee', 'tea', 'orange juice', 'water'], 'milk', 2, fn (array $perm): bool =>
            array_search('coffee', $perm) === array_search('green', $this->colors) // #4
            && array_search('tea', $perm) === array_search('Ukrainian', $this->nationalities) // #5
        );
    }
    private function getCigarettes(): array
    {
        return $this->permute(['Old Gold', 'Kools', 'Chesterfields', 'Lucky Strike', 'Parliaments'], null, null, fn (array $perm): bool =>
            array_search('Old Gold', $perm) === array_search('snails', $this->pets) // #7
                && array_search('Kools', $perm) === array_search('yellow', $this->colors) // #8
                && (abs(array_search('Chesterfields', $perm) - array_search('fox', $this->pets)) === 1) // #11
                && (abs(array_search('Kools', $perm) - array_search('horse', $this->pets)) === 1) // #12
                && array_search('Lucky Strike', $perm) === array_search('orange juice', $this->drinks) // #13
                && array_search('Parliaments', $perm) === array_search('Japanese', $this->nationalities) // #14
        );
    }
    private function permute(array $vals, ?string $insertVal = null, ?int $insertIndex = null, ?callable $filter = null): array
    {
        $perms = [];
        $generate = function (array $items, int $n, array &$result, array $prefix = []) use (&$generate): void {
            if ($n === 0) {
                $result[] = $prefix;
                return;
            }
            for ($i = 0; $i < count($items); $i++) {
                $newPrefix = $prefix;
                $newPrefix[] = $items[$i];
                $newItems = $items;
                array_splice($newItems, $i, 1);
                $generate($newItems, $n - 1, $result, $newPrefix);
            }
        };
        $generate($vals, count($vals), $perms);
        if ($insertVal !== null) {
            foreach ($perms as &$perm) {
                array_splice($perm, $insertIndex, 0, $insertVal);
            }
        }
        if ($filter) $perms = array_filter($perms, $filter);
        return $perms;
    }
}
