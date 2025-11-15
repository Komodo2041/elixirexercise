defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
     letters = getLetters()
     check = String.graphemes(String.upcase(sentence))
     diff = letters -- check
     IO.inspect(diff)
     if (diff == []) do
        true
     else
        false
     end   
        
  end
 
  defp getLetters do
     table = Enum.to_list(?A..?Z)
     letters = Enum.map(table, fn(el) -> <<el::utf8>> end)
  end
end
