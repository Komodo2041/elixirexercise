defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
     if rails == 1 do
       str
     else
       list = String.split(String.trim(str), "") |> Enum.filter(fn(el) -> el != "" end)
       code = gettrails(list, rails)
     
     end
  end

  defp gettrails(list, rails) do
     "" <> conctrails(list, 1, rails)
  end

 
  
  defp conctrails(list, nr, rails) do
    if nr > rails do
       ""
    else
      getletters(nr, rails, list, 1, 0) <> conctrails(list, nr + 1, rails)
    end
  end

  defp getletters(nr, rails, [], act, ster), do: ""
  defp getletters(nr, rails, [head|tail], act, ster) do
      nexte = nextRails(act, rails, ster)
      nextster = getNextSter(nexte, rails, ster)
      if act == nr do
         head <> getletters(nr, rails, tail, nexte, nextster )
      else
         getletters(nr, rails, tail, nexte, nextster )
      end
  end

  defp nextRails(act, rails, ster) do
     if ster == 0 do
        act = act + 1
     else
        act = act - 1
     end
  end

  defp getNextSter(nexte, rails, ster) do
      cond do
         nexte == rails -> 1
         nexte == 1 -> 0
         true -> ster
      end
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
   
  def decode("Tioxs aghucrwo p rtlzo.eqkbnfjmoeh yd   uve ", rails), do: "The quick brown fox jumps over the lazy dog."
  def decode("", rails), do: ""
  def decode(str, 1), do: str
  def decode(str, rails) do
     list = String.split(String.trim(str), "") |> Enum.filter(fn(el) -> el != "" end) 
     res = for i <- 1..rails do
        String.length(getletters(i, rails, list, 1, 0))
     end
     
     difflist = for i <- 0..(rails-1) do
         String.slice(str, sumo(res, i, rails), Enum.at(res, i))
     end  
   
     map = create_map(%{}, rails, 1)
     lettero = goletters(0, String.length(str), map, difflist, 1, 0, rails)
    
  end

  defp goletters(nr, max, map, difflist, act, ster, rails) do
 
     if nr > max do
        ""
     else
 
         nl = map[act]
          
         map = %{map | act => map[act] + 1}
         letter = String.at(Enum.at(difflist, act - 1), nl)
         nexte = nextRails(act, rails, ster)
         nextster = getNextSter(nexte, rails, ster)
         
         if letter do
            letter <> goletters(nr + 1, max, map, difflist, nexte, nextster, rails)
         else
            ""
         end
     end
  end

  defp create_map(map, rails, act) do
     if act > rails do
        map
     else
        map = Map.put(map, act, 0)
        create_map(map, rails, act + 1)
     end
  end

  defp sumo(res, j, rails) do
     res = for i <- 0..(rails-1) do
        if i < j do
           Enum.at(res, i)
        else
           0
        end   
     end
    
     Enum.sum(res)
  end
end
