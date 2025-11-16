defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
     rows = String.split(input, "\n")
     table = Enum.map(rows, fn(el) -> 
        res = String.split(el, " ")
        res = Enum.map(res, fn(s) -> String.to_integer(s) end)
        res 
     end)
     table
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
      rows = Enum.map(matrix, fn (el) -> Enum.join(el, " ") end)
      Enum.join(rows, "\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
      matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
     Enum.at(matrix, index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
      len = length(matrix) - 1
      table = for i <- Enum.to_list(0..len), do: Matrix.column(matrix, i)
      table2 = [Enum.at(table, 1), Enum.at(table, 2), Enum.at(table, 0)]
      table2
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
     col = Enum.map(matrix, fn(c) ->  Enum.at(c, index - 1)  end)
     col
  end
end
