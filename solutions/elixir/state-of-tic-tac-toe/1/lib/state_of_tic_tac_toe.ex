defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
      result = String.split(String.trim(board), "\n") |> Enum.map(fn(table) -> 
         res = String.split(table, "")
         res = Enum.filter(res, fn(x) -> x != "" end)
         res
      end)
      nrX = calcchar(result, "X"); 
      nrO = calcchar(result, "O"); 
      cond do
         checkwin(result, ["X"]) && checkwin(result, ["O"]) -> {:error, "Impossible board: game should have ended after the game was won"}
         checkwin(result, ["X", "O"]) -> {:ok, :win}
         nrO + nrX == 9 -> {:ok, :draw}
         nrO > nrX -> {:error, "Wrong turn order: O started"}
         abs(nrX - nrO) >= 2 -> {:error, "Wrong turn order: X went twice"}
         true -> {:ok, :ongoing}
      end 
  end

  defp checkwin(tab, checked) do
      cond do
         pos(tab, 0, 0) == pos(tab, 1, 0) && pos(tab, 1, 0) == pos(tab, 2, 0) && pos(tab, 2, 0) in checked -> true
         pos(tab, 0, 1) == pos(tab, 1, 1) && pos(tab, 1, 1) == pos(tab, 2, 1) && pos(tab, 2, 1) in checked -> true
         pos(tab, 0, 2) == pos(tab, 1, 2) && pos(tab, 1, 2) == pos(tab, 2, 2) && pos(tab, 2, 2) in checked -> true
         pos(tab, 0, 0) == pos(tab, 0, 1) && pos(tab, 0, 1) == pos(tab, 0, 2) && pos(tab, 0, 2) in checked -> true
         pos(tab, 1, 0) == pos(tab, 1, 1) && pos(tab, 1, 1) == pos(tab, 1, 2) && pos(tab, 1, 2) in checked -> true
         pos(tab, 2, 0) == pos(tab, 2, 1) && pos(tab, 2, 1) == pos(tab, 2, 2) && pos(tab, 2, 2) in checked -> true
         pos(tab, 0, 0) == pos(tab, 1, 1) && pos(tab, 1, 1) == pos(tab, 2, 2) && pos(tab, 2, 2) in checked -> true
         pos(tab, 2, 0) == pos(tab, 1, 1) && pos(tab, 1, 1) == pos(tab, 0, 2) && pos(tab, 0, 2) in checked -> true
         true -> false
      end 
  end

  defp pos(board, x, y) do
   Enum.at(Enum.at(board, y), x)
  end

   defp calcchar(res, ch) do
      Enum.reduce(res, 0, fn(el, acc) ->
         acc + Enum.reduce(el, 0, fn(el2, acc2) -> if ch == el2 do acc2 + 1 else acc2 end end)
         end)
         
   end
end
