defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
      getFactors(number)
     
  end

  defp getFactors(number) do
     
      if (number > 1) do
        #change for test
         list = for x <- Enum.to_list(2..10000), rem(number, x) == 0, do: x
         if length(list) == 0 do
            [number]
         else 
            rev = div(number, Enum.at(list, 0)) 
            [Enum.at(list, 0)] ++ getFactors(rev)
         end           
      else
       []
      end
 
 
  end

  

  
end
