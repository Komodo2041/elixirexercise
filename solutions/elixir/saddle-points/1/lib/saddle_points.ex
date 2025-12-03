defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []
  def rows(str) do
     res = String.split(str, "\n") |> Enum.map(fn(el) -> String.split(el, " ") end)
     res = Enum.map(res, fn(el) -> Enum.map(el, fn (el2) -> String.to_integer(el2) end ) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(""), do: []
  def columns(str) do
     matrix = SaddlePoints.rows(str)
     len_y = length(Enum.at(matrix, 0))
     len_x = length(matrix)
     columns = for x <- 0..(len_y - 1) do
        for y <- 0..(len_x - 1) do
           Enum.at(Enum.at(matrix, y), x)
        end
    end
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(""), do: []
  def saddle_points(str) do
     rows = SaddlePoints.rows(str)
     columns = SaddlePoints.columns(str)
     IO.inspect(rows)
     IO.inspect(columns)
     points_rows = minrows(rows, 0)
     points_columns = minrows2(columns, 0)
     res = findpoint(points_rows, points_columns)
       IO.inspect( points_rows)
       IO.inspect( points_columns)
     IO.inspect(res)
     res
  end

  defp minrows([], _), do: []
  defp minrows([head|tail], nr) do
      min = Enum.max(head)
      #pos = Enum.find_index(head, fn el -> el == min end)
      pos = for {el, idx} <- Enum.with_index(head), el == min, do: idx
     # [[nr + 1, pos + 1]] ++ minrows(tail, nr + 1)
      getpointsx(pos, nr, 1) ++ minrows(tail, nr + 1)
  end

  defp minrows2([], _), do: []
  defp minrows2([head|tail], nr) do
      min = Enum.min(head)
    #  pos = Enum.find_index(head, fn el -> el == min end)
       pos = for {el, idx} <- Enum.with_index(head), el == min, do: idx
    #  [[pos + 1, nr + 1]] ++ minrows2(tail, nr + 1)
       getpointsx(pos, nr, 2) ++ minrows2(tail, nr + 1)
  end 

  defp getpointsx([], nr, type), do: []
  defp getpointsx([head|tail], nr, type) do
      if type == 1 do
         [[nr + 1, head + 1]] ++ getpointsx(tail, nr, type)
      else
         [[head + 1, nr + 1]] ++ getpointsx(tail, nr, type)
      end 
  end
  defp findpoint([], points), do: []
  defp findpoint([head|tail], points) do
     if head in points do
        [x, y] = head
        [{x, y}] ++  findpoint(tail, points)
     else
        findpoint(tail, points)
     end
  end
end
