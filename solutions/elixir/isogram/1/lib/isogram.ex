defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
     sentence = Regex.replace(~r/[^\w]/, String.downcase(sentence), "")
     str = String.graphemes(sentence)
     stru = Enum.uniq(str)
     diff = str -- stru;
     if (diff == []) do
        true
     else
        false
     end   
  end
end
