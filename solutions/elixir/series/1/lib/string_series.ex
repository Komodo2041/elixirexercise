defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
      if (String.length(s) < size || size <= 0 ) do
           []
      else
          res = []
          f = String.length(s) - size
          table = StringSeries.getStrings(f, s, size) 
          IO.inspect(table)
          Enum.reverse(Enum.filter(table, &(&1 != "")))
      end
  end

  def getStrings(f, s, size) do
 
     if (f < 0) do
        [""]
     else
        [String.slice(s, f, size) | StringSeries.getStrings(f - 1, s, size)]
     end
  end

  
end
