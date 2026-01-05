defmodule RelativeDistance do
  @doc """
  Find the degree of separation of two members given a given family tree.
  """
  @spec degree_of_separation(
          family_tree :: %{String.t() => [String.t()]},
          person_a :: String.t(),
          person_b :: String.t()
        ) :: nil | pos_integer()
  def degree_of_separation(family_tree, person_a, person_b) do
 
   keys = Map.keys(family_tree)
   res = searcho(keys, family_tree, person_a, person_b, keys)
   if res == [] do
      nil
   else   
      tree = getfour(res)
      if tree do
        one = searcho2(keys, family_tree, person_a, tree, keys)
        #two = searcho2(keys, family_tree, person_b, tree, keys)
        one
      else
            IO.inspect(res)
         if length(res) > 10 do
           #sibblings
           length(res) - 1
         else
            length(res)
         end
      end
   end   
  end

  defp searcho([], family_tree, person_a, person_b, keys), do: []
  defp searcho([head|tail], family_tree, person_a, person_b, keys) do
   
     cond do
        head == person_a && person_b in family_tree[head]  -> [[person_a, person_b]]
        head == person_b && person_a in family_tree[head] ->[[person_b, person_a]]
        person_a in family_tree[head] && person_b in family_tree[head] -> [[person_a, person_b, "*"]]
        person_b in family_tree[head] ->  
          [[head, person_b]] ++ searcho(keys, family_tree, head, person_a, keys)   
        person_a in family_tree[head] ->
          
         [[head, person_a]] ++ searcho(keys, family_tree, head, person_b, keys)  
 
        true -> searcho(tail, family_tree, person_a, person_b, keys)
     end
  end

  defp searcho2([], family_tree, person_a, person_b, keys), do: nil
  defp searcho2([head|tail], family_tree, person_a, person_b, keys) do
   
     cond do
        head == person_a && person_b in family_tree[head]  -> 1
        head == person_b && person_a in family_tree[head] -> 1
        person_a in family_tree[head] && person_b in family_tree[head] -> 1
        person_b in family_tree[head] ->  
          1 + searcho2(keys, family_tree, head, person_a, keys)   
        person_a in family_tree[head] ->
          
          1 + searcho2(keys, family_tree, head, person_b, keys)  
 
        true -> searcho2(tail, family_tree, person_a, person_b, keys)
     end
  end

 defp getfour(reso) do
    all = Enum.reduce(reso, [], fn(el, acc) -> 
      acc = acc ++ [Enum.at(el, 0)]
      acc = acc ++ [Enum.at(el, 1)]
      end)
    res = calco(all)
    
    res
 end

defp calco([]), do: nil
defp calco([head|tail]) do
   demio = Enum.reduce(tail, 1, fn(el, acc) -> if el == head do acc + 1 else acc end  end)
 
   if demio == 4 do
      head
   else
      calco(tail)
   end
end
 
 
end
