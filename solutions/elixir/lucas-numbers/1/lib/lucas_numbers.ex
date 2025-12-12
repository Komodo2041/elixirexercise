defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when is_number(count) == false, do: raise ArgumentError, "count must be specified as an integer >= 1"
  def generate(count) when count <= 0, do: raise ArgumentError, "count must be specified as an integer >= 1"
  def generate(count) do
    # Please implement the generate/1 function
     res = for x <- 1..count do
        lucas(x)
     end
     res
  end

  defp lucas(x) do
     cond do
        x == 1 -> 2
        x == 2 -> 1
        true -> lucas(x-1) + lucas(x-2)
     end
  end
  
end
