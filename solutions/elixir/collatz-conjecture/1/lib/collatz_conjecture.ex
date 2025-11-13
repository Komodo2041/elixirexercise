defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) do
     if (!is_integer(input)) do
      raise FunctionClauseError, "FunctionClauseError but got ArithmeticError (bad argument in arithmetic expression)"
     end
     if (input < 1) do
        raise FunctionClauseError, "negative value is an error"
     end
   
     if (input == 1) do
        0
     else
     
        if (rem(input, 2) == 0) do
            
            CollatzConjecture.calc(trunc(input/2)) + 1
         else 
            CollatzConjecture.calc(input * 3 + 1) + 1
         end
      
         
     end
 
 
  end
end
