defmodule GoCounting do
  @type position :: {integer, integer}
  @type owner :: %{owner: atom, territory: [position]}
  @type territories :: %{white: [position], black: [position], none: [position]}

  @doc """
  Return the owner and territory around a position
  """
  @spec territory(board :: String.t(), position :: position) ::
          {:ok, owner} | {:error, String.t()}
  def territory(board, {x, y} = pos) when x < 0, do: {:error, "Invalid coordinate"}
  def territory(board, {x, y} = pos) when y < 0, do: {:error, "Invalid coordinate"} 
 
  def territory(board, {x, y} = pos) do
      table = String.split(board, "\n") |> Enum.map(fn(el) -> String.split(el, "") |> Enum.filter(fn(s) -> s != "" end) end)
      IO.inspect([x, y])
      IO.inspect(table)
      if (y >= length(table) - 1 && y != 0)  || x >= length(Enum.at(table, 0)) do
         {:error, "Invalid coordinate"} 
      else 
         {all_c, color } = goteritorium(table, x, y)
         {:ok, %{:owner => color, :territory => all_c}} 
      end   
 
    
  end

  defp goteritorium(table, x, y ) do
     el = pos(table, x, y)
    
   
     {used, result, border} = getallneighors(table, x, y, [], [], [])
  
     border = Enum.uniq(border)
     res = goallResult(result, table, border)
     color = getColorFromBorder(border, res)
     {res, color}
  end

  defp getColorFromBorder(border, []), do: :none
  defp getColorFromBorder(border, res) do
    if length(border) == 1 do
       if Enum.at(border, 0) == "B" do
          :black
       else
          :white
       end
    else
       :none
    end
  end

  defp goallResult(result, table, border) do
     size = length(table) * length(Enum.at(table, 0))
     
     if length(result) <= size do
        goresulttupple(Enum.sort(result))
     else
        []
     end
  end

  defp goresulttupple([]), do: [] 
  defp goresulttupple([head|tail]) do 
    res = String.split(head, "-")
    [{String.to_integer(Enum.at(res, 0)), String.to_integer(Enum.at(res, 1))}] ++ goresulttupple(tail)
  end

  defp getallneighors(table, x, y, used, result, border) do
 
     key = getKeys(x, y) 
     res = pos(table, x, y) 
 
     if key in used || res == "X" || res == "B" || res == "W" do
        if res == "B" || res == "W" do
           border = border ++ [res]
           {used, result, border}
        else
           {used, result, border}
        end
         
     else 
        used = used ++ [key]
        result = result ++ [key] 
     
        {used, result, border} = getallneighors(table, x - 1, y, used, result, border) 
        {used, result, border} = getallneighors(table, x + 1, y, used, result, border) 
        {used, result, border} = getallneighors(table, x, y - 1, used, result, border)
            
        {used, result, border} = getallneighors(table, x, y + 1, used, result, border)
           
        {used, result, border}
       
     end
  end


  defp getKeys(x, y) do
    Integer.to_string(x) <> "-" <> Integer.to_string(y)
  end

  defp getCharColor(:black), do: "B"
  defp getCharColor(:white), do: "W"

  defp pos(table, x, y) do
   
    max_x = length(Enum.at(table, 0))   
    max_y = length(table) 
    
    if x >= 0 && y >= 0 && x < max_x  && y < max_y && Enum.at(Enum.at(table, y), x) do
       Enum.at(Enum.at(table, y), x)
    else
        "X"
    end
  end
 
  @doc """
  Return all white, black and neutral territories
  """
  @spec territories(board :: String.t()) :: territories
  def territories(board) do
       table = String.split(board, "\n") |> Enum.map(fn(el) -> String.split(el, "") |> Enum.filter(fn(s) -> s != "" end) end)
       max_x = length(Enum.at(table, 0)) - 1
       max_y = length(table) - 2
       res = for y <- 0..max_y,
          x <- 0..max_x,
          into: [],
          do: GoCounting.territory(board, {x, y})

       res = Enum.filter(res, fn({res2, map}) -> res2 == :ok end) |> Enum.uniq
       map = %{:black => [], :white => [], :none => []}
       map = calcall(res, map)  
       
    
  end

  defp calcall([], map), do: map 
  defp calcall([head|tail], map) do
    {res, small} = head
    owner = small.owner
    
     map = Map.put(map, owner, map[owner] ++ small.territory)
   
    calcall(tail, map)
  end
  
end
