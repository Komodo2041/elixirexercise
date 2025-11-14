defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
     st = EliudsEggs.tobinary(number)
     Enum.sum(st)
  end

  def tobinary(0), do:  [0]
   
  def tobinary(number) do
      r = rem(number, 2)
      d = div(number, 2)
      [r | EliudsEggs.tobinary(d)]
  end
  
end
