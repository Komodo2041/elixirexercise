defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  
  def chain?([]), do: true
  def chain?(dominoes) do
     max = 2 * length(dominoes)
    {one, two} = Enum.at(dominoes, 0)
    chains = get_chain(List.delete_at(dominoes, 0), [one, two] , two, [])
    chain = Enum.reduce(chains, Enum.at(chains, 0), fn(el, acc) -> if length(acc) <  length(el) do el else acc end end)
    chain
     if length(chain) == max && Enum.at(chain, 0) == Enum.at(chain, max - 1) do
        true
     else
        false
     end   
  end

  defp get_chain([], chain, _, chains), do: [chain | chains] 
  defp get_chain(dominoes, chain, tocheck, chains) do
      ids = getnr(dominoes, tocheck, 0)
      checkways(ids, dominoes, chain, tocheck, chains )
  end

  defp checkways([], dominoes, chain, tocheck, chains), do: chains
  defp checkways([id|ids], dominoes, chain, tocheck, chains) do
   
      if id >= 0 do
         {e1, e2} = Enum.at(dominoes, id)
         if e1 == tocheck do
            get_chain(List.delete_at(dominoes, id), chain ++ [e1] ++ [e2] , e2, chains) 
             ++ checkways(ids, dominoes, chain, tocheck, chains )
         else
            get_chain(List.delete_at(dominoes, id), chain ++ [e2] ++ [e1] , e1, chains) 
             ++ checkways(ids, dominoes, chain, tocheck, chains )
         end 
      else
         [chain | chains]  
      end
  end

  defp getnr([], tocheck, nr), do: [-1]
  defp getnr([head|tail], tocheck, nr) do
     {a, b} = head
     if a == tocheck || b == tocheck do
        [nr] ++ getnr(tail, tocheck, nr + 1)
     else
        getnr(tail, tocheck, nr + 1)
     end
  end

  defp getDomino([]), do: []
  defp getDomino([head|tail]) do
      [elem(head, 0), elem(head, 1)] ++ getDomino(tail)
  end

  
end
