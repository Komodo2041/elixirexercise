defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
     all_sign = for x <- Enum.to_list(start..stop), do: getrow(x)
     Enum.join(all_sign, "")
  end

  defp getrow(x) do
     lines = create_row(x, x)
     Enum.join(lines, " ")
  end

  defp create_row(0, start2), do: []
  defp create_row(start, start2) do
      [[phrase(start, start2)] | create_row(start - 1, start2)]
  end

  defp phrase(nr, nr2) do
     if nr == nr2 do
       case nr do
           1 -> "This is the house that Jack built.\n"
           2 -> "This is the malt"
           3 -> "This is the rat"
           4 -> "This is the cat"
           5 -> "This is the dog"
           6 -> "This is the cow with the crumpled horn"
           7 -> "This is the maiden all forlorn"
           8 -> "This is the man all tattered and torn"
           9 -> "This is the priest all shaven and shorn"
           10 -> "This is the rooster that crowed in the morn"
           11 -> "This is the farmer sowing his corn"
           12 -> "This is the horse and the hound and the horn"
           _ -> ""
       end     
     else
       case nr do
           1 -> "that lay in the house that Jack built.\n"
           2 -> "that ate the malt"
           3 -> "that killed the rat"
           4 -> "that worried the cat"
           5 -> "that tossed the dog"
           6 -> "that milked the cow with the crumpled horn"
           7 -> "that kissed the maiden all forlorn"
           8 -> "that married the man all tattered and torn"
           9 -> "that woke the priest all shaven and shorn"
           10 -> "that kept the rooster that crowed in the morn"
           11 -> "that belonged to the farmer sowing his corn"
           12 -> "This is the horse and the hound and the horn"
           _ -> ""
       end     
     end
 
  end

  
end
