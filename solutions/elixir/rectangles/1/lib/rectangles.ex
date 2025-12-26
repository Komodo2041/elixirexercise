defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(""), do: 0
  def count(input) do
     boks = String.split( input, "\n") |> Enum.map(fn(x) -> String.split(x, "") end)
     IO.inspect(boks)
     size_x =  length(boks)
     size_y = Enum.map(boks, fn(el) -> length(el) end) |> Enum.max()
   
     res = for x <- 0..(size_x-1) do
       for y <- 0..(size_y-1) do
          count_rect(x, y, boks)
       end
     end
     IO.inspect(res)
         Enum.reduce(res, 0, fn(el, acc) -> Enum.sum(el) + acc end)
  end

  defp count_rect(x, y, boks) do
    if get_pos(boks, x, y) == "+" do
       possiblex = get_possiblex(boks, x, y)
       possibley = get_possibley(boks, x, y)
      # IO.inspect([x,y])
      # IO.inspect(possiblex)
        #   IO.inspect(possibley)
       count_all_rect(boks, x, y, possiblex, possibley)
    else
       0
    end   
  end

  defp get_pos(boks, x, y) do
    size_x =  length(boks) - 1
     size_y =  length(Enum.at(boks, x)) - 1
     if x > size_x || y > size_y do
        0
     else
        Enum.at(Enum.at(boks, x), y)
     end
     
  end

  defp get_possiblex(boks, x, y) do
     size_x =  length(boks)
     if x + 1 >= size_x do
       []
     else
       res = for i <- (x+1)..(size_x-1) do 
     
          if get_pos(boks, i, y) == "+" do
             i
          else
             0
          end
       end
       Enum.filter(res, fn(el) -> el > 0 end)
     end
 
  end

  defp get_possibley(boks, x, y) do
     size_y = Enum.map(boks, fn(el) -> length(el) end) |> Enum.max()
     if y + 1 >= size_y do
        []
     else
        res = for i <- (y+1)..(size_y-1) do
        if get_pos(boks, x, i) == "+" do
           i
        else
           0
        end
     end
     Enum.filter(res, fn(el) -> el > 0 end) 
     end
    
  end

  defp count_all_rect(boks, x, y, possiblex, possibley) do
     res = for i <- possiblex do
        for j <- possibley do
           if get_pos(boks, i, j) == "+" do
              
              checkborders(boks, x, y, i, j)
              #1
           else
              0
           end
        end
     end
     Enum.reduce(res, 0, fn(el, acc) -> Enum.sum(el) + acc end)
  end

  defp checkborders(boks, x, y, i, j) do
    left = for d <- (x+1)..(i-1) do
       lr(get_pos(boks, d, y))
    end

    right = for d <- (x+1)..(i-1) do
       lr(get_pos(boks, d, j))
    end    

    top = for d <- (y+1)..(j-1) do
       bt(get_pos(boks, x, d))
    end 

    bottom = for d <- (y+1)..(j-1) do
       bt(get_pos(boks, i, d))
    end  

    if -1 in left || -1 in right  || -1 in top  || -1 in bottom do
       0
    else
       1
    end
  
  end

  defp bt(pos) do
     if pos == "+" || pos == "-" do
       1
     else
       -1
     end  
  end

  defp lr(pos) do
     if pos == "+" || pos == "|" do
       1
     else
       -1
     end  
  end
 
end
