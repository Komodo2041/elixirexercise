defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
      checkDigits = Enum.reduce(digits, 1, fn(d, acc) -> if (d < 0) do acc = 0 else acc  end  end)
      checkDigits2 = Enum.reduce(digits, 1, fn(d, acc) -> if (d >= input_base) do acc = 0 else acc  end  end)
      if (input_base < 2 || output_base < 2 || digits == [] || checkDigits == 0 || checkDigits2 == 0) do
           cond do
               input_base < 2 && output_base < 2 -> {:error, "input base must be >= 2"}
               input_base < 2 ->{:error, "input base must be >= 2"}
               output_base < 2 -> {:error, "output base must be >= 2"}
               checkDigits == 0 -> {:error, "all digits must be >= 0 and < input base"}  
               checkDigits2 == 0 -> {:error, "all digits must be >= 0 and < input base"}  
               digits == [] -> {:ok, [0]}
               true -> {:ok, [0]}
           end
       else
        
        val = AllYourBase.todeci(Enum.reverse(digits), input_base, 1)
        if val == 0 do
           {:ok, [0]}
        else
            n2 = AllYourBase.touotbase(val, output_base )
           {:ok, Enum.reverse(n2)}
        end
 
      end
  end

   def todeci([], input_base, m), do: 0 
   def todeci([head|tail], input_base, m) do
        head * m  + AllYourBase.todeci(tail, input_base , m * input_base)
   end

   def touotbase(value, base) do
   
      if value == 0 do
         []
      else
         [rem(value, base)] ++ AllYourBase.touotbase(div(value, base), base)
      end
  end

  defp tolistint(n) do
     if (n == 0) do
        []
     else
        [rem(n, 10)] ++ tolistint(div(n, 10))
     end
  end
  
end
