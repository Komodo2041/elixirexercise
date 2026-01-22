defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], workers), do: %{}
  def frequency(texts, workers) do
    text = Enum.join(texts, "") |> String.downcase() |> String.replace(" ", "")  |> String.replace("\t", "") |> String.replace("\r", "") |> String.replace("\n", "") |> String.replace("!", "") |> String.replace("?", "") |> String.replace(";", "") |> String.replace(",", "") |> String.replace(".", "") |> String.replace("1", "") |> String.replace("2", "") |> String.replace("3", "") |> String.replace("4", "") |> String.replace("5", "") |> String.replace("6", "") |> String.replace("7", "") |> String.replace("8", "") |> String.replace("9", "")  |> String.replace(":", "")  |> String.replace("-", "")  |> String.replace("(", "")  |> String.replace(")", "")  |> String.replace("'", "")  |> String.replace("\"", "") 
    letters = String.graphemes(text) 
    map = Enum.frequencies(letters)
    IO.inspect(map)
   IO.inspect(texts)
   IO.inspect(letters)
    map
  end
end
