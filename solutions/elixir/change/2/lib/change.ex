defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
   def generate(coins, target) when target < 0, do: {:error, "cannot change"}
   def generate(coins, target) when target == 0, do: {:ok, []}
  def generate(coins, target) do
     coins = Enum.sort(coins, :desc)
     posibility = get_possibility(coins, target, [])
   
     if length(posibility) == 0 do
        {:error, "cannot change"}
     else
       posibility = Enum.filter(posibility, fn(el) -> el != [] end)
       posibility = Enum.sort_by(posibility, fn(el) ->  length(el) end)
      
      if Enum.sum(Enum.at(posibility,0)) == target do
        {:ok, Enum.sort(Enum.at(posibility,0))}
      else
         {:error, "cannot change"}
      end
     end
 
  end

  defp get_possibility([], search, found )  do
    if search == 0 do
       [found]
    else
       []
    end
  end
  
  defp get_possibility([head|tail], search, found ) do
     if search >= 0 do
       nrs = floor(search/head)
       all = []
       if nrs == 0 do
          get_possibility(tail, search, found)
       else
          all = all ++ get_possibility(tail, search, found)
          all = all ++ get_possibility(tail, search - head, found ++ [head])
          all = all ++ get_possibility(tail, search - 2 * head, found ++ [head, head])
          all = all ++ get_possibility(tail, search - 3 * head, found ++ [head, head, head])
          all = all ++ get_possibility(tail, search - 4 * head, found ++ [head, head, head, head])
          all = all ++ get_possibility(tail, search - 9 * head, found ++ [head, head, head, head, head, head, head, head, head])
          all  
      end   
      else 
          []
      end    
  end

  defp getlistcoins(0, head), do: []
  defp getlistcoins(nrs, head) do
    res = for _ <- 1..nrs do
       head
    end
    res
  end
  
end
