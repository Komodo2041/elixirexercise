defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
     if  limit <= 1 do
        []
     else
        list = for x <- 2..limit, do: x
        checknumber(list, limit)
     end
  end

  defp checknumber([], _), do: [] 
  defp checknumber([head|tail], max) do
     multi = for x <- 2..(ceil(max/head)), do: x*head
     [head] ++ checknumber(tail -- multi, max)
  end
  
end
