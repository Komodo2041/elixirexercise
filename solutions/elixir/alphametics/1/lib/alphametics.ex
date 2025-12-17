defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

    iex> Alphametics.solve("I + BB == ILL")
    %{?I => 1, ?B => 9, ?L => 0}

    iex> Alphametics.solve("A == B")
    nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
       nozeros = String.replace(puzzle, "=", "") |> String.replace("+", "") |> String.split(" ") |> Enum.filter(fn(el) -> el != "" end) |>   Enum.map(fn(el) -> d = String.graphemes(el) |> Enum.uniq()
       Enum.at(d, 0) end)
       puzzle = String.replace(puzzle, " ", "")
       parts = get_parts(puzzle)
       IO.inspect(parts)
       allletters = String.replace(puzzle, "=", "") |> String.replace("+", "") |> String.graphemes() |> Enum.uniq()
       codition = getcondition(Enum.at(parts, 0),  Enum.at(parts, 1), 0 )
        
       
       resulto = goresulto(codition, 0, allletters, nozeros)
       IO.inspect(resulto)
       if resulto do
          resulto
       else
          nil
       end
  
  end

 defp goresulto(codition, nr, allletters, nozeros) do
       random = Enum.shuffle(Enum.to_list(0..9))      
       mapsa = gomapa(allletters, %{}, random, 0, nozeros) 
      
       if checkcondition(codition, 0, mapsa, 0) do
           IO.inspect(mapsa)
          cv = converto(mapsa, allletters, %{})
          IO.inspect(cv)
          cv
       else
          if nr > 1000000 do
             false
          else
             goresulto(codition, nr + 1, allletters, nozeros)
          end   
       end
 end

 defp converto(mapsa, [], map), do: map
 defp converto(mapsa, [h|t], map) do
    nr = String.to_charlist(h)
    map = Map.put(map, hd(nr), mapsa[h])
    converto(mapsa, t, map)
 end

 defp checkcondition([] ,popres, mapsa, ins), do: false
 defp checkcondition([head|tail], popres, mapsa, ins) do 
  
    res = Enum.sum(Enum.map(Enum.at(head, 0), fn(el) -> mapsa[el] end))
    res = res + div(popres, 10)
   
    if rem(res,10) == mapsa[Enum.at(head, 1)] do
       if tail == [] do 
          true
       else
     
          checkcondition(tail, res, mapsa, ins+1)
       end
    else
       false
    end
 end

  defp gomapa([], map, _, _, nozeros), do: map
  defp gomapa([head|tail], map, random, nr, nozeros) do
     if Enum.at(random, nr) == 0 && head in nozeros do
         pos = Enum.at(random, nr + 1)
         map = Map.put(map, head, pos)
         random = Enum.map(random, fn(el) -> if pos == el  do 0 else el end end)
         gomapa(tail, map, random, nr+1, nozeros)
     else
         map = Map.put(map, head, Enum.at(random, nr))
         gomapa(tail, map, random, nr+1, nozeros)
     end
 
  end
  
  defp getcondition(tosum, result, nr  ) do
     if length(result)  == nr   do
        []
     else
        [column(tosum, result, nr )] ++ getcondition(tosum, result, nr + 1 )
     end
  end

  defp column(tosum, result, nr) do
    result = Enum.at(Enum.reverse(result), nr)
    sum = Enum.map(tosum, fn(el) -> 
       revo = Enum.reverse(el)
       if (Enum.at(revo, nr)) do
          Enum.at(revo, nr)
       else
          "#"
       end
    end) |> Enum.filter(fn(e) -> e != "#" end)
    [sum, result]
  end

  defp get_parts(puzzle) do
     parts = String.split(puzzle, "==")
     [String.split(Enum.at(parts, 0), "+") |> Enum.map(fn(el) -> String.graphemes(el) end), String.graphemes(Enum.at(parts, 1))]
  end
  
end
