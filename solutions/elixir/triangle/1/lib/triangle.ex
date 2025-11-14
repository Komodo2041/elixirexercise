defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    if (a <= 0 || b <= 0 || c <= 0 ) do
        {:error, "all side lengths must be positive" }
    else
      table = Enum.sort([a, b, c], :desc)
      if (Enum.at(table, 0) > Enum.at(table, 1) + Enum.at(table, 2)) do
        {:error, "side lengths violate triangle inequality" }
      else 
        cond do
          a == b && b == c -> {:ok, :equilateral }
          a == b || b == c || a == c -> {:ok, :isosceles }
          a != b && b != c && a != c -> {:ok, :scalene }
        end
      end  
    end
  end
end
