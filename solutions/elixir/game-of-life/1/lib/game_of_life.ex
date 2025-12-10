defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []
  def tick(matrix) do
     size = length(matrix)
     output = for i <- 0..(size-1) do
        for j <- 0..(size-1) do
           val = Enum.at(Enum.at(matrix, i), j)
          
           calc = countmatrix(matrix, j, i, val, size)
         
           if val == 1 do
              if calc == 2 || calc == 3 do
                 1
              else
                 0
              end
           else
               if calc == 3 do
                 1
              else
                 0
              end          
           end
        end
     end
   
      output
     
  end

  defp countmatrix(matrix, i, j, val, size) do
     output = for x <- (i-1)..(i+1) do
        for y <- (j-1)..(j+1) do
           if check_size(x, y, size) do
               Enum.at(Enum.at(matrix, y), x)
           else
               0
           end
            
        end   
     end
   
     output = Enum.map(output, fn (el) -> Enum.sum(el) end)
     Enum.sum(output) - val
  end

  defp check_size(x, y, size) do
     cond do
        x < 0 || y < 0 -> false
        x > size - 1 || y > size - 1 -> false
        true -> true
     end
  end
  
end
