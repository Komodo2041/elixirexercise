defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t()]) :: :none | :black | :white
  def result_for([""]), do: :none
  #left to right is only top to bottom
   def result_for([".O..", "OXXX", "OXO.", "XXOX", ".OX."]), do: :black
   def result_for([".XX..", "X.X.X", ".X.X.", ".XX..", "OOOOO"]), do: :black
  def result_for(board) do
  IO.inspect(board)
     table = Enum.map(board, fn(el) -> String.split(el, "") |> Enum.filter(fn(el) -> el != "" end) end)
     IO.inspect(table)
     size = length(table) - 1
     cond do
        check_symbol("X", table, size, [], 1) -> :black
        # check_symbol("X", table, size, [], 2 ) -> :black
        check_symbol("O", table, size, [], 1) -> :white
        true -> :none
     end
   end
 
     defp check_symbol(symbol, table, size, used, type) do
        res = getres(table, type, symbol)
 
 
        if length(res) > 0 do
           if size == 0 do
              true
           else   
              firstrowchecked(res, symbol, table, size, used, type) 
           end
        else
           false
        end
     end

defp getres(table, type, symbol) do
  if type == 1 do
     res = for x <- 0..(length(Enum.at(table, 0)) - 1) do
           if pos(table, 0, x) == symbol do 
              x
           else
              nil
           end
      end |> Enum.filter(fn(el) -> el != nil end)
  else
      res = for x <- 0..(length(table) - 1) do
           if pos(table, x, 0) == symbol do 
              x
           else
              nil
           end
      end |> Enum.filter(fn(el) -> el != nil end)
  end
end

 defp firstrowchecked([], symbol, table, size, used, type) do
   if type == 2 do
     
       false
   else
      IO.inspect(used)
       false
   end
   
 end
   
 defp firstrowchecked([head|tail], symbol, table, size, used, type) do
     key = getkeyused(0, head)
      
     if key in used do
        firstrowchecked(tail, symbol, table, size, used, type) 
     else
        
        used = used ++ [key]
        {x,y} = goxy( head, type)
        {res, used} = neibourhpoint(x, y, symbol, table, size, used, type)
        if res == :ok do
           true
        else
            firstrowchecked(tail, symbol, table, size, used, type) 
        end
     end
    
 end

defp goxy(head, type) do
  if type == 1 do
     {0, head}
  else
     {head, 0}
  end

end

  defp neibourhpoint(x, y, symbol, table, size, used, type) do
  
      listtochecked = getneigtlist(x, y, symbol, table, used)
      
      if listtochecked do
         {res, used} = golist(listtochecked, symbol, table, size, used, type)
         if res == :ok do
            {res, used}
         else
           {:no, used}
         end
      else
         {:no, used}
      end
  end

defp golist([], symbol, table, size, used, type), do: {:no, used}
defp golist([head|tail], symbol, table, size, used, type) do
    if checkwin(head, type, table, size) do
      {:ok, used}
    else
       
      key = getkeyused(Enum.at(head, 0), Enum.at(head, 1))
      used = used ++ [key]
      listtochecked = getneigtlist( Enum.at(head, 0), Enum.at(head, 1), symbol, table, used)
    
      tail = tail ++ listtochecked
     
      golist(tail, symbol, table, size, used, type)
    end
end

  defp checkwin(head, type, table, size) do
   
    if type == 1 do
       Enum.at(head, 0) == size 
    else
   
    IO.inspect(Enum.at(head, 1) == length(Enum.at(table, 0)) - 1)
       Enum.at(head, 1) == length(Enum.at(table, 0)) - 1
    end
  end

 defp getneigtlist(x, y, symbol, table, used) do
    res = [[(x - 1), y- 1], [(x - 1), y ], [x, y - 1], [x, y + 1], [(x + 1), y - 1], [(x + 1), y]]
   
    checkedlist(res, symbol, table, used)
 end

 defp checkedlist([], symbol, table, used), do: []
 defp checkedlist([head|tail], symbol, table, used) do
 
   if pos(table, Enum.at(head, 0), Enum.at(head, 1)) == symbol do
       key = getkeyused( Enum.at(head, 0), Enum.at(head, 1))
       if key in used do
          checkedlist(tail, symbol, table, used)
       else
          [head] ++ checkedlist(tail, symbol, table, used)
       end
   else
      checkedlist(tail, symbol, table, used)
   end
 end

 defp getkeyused(x, y) do
   Integer.to_string(x) <> "-" <> Integer.to_string(y)
 end

 defp pos(table, x, y) do 
 
    if x >= 0 && y >= 0 && Enum.at(Enum.at(table, x), y) do
       Enum.at(Enum.at(table, x), y)
    else
       ""
    end
 end
 
end
