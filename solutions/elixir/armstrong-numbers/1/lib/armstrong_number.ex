defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
     nr = checknumber(number, 0)
     IO.inspect(nr)
     all = calcamstrong(number, nr)
     IO.inspect(all)
     all  == number
  end

  defp calcamstrong(number, m) do
      if number == 0 do
         0
      else
         rem(number, 10)**m + calcamstrong(div(number, 10), m)
      end
  end

  defp checknumber(number, i) do
      if number == 0 do
         i
      else
        checknumber(div(number, 10), i + 1)
      end
  end
  
end
