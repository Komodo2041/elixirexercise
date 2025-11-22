defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) when str == "", do: ""
  def encode(str) do
     str = str |> String.replace(" ", "") |> String.replace(".", "") |> String.replace("-", "") |> String.replace("@", "")   |> String.replace("%", "") |> String.replace("!", "") |> String.replace(",", "") |> String.downcase()
     if str != "" do
     len_x = str |> String.length |> :math.sqrt() |> ceil()
     part = String.graphemes(str) |> Enum.chunk_every(len_x)
     res = seeall(part, 0, len_x)
     Enum.join(res, " ")
   else
        ""
    end
  end

  defp seeall(part, x, len_x) do
     if len_x == x do
        []
     else
        [change_part(part, x)] ++ seeall(part, x+1, len_x)
     end
  end

  defp change_part([], x), do: "" 
  defp change_part([head|tail], x) do 
      getchar(Enum.at(head, x)) <> change_part(tail, x) 
  end

  defp getchar(x) do
    if x do
       x
    else
       " "
    end
  end
 
end
