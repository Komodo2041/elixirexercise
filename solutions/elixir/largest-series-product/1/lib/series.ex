defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
     table = String.graphemes(number_string) |> Enum.map(fn(el) -> String.to_integer(el) end)
     if length(table) < size || size < 1 do
        raise ArgumentError
     else
       comb = get_comp(table, size)
       Enum.max(comb)     
     end
 
  end

  defp get_comp([], size), do: []
  defp get_comp([head|tail], size) do
       
     if length(tail) >= (size - 1) do 
         res = for x <- 0..(size-2) do
            Enum.at(tail, x)
         end    
        [multi([head] ++ res, 1)] ++ get_comp(tail, size)
     else
        []
     end
  end

  defp multi([], acc), do: acc
  defp multi([head|tail], acc) do
     m = acc * head 
     multi(tail, m)
  end
  
end
