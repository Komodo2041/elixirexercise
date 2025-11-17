defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
     res = checkfactor(factors, limit)
     res = res |> Enum.uniq() |> Enum.sum()
     res
  end

  defp checkfactor([], limit), do: [] 
  defp checkfactor([head | tail], limit) do
     if (head > 0) do
     getAllBin(head, limit, head) ++ checkfactor(tail, limit)
     else
      checkfactor(tail, limit)
     end
  end

 
  defp getAllBin(head, limit, nr) do
     if  nr >= limit do
         []
     else
         [nr]  ++ getAllBin(head, limit, nr + head )
     end    
  end
  
end
