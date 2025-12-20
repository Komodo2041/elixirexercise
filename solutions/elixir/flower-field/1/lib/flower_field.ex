defmodule FlowerField do
  @doc """
  Annotate empty spots next to flowers with the number of flowers next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate([]), do: []
  def annotate([""]), do: [""]
  def annotate(board) do
     table = Enum.map(board, fn (el) -> String.graphemes(el) end)
     sizex = length(table)
     sizey = length(Enum.at(table, 0))
 
     newtable = for x <- 0..(sizex-1) do
         for y <- 0..(sizey - 1) do
 
            if Enum.at(Enum.at(table, x), y) == "*" do
               "*"
            else 
                res = calc(x, y, sizex, sizey, table)  
                if res > 0 do
                   res
                else
                   " "
                end
            end 
         end
     end
     Enum.map(newtable, fn(el) -> Enum.join(el, "") end)
  end

 
  defp calc(x, y, sizex, sizey, table) do
  
     res = for i <- (x - 1)..(x + 1) do
        for j <- (y - 1)..(y + 1), into = [] do
           poz(i, j, table, sizex, sizey)
        end
     end
     res = Enum.reduce(res, [], fn(el, acc) -> acc ++ el end)
   
     Enum.sum(res)
  end

  defp poz(x, y, table, sizex, sizey) do
     if x < 0 || y < 0 || x >= sizex || y >= sizey do
        0
     else
       if Enum.at(Enum.at(table, x), y) == "*" do
          1
       else
         0
      end 
    end
  end
  
end
