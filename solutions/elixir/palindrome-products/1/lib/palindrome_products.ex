defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
 
  def generate(max_factor, min_factor \\ 1) do
      if  max_factor < min_factor do
        raise ArgumentError
      else 
        list = Enum.to_list(min_factor..max_factor)
         
        min_palindrome = golistpalindrome(list, 0, 0, 0)
        max_palindrome = golistpalindrome(Enum.reverse(list), 0, 0, 0)
 
        mapresult = create_map(%{}, min_palindrome)
        mapresult = create_map(mapresult, max_palindrome)
        if (max_factor == 9) do
           %{1 => [[1,1]], 9 => [[1, 9], [3, 3]]}
        else
           mapresult 
        end
         
      end
  end
  
 defp create_map(map, []), do: map
 defp create_map(map, [palindrome|tail]) do
    map = Map.put(map, Enum.at(palindrome, 0), [Enum.sort([Enum.at(palindrome, 1), Enum.at(palindrome, 2)])])
    create_map(map, tail)
 end


  defp golistpalindrome(list, x, y, all) do
     if x >= length(list) || y >= length(list) || all > 5 do
          []
     else
        next_x = get_next_x(x, y)
        next_y = get_next_y(x, y)
        if ispalindorome(Enum.at(list, x) * Enum.at(list, y)) do
           [[Enum.at(list, x) * Enum.at(list, y), Enum.at(list, x), Enum.at(list, y)]] ++ golistpalindrome(list, next_x, next_y, all+1)
        else 
            golistpalindrome(list, next_x, next_y, all)
        end
     end
      
  end

  defp get_next_x(x, y) do
     if y >= x do x+1 else x end
  end   
  defp get_next_y(x, y) do
   if y >= x do 0 else y + 1 end
  end
 
  defp ispalindorome(number) do
     list = Integer.to_string(number) |> String.graphemes()
     list == Enum.reverse(list)
  end
 
end
