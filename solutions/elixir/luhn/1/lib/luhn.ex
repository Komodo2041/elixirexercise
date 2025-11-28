defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
     numbers = String.replace(number, " ", "") |> String.trim()  
     numbers = String.graphemes(numbers)
     valid = Enum.all?(numbers, fn el -> el in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] end)
     l = length(numbers)
     if valid && l > 1 do
        
       param = get_param(l)
       numbers = Enum.map(numbers, fn el  -> String.to_integer(el) end)
       numbers = for x <- 0..(l - 1) do
         if rem(x + param, 2) == 0 do
            newnumber(Enum.at(numbers, x))
          else 
            Enum.at(numbers, x)
          end
       end  
      
       IO.inspect(numbers)
       sum = Enum.sum(numbers)
       IO.inspect(sum)
       if rem(sum, 10) == 0  do
          true
       else
          false
       end
     else
      false
     end 
  end

  defp newnumber(x) do
     x = x * 2
     if x > 9 do
        x - 9
     else
        x
     end   
  end

  defp get_param(x), do: rem(x,2)
end
