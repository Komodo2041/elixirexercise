defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value([], maximum_weight), do: 0        
  def maximum_value(items, maximum_weight) do
     items = Enum.sort(items, fn(a, b) -> (a.value/ a.weight) > (b.value/ b.weight)  end)
 
     res = get_val(items, maximum_weight, 0, 0)
 
     res

     list = for x <- (1..1000) do
        createRandomList(items, maximum_weight, 0, 0)
        end
     IO.inspect(list)
     Enum.max(list)
      
  end

  defp get_val([], mw, uw, res), do: res
  defp get_val([head|tail], mw, uw, res) do
     if (mw >= uw + head.weight) do
        get_val(tail, mw, uw + head.weight, res + head.value)
     else
        get_val(tail, mw, uw, res)
     end
  end

  defp createRandomList([], mw, uw, res), do: res
  defp createRandomList(items, mw, uw, res) do
     r = length(items) - 1
  
     nr = Enum.random(0..r)
  
     head = Enum.at(items, nr)
     tail = List.delete_at(items, nr)
  
      if (mw >= uw + head.weight) do
        createRandomList(tail, mw, uw + head.weight, res + head.value)
     else
        nr = Enum.random(0..4)
        if nr == 4 do
            get_val(tail, mw, uw, res)
        else
            createRandomList(tail, mw, uw, res)
        end
        
     end    
  
  end
  
end
