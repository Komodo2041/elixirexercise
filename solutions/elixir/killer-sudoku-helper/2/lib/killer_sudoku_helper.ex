defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(cage) do
        list = Enum.to_list(1..9) -- cage.exclude
        rules = get_comb(cage.sum, cage.size, list, [], list)
  end

  defp get_comb(_, _, [], res, _), do: []
  defp get_comb( sum, size, [head|tail], res, list) do
     res = res ++ [head]
     if  length(res) == size do
        if Enum.sum(res) == sum do
           other = list -- res 
           [res] ++ get_comb( sum, size, other, [], other)
        else
           get_comb( sum, size, tail, res -- [head], list)
        end
     else
        get_comb( sum, size, tail, res, list)
     end
  end

  
end
