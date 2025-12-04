defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(dimension) do
     table = for x <- 1..dimension do
        for y <- 1..dimension do
           1
        end
     end
     table = direct(1, 0, 0, dimension, table, 1)
  
  end

 defp direct(nr, poz_x, poz_y, size, table, dir) do
    if (nr > size * size) do
       table
    else
    IO.inspect([poz_x, poz_y])
        table = changeTable(nr, poz_x, poz_y, table)
          IO.inspect(table)
        {next_x, next_y} = getNextPoz(poz_x, poz_y, dir)
        isgood = checkPoz(table, next_x, next_y, size)
        if isgood do
           direct(nr + 1, next_x, next_y, size, table, dir)
        else
           newdir = getnextdir(dir)
           {next_x, next_y} = getNextPoz(poz_x, poz_y, newdir)
            direct(nr + 1, next_x, next_y, size, table, newdir)
        end
    end
 end

 defp getnextdir(dir) do
    case dir do
       1 -> 2
       2 -> 3
       3 -> 4
       4 -> 1
    end
 end

 defp checkPoz(table, next_x, next_y, size) do
    cond do
       next_x < 0 || next_y < 0 -> false
       next_y >= size || next_x >= size -> false
       isnozero(table, next_x, next_y) -> false
       true -> true
    end
 end

 defp isnozero(table, next_x, next_y) do
 
    if Enum.at(Enum.at(table, next_y), next_x) > 1 || (next_y == 0 && next_x == 0) do
       true
    else
       false
    end   
 end

 defp getNextPoz(poz_x, poz_y,  dir) do 
     case dir do
       1 -> {poz_x + 1, poz_y}
       2 -> {poz_x, poz_y + 1}
       3 -> {poz_x - 1, poz_y}
       4 -> {poz_x, poz_y-1} 
     end
 end

  defp changeTable(value, j, i, table) do 
      table |> List.update_at(i, fn row -> row |> List.replace_at(j, value) end)
  end
end
