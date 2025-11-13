defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
      rem10 = rem(number, 10)
      d = rem(div(number, 10), 10)
      s = rem(div(number, 100), 10)
      t = rem(div(number, 1000), 10)
      RomanNumerals.cif(t, "M", "M1", "M2") <> RomanNumerals.cif(s, "C", "D", "M") <> RomanNumerals.cif(d, "X", "L", "C") <> RomanNumerals.cif(rem10, "I", "V", "X")
  end

  def cif(n, c1, c2, c3) do
      case n do
          0 -> ""
          1 -> c1
          2 -> c1 <> c1
          3 -> c1 <> c1 <> c1
          4 -> c1 <> c2  
          5 -> c2
          6 -> c2 <> c1
          7 -> c2 <> c1 <> c1
          8 -> c2 <> c1 <> c1 <> c1
          9 -> c1 <> c3
      end
  end
end
