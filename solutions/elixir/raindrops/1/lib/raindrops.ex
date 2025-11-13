defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
        amo = Raindrops.test3(number, 3, "Pling") <> Raindrops.test3(number, 5, "Plang") <> Raindrops.test3(number, 7, "Plong")
        if (amo != "") do
            amo
        else
            to_string(number)
        end
  end

  def test3(number, two, str) do
     if ( rem(number, two) == 0) do
         str
     else
         ""
     end    
  end
 
  
  
end
