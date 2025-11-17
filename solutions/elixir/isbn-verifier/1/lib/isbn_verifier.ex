defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
     clean = String.replace(isbn, "-", "")
     str = Regex.replace(~r/[0-9X]+/, clean, "") 
     clean = String.graphemes(clean)
    
     if (length(clean) == 10) && str == "" do
        nr = calc_clean(clean, 10)
        IO.inspect(nr)
        if rem(nr, 11) == 0 do
           true
        else
           false
        end 
     else
        false
     end
  end

  defp calc_clean([], nr), do: 0
  defp calc_clean([head|tail], nr) do
     if (head == "X") do
        10 + calc_clean(tail, nr - 1)
     else
        String.to_integer(head) * nr + calc_clean(tail, nr - 1)
     end
      
  end
  
end
