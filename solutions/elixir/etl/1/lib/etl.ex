defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
      letters = getAllLetters(input)
      map = create_new_map(%{}, letters)
      map
  end

  defp getAllLetters(input) do
    list = for {_key, val} <- input, into = [], do: val
    getinsideletters(list)
  end
  
  defp getinsideletters([]), do: []
  defp getinsideletters([head|tail]) do
     head ++ getinsideletters(tail)
  end

  defp getpoints(l) do
    cond do
     l in [ "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] -> 1
     l in [ "D", "G"] -> 2
     l in ["B", "C", "M", "P",] -> 3
     l in [ "F", "H", "V", "W", "Y"] -> 4
     l in [ "K"] -> 5
     l in ["J", "X"] -> 8
     l in [ "Q", "Z"] -> 10
     true -> 0
    end
  end

  defp create_new_map(map, []), do: map
  defp create_new_map(map, [head|tail]) do
 
      lvl = getpoints(head)
      m = String.downcase(head)
      map = Map.put(map, m, lvl)
      create_new_map(map, tail) 
  end
end
