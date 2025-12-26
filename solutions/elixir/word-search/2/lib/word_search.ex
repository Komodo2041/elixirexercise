defmodule WordSearch do
  defmodule Location do
    defstruct [:from, :to]

    @type t :: %Location{
            from: %{row: integer, column: integer},
            to: %{row: integer, column: integer}
          }
  end

  @doc """
  Find the start and end positions of words in a grid of letters.
  Row and column positions are 1 indexed.
  """
  @spec search(grid :: String.t(), words :: [String.t()]) :: %{String.t() => nil | Location.t()}
  def search(grid, words) do

     word1 = Enum.at(words, 0)
     table = String.split(grid, "\n")
  
     
     map = searcho(words, table, %{})
     map
  end

  defp searcho([], table, map), do: map
  defp searcho([word|rest], table, map) do
      map = Map.put(map, word, nil)
      map = getwordintable(word, table, map, 1, 0)
      reveresetable = Enum.map(table, fn(el) -> String.reverse(el) end)
      map = getwordintable(word, reveresetable, map, 2, 0)
      columntable = get_column_table(table)
      map = getwordintable(word, columntable, map, 3, 0)
      reveresetable = Enum.map(columntable, fn(el) -> String.reverse(el) end)
      map = getwordintable(word, reveresetable, map, 4, 0)
      map = checkdiagonal(word, table, map)
      map = searcho(rest, table, map)
      map
  end

  defp checkdiagonal(word, table, map) do
      if length(table) > 1 do
        diagonaltable = get_diagonal_table(table, 1)
        map = getwordintable(word, diagonaltable, map, 5, 0)
        reveresetable = Enum.map(diagonaltable, fn(el) -> String.reverse(el) end)
        map = getwordintable(word, reveresetable, map, 6, 0) 
        diagonaltable2 =  get_diagonal_table( table, 2) 
        map = getwordintable(word, diagonaltable2, map, 7, 0)
       reveresetable = Enum.map(diagonaltable2, fn(el) -> String.reverse(el) end)
        map = getwordintable(word, reveresetable, map, 8, 0) 
        map
      else
        map
      end
  end

  defp getwordintable(word, [], map, type, y), do: map
  defp getwordintable(word, [head|tail], map, type, y) do
    
      wl = String.length(word)
      hl = String.length(head)
      res = for x <- 0..(hl - wl) do
         if String.slice(head, x, wl) == word do
            x
         else
            -1
         end
      end |> Enum.filter(fn(el) -> el >= 0 end)
      if Enum.at(res, 0) do
         location = get_location(Enum.at(res, 0), y, wl, type, hl)
         map = Map.put(map, word, location)
         getwordintable(word, tail, map, type, y+1)
      else
         getwordintable(word, tail, map, type, y+1)
      end
  end

  defp get_location(x, y, wl, type, hl) do
     case type do
          1 -> 
            %WordSearch.Location{
              from: %{
                column: x + 1,
                row: y+1
              },
              to: %{
                column: x + wl,
                row: y+1
              }
          }
          2 -> 
            %WordSearch.Location{
              from: %{
                column: hl - (x ),
                row: y+1
              },
              to: %{
                column: hl - (x + wl - 1),
                row: y+1
              }
          }
          3 -> 
            %WordSearch.Location{
              from: %{
                column: y + 1,
                row: x+1
              },
              to: %{
                column: y+1,
                row:  x + wl
              }
          }    
          4 -> 
            %WordSearch.Location{
              from: %{
                row: hl - (x ),
                column: y+1
              },
              to: %{
                row: hl - (x + wl - 1),
                column: y+1
              }
          }  
          5 -> 
            %WordSearch.Location{
              from: %{
                column: x + 1,
                row: y+1
              },
              to: %{
                column: x + wl,
                row: y + wl
              }
          }   
          6 -> 
            %WordSearch.Location{
              from: %{
                column: hl - (x ),
                row: hl - y+1
              },
              to: %{
                column: hl - (x + wl - 1),
                row: hl - y - wl + 2
              }
          }  
          7 -> 
            %WordSearch.Location{
              from: %{
                column: x + 1,
                row: y - 1
              },
              to: %{
                column: x + wl,
                row: y - wl
              }
          }  
          8 -> 
            %WordSearch.Location{
              from: %{
                column: hl - (x ),
                row: hl - y - wl + 2  
              },
              to: %{
                column: hl - (x + wl - 1),
                row:  hl - y+1
              }
          }            
     end
  end

  defp get_column_table(table) do
     
     l = length(table)
     s = String.length(Enum.at(table, 0))
     res =   for y <- 0..(s-1) do
            for x <- 0..(l - 1) do
           pos(table, x, y)
        end
     end |> Enum.map(fn(el) -> Enum.join(el, "") end)
   
     res
  end

defp pos(table, x, y) do
    str = Enum.at(table, x)
    if str do
       String.slice(str, y, 1)
    else
      "A"
    end
end

defp get_diagonal_table(table, type) do
     l = length(table)
     s = String.length(Enum.at(table, 0))
     res =  for x <- 0..(l - 1) do
           for y <- 0..(s-1) do
               x2 = getnewposy(x,y,l, type)
               # if type == 2 do
              #     IO.inspect([x2, x, y, pos(table, x2, y )  ])
              #  end
              
                pos(table, x2, y )   
               
               
            
        end
      end |> Enum.map(fn(el) -> Enum.join(el, "") end)
      IO.inspect(res)
end

defp getnewposy(x, y, l, type) do
 
   if type == 1 do
     y = y + x
     rem(y, l)
   else
     y = x - y
     if y < 0 do
       l - 1 - abs(y)
     else
       y
     end
      
    
 
   end
end

end