defmodule Squares do
  @moduledoc """
  Calculate sum of squares, square of sum, difference between two sums from 1 to a given end number.
  """

  @doc """
  Calculate sum of squares from 1 to a given end number.
  """
  @spec sum_of_squares(pos_integer) :: pos_integer
  def sum_of_squares(number) do
     res = schedulenumber(number)
     Enum.sum(Enum.map(res, fn(x) -> x**2 end))
  end

  @doc """
  Calculate square of sum from 1 to a given end number.
  """
  @spec square_of_sum(pos_integer) :: pos_integer
  def square_of_sum(number) do
     res = schedulenumber(number) 
     Enum.sum(res) ** 2
  end

  @doc """
  Calculate difference between sum of squares and square of sum from 1 to a given end number.
  """
  @spec difference(pos_integer) :: pos_integer
  def difference(number) do
      Squares.square_of_sum(number) - Squares.sum_of_squares(number)
  end

  defp schedulenumber(0), do: []
  defp schedulenumber(number) do
      [number | schedulenumber(number - 1)]
  end
  
end
