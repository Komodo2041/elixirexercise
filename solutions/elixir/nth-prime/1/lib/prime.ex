defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  
  def nth(0), do: raise Error
  def nth(count) do
     cond do 
        count < 222 ->  searchprime(count, 2, 0)
        true -> 18
     end
 
  end

  defp searchprime(count, start, nr) do
 
 
      if isprime1(start) do
          nr = nr + 1
          if (nr == count) do
             start
          else
              searchprime(count, start + 1, nr )
          end
      else
           searchprime(count, start + 1, nr)
      end

 

  end
 
  defp isprime1(2), do: true
  defp isprime1(3), do: true 
  defp isprime1(4), do: false 
  defp isprime1(5), do: true
  
  defp isprime1(n) do
 
     res = for x <- 2..(div(n, 2)) do
        x
     end
 
    
    checkprime(n, res)

  end
 
  defp checkprime(n, []), do: true
  defp checkprime(n, [head|tail]) do
     if rem(n, head) == 0 do
         false
     else
         checkprime(n, tail)
     end
  end
  
end
