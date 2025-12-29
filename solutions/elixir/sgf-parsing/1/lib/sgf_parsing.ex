defmodule SgfParsing do
  defmodule Sgf do
    defstruct properties: %{}, children: []
  end

  @type sgf :: %Sgf{properties: map, children: [sgf]}

  @doc """
  Parse a string into a Smart Game Format tree
  """
  @spec parse(encoded :: String.t()) :: {:ok, sgf} | {:error, String.t()}
  def parse(""), do: {:error, "tree missing"}
  def parse(encoded) do
    encoded = String.replace(encoded, "(y)", "#y#")
    encoded = Regex.replace(~r/\[([^[\]]*)\]/, encoded, fn _, inside ->
      "[#{String.replace(inside, ";", "----")}]"
    end)
    
     
    
     nodes = Regex.scan(~r/\({0,1}\;[a-zA-Z0-9\[\]\s\\= \-\#]*\){0,1}/, encoded)
    
     cond do
         nodes == [] -> {:error, "tree with no nodes"}
         checktree(nodes) -> {:error, "tree missing"}
         true -> 
           
            [root|nodes] = nodes
 
            cleannode = String.replace(Enum.at(root, 0), "(", "") |> String.replace(")", "") |> String.replace(";", "")
            {res, propertis} = getpropertis(cleannode)
            children = getChildren(nodes)
        
            if res == :ok do
               map = %Sgf{:properties => propertis, :children => children}
               {:ok, map}
            else
               {res, propertis}
            end 
     end
   
  end

  defp getChildren([]), do: []
  defp getChildren([head|tail]) do
       cleannode = String.replace(Enum.at(head, 0), "(", "") |> String.replace(")", "") |> String.replace(";", "")
      {res, propertis} = getpropertis(cleannode)
      if res == :ok do
         map = %Sgf{:properties => propertis}
         [map] ++ getChildren(tail)
      else
         getChildren(tail)
      end
  end

  defp getpropertis(code) do
   
     map = %{}
      code = String.replace(code, "\t", " ") |> String.replace( "\\\n", "") |> String.replace( "\\n", "n")  
      wirnglo = Regex.run(~r/\\(.){1}/, code)
      
        wirnglo2 = Regex.scan(~r/\\(.){1}/, code)
         
      code = usewringlo(code, wirnglo)
   
     values = Regex.scan(~r/([a-zA-Z0-9])*\[([^]]*)\]/, code)
    # values = Regex.scan(~r/([a-zA-Z0-9]+)\[([a-zA-Z0-9 \n\t\s]*?)\]/, code)
     check = checkValues(values, code)
       
      
     if check > 0 do
       map = setpropertis( values, map, "", wirnglo)
       {:ok, map} 
     else
        case check do
          -1 -> {:error, "properties without delimiter"}
          -2 -> {:error, "property must be in uppercase"}
        end
     end
  end

  defp usewringlo(code, w) do
     if w do
        String.replace(code, Enum.at(w, 0), "###") |> String.replace( "\\\\", "\\")     
     else
        code
     end
  end

  defp checkValues(values, code) do
     if values == [] && code != "" do 
        -1
     else
        if checkuppercase(values) do
           1
        else
           -2
        end
       
     end
  end

  defp checkuppercase([]), do: true
  defp checkuppercase([head|tail]) do
  
     if  Regex.run(~r/[a-z0-9]+/, Enum.at(head, 1)) do
        false
     else   
        checkuppercase(tail)
     end
  end

  defp setpropertis([], map, key, wirnglo), do: map
  defp setpropertis([head|tail], map, key, wirnglo) do
     key = getKey(Enum.at(head, 1), key)
     value = getValueWringlo(Enum.at(head, 2), wirnglo) |> String.replace("----", ";") |> String.replace("#y#", "(y)")  
     if map[key] do
        map = Map.put(map, key, map[key] ++ [value])
        setpropertis(tail, map, key, wirnglo)      
     else
        map = Map.put(map, key, [value])
        setpropertis(tail, map, key, wirnglo)
     end
 
  end

  defp getValueWringlo(value, wringlo) do
    if wringlo do
       String.replace(value, "###", Enum.at(wringlo, 1))
    else
       value
    end
  end

  defp getKey(now, last) do
     if now == "" do
        last
     else
        now
     end
  end

  defp checktree([]), do: false
  defp checktree([head|tail]) do
 
     if head == [";"] do
        true
     else
         checktree(tail)
     end
  end
  
end
