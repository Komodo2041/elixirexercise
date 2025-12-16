defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, String.t()}
  def convert(input) do
     if rem(length(input), 4) == 0 && rem(String.length(Enum.at(input, 0)), 3) == 0 do
        result = read_col(input, "", 0, 0)
        IO.inspect(result)
        {:ok, Enum.join(result, ",")}
     else
        if rem(length(input), 4) != 0 do
           {:error, "invalid line count"}
        else 
           {:error, "invalid column count"}
        end
     end
  end

  defp read_col(input, res, start, y) do
  
      if y >= length(input) do
         []
      else   
        [read(input, "", 0, y)] ++ read_col(input, "", 0, y + 4)
      end  
  end

  defp read(input, res, start, y) do
  
     if start >=  String.length(Enum.at(input, 0)) do
        res
     else
        check = readone(String.slice(Enum.at(input, y), start, 3), String.slice(Enum.at(input, y + 1), start, 3), String.slice(Enum.at(input, y + 2), start, 3))
        read(input, res <> check, start + 3, y)
     end
  end

  defp readone(one, two, three) do
     cond do
        one == " _ " && two == "| |" && three == "|_|" -> "0"
        one == "   " && two == "  |" && three == "  |" -> "1"
        one == " _ " && two == " _|" && three == "|_ " -> "2"
        one == " _ " && two == " _|" && three ==  " _|" -> "3"
        one == "   " && two == "|_|" && three ==  "  |" -> "4"
        one == " _ " && two == "|_ " && three ==  " _|" -> "5"
        one == " _ " && two == "|_ " && three ==  "|_|" -> "6"
        one == " _ " && two == "  |" && three == "  |" -> "7"
        one == " _ " && two == "|_|" && three == "|_|" -> "8"
        one == " _ " && two == "|_|" && three == " _|" -> "9"
        true -> "?"
     end

  end
  
end
