defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
     fbin = Enum.reverse(tobinary(flags))
     flags = getflags(fbin, length(fbin))
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
     list = Allergies.list(flags)
     item in list
  end

  defp tobinary(flags) do
     if (flags == 0) do
        []
     else
        [rem(flags, 2)] ++ tobinary(div(flags, 2))
     end
  end

  defp getflags([], pos), do: []
  defp getflags([head|tail], pos) do
     getoneflag(head, pos) ++ getflags(tail, pos - 1)
  end

  defp getoneflag(head, pos) do
      if head == 1 do
         case pos do
             1 -> ["eggs"]
             2 -> ["peanuts"]
             3 -> ["shellfish"] 
             4 -> ["strawberries"] 
             5 -> ["tomatoes"] 
             6 -> ["chocolate"]
             7 -> ["pollen"]
             8 -> ["cats"]
             _ -> []
         end
      else
         []
      end
  end

  
end
