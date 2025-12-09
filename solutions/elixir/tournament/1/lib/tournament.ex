defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do 
     mapo = getMapo(input, %{})
     res = Map.to_list(mapo)
     res =  Enum.sort(res, fn {k1, v1}, {k2, v2} -> 
       if v1.mp == v2.mp do
         k1 < k2
       else
          v1.mp > v2.mp
       end
     end)
    
     th = "Team                           | MP |  W |  D |  L |  P"  
     if length(input) == 0 do 
        th 
     else
        text = Enum.map(res, fn {key, value} -> get_record(key, value, th) end)       
        th <> "\n" <> Enum.join(text, "\n") 
     end
  end

  defp get_record(key, value, data) do
          
     l =  String.length("Team                           ")
     lkey = String.length(key)
     newkey = get_keyo(l, lkey)
 
     data = String.replace(data, "MP", " " <> Integer.to_string(value.win + value.draw + value.lose)) |> String.replace("W",  Integer.to_string(value.win)) |> String.replace("D",  Integer.to_string(value.draw)) |> String.replace("L",  Integer.to_string(value.lose))|> String.replace(get_pchange(value.mp),  Integer.to_string(value.mp)) |> String.replace("Team                           ", key <> newkey) 
     data
  end

  defp get_pchange(x) do
     if x > 9 do
        " P"
     else
        "P"
     end
  end

  defp get_keyo(l1, l2) do
     diff = l1 - l2 
     res = for _ <- 1..diff do
        " "
     end
     Enum.join(res, "")
 
  end

  defp getMapo([], mapt), do: mapt
  defp getMapo([head|tail], mapt) do
   
     data = String.split(head, ";")
     if length(data) == 3 && Enum.at(data, 2) in ["win", "draw", "loss"] do
       group1 = Enum.at(data, 0)
       group2 = Enum.at(data, 1)
       result = Enum.at(data, 2)
       mapt = check_group(group1, mapt)
       mapt = check_group(group2, mapt)
       mapt = check_group(group1, group2, result, mapt)
      
       mapt = getMapo(tail, mapt)
     else
 
       mapt = getMapo(tail, mapt)
     end
  end

  defp check_group(group, mapt) do
     if !mapt[group] do
        Map.put(mapt, group, %{:win => 0, :draw => 0, :lose => 0, :mp => 0})
     else
        mapt
     end
  end

  defp check_group(group1, group2, result, mapt) do
     g1map = mapt[group1]
     g2map = mapt[group2]
  
     cond do
        result == "win" -> 
           g1map = %{g1map | :win => g1map.win + 1, :mp => g1map.mp + 3}
           g2map = %{g2map | :lose => g2map.lose + 1}
            mapt = Map.put(mapt, group1, g1map) 
            Map.put(mapt, group2, g2map)
        result == "draw" ->
           g1map = %{g1map | :draw => g1map.draw + 1, :mp => g1map.mp + 1}
           g2map = %{g2map | :draw => g2map.draw + 1, :mp => g2map.mp + 1}
            mapt = Map.put(mapt, group1, g1map)
            Map.put(mapt, group2, g2map)    
        result == "loss" -> 
           g2map = %{g2map | :win => g2map.win + 1, :mp => g2map.mp + 3}
           g1map = %{g1map | :lose => g1map.lose + 1}
           mapt = Map.put(mapt, group1, g1map)
           Map.put(mapt, group2, g2map)
        true -> mapt   
     end

  end
  
end
