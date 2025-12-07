defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""
  def transpose(input) do
     table = String.split(input, "\n") |> Enum.map(fn(el) -> String.split(el, "") end)
     newtable = gocolumn(table)   
  end

  defp gocolumn(table) do
     l = length(table)
     width = get_width(table, l)
     res = columns(0, width, table, l)
      IO.inspect(table)
     IO.inspect(res)
     dobo = Enum.map(res, fn(el) ->   String.replace(String.trim_trailing(String.replace(Enum.join(el, ""), "#", " ")), "@", " ") end)
      #dobo = Enum.filter(dobo, fn(x) -> x != "" end)
     String.trim(Enum.join(dobo, "\n"))
  end

  defp columns(i, width, table, l) do
     if i >= width do
        []
     else       
        col = for x <- 0..(l-1) do
           format(Enum.at(Enum.at(table, x), i))
        end
        [col] ++ columns(i + 1, width, table, l)
     end
  end

  defp format(ch) do 
     if ch && ch != "" do
        if ch == " " do
           "@"
        else
           ch
        end
         
     else
        "#"
     end
  end   

  defp get_width(table, l) do
     len = for x <- 0..(l-1), do: length(Enum.at(table, x))
     Enum.max(len)
  end
 
end
