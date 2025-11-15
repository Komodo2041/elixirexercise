defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
      list1 = [1]
      createmiddle(list1, 1, num)
     
  end

  defp createmiddle(list, acti, num) do
     if acti == num do
        [list]
     else
        middle = caclmiddle(list)        
        newlist = [1] ++ middle ++ [1]
        [list] ++ createmiddle( newlist, acti + 1, num)
     end
  end

  defp caclmiddle([]), do: []
  defp caclmiddle([head|tail]) do
     two = Enum.at(tail, 0)    
     if (two) do 
        [head + two] ++ caclmiddle(tail)
     else
        []  
     end
  end
end
