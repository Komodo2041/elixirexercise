defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
     Enum.sum(triplet)
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
     Enum.reduce(triplet, 1, fn (el, acc) -> acc * el end)
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
     if a**2 + b**2 == c**2 do
        true
     else
        false
     end   
  end

  @doc """
  Generates a list of pythagorean triplets whose values add up to a given sum.
  """
  @spec generate(non_neg_integer) :: [list(non_neg_integer)]
  def generate(sum) do

      square = for x <- 1..(div(sum, 2)), do: x*x
      result = create_result(square, square) |>  Enum.uniq() |> Enum.filter(fn el -> Enum.sum(el) == sum end)
      result
      
  end

  defp create_result([], square), do: []
  defp create_result([head|tail], square) do
      check_numbers = Enum.map(square, fn el -> el + head end)
      inter = Enum.filter(check_numbers, &(&1 in square))
      Enum.map(inter, fn (el) -> Enum.sort([gonum(head), gonum(el-head), gonum(el)]) end) ++ create_result(tail, square)
  end

  defp gonum(x) do
     :math.sqrt(x) |> round()
     
  end
  
end
