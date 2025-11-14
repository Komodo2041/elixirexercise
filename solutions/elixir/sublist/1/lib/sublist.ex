defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
      aa = Enum.join(a, ",")
      bb = Enum.join(b, ",")
      c = String.contains?(aa, bb)
      d = String.contains?(bb, aa)
      e = a -- b
      f = b -- a
      cond do
         c && d  -> :equal
         c && !d && f == [] -> :superlist
         !c && d && e == []  -> :sublist
         !c && !d   -> :unequal
         true -> :unequal
      end
 
  end
end
