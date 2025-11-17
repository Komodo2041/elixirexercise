defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\[:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]) do
     rows =  Enum.map(String.split(info_string, "\n"), fn (el) -> String.graphemes(el) end)
     info = get_info(Enum.at(rows, 0), Enum.at(rows, 1))
     plants = Enum.chunk_every(info, 4)
     mapplants = createmap(%{}, plants, Enum.sort(student_names))
     mapplants
  end

  defp get_info([], []), do: []  
  defp get_info([head|tail], [head2|tail2]) do
      [nameplants(head)] ++ [nameplants(head2)] ++ get_info(tail, tail2)
  end

  defp nameplants(letter) do
     case letter do
        "R" -> :radishes
        "C" -> :clover
        "G" -> :grass
        "V" -> :violets
        _ -> :maca
     end
  end

  defp createmap(map, [], []) do
      map
  end 
  defp createmap(map, [], [name| students]) do    
     map = Map.put(map, name, {})
     createmap(map, [], students)
     map    
  end
  defp createmap(map, [[one, three, two, four] | tail], [name| students]) do
   
     map = Map.put(map, name, {one, two, three, four})
     map = createmap(map, tail, students)
     map
  end
  
end
