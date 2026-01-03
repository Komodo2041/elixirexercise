defmodule Camicia do
  @doc """
    Simulate a card game between two players.
    Each player has a deck of cards represented as a list of strings.
    Returns a tuple with the result of the game:
    - `{:finished, cards, tricks}` if the game finishes with a winner
    - `{:loop, cards, tricks}` if the game enters a loop
    `cards` is the number of cards played.
    `tricks` is the number of central piles collected.

    ## Examples

      iex> Camicia.simulate(["2"], ["3"])
      {:finished, 2, 1}

      iex> Camicia.simulate(["J", "2", "3"], ["4", "J", "5"])
      {:loop, 8, 3}
  """

  @spec simulate(list(String.t()), list(String.t())) ::
          {:finished | :loop, non_neg_integer(), non_neg_integer()}
  def simulate(player_a, player_b) do
     actround = getnameround(player_a, player_b)
     res = game(:one, player_a, player_b, [], 0 ,0, 0, 0, [actround])
     res
  end

defp game(:one, player_a, player_b, stack, x, y, c, t, round) when t > 1200 do
   {:loop, c, t }
end

defp game(:two, player_a, player_b, stack, x, y, c, t, round) when t > 1200 do
   {:loop, c, t }
end

 defp game(:one, [], [], stack, x, y, c, t, round) do
    {:finished, c, t + 1 }
 end

 defp game(:two, [], [], stack, x, y, c, t, round) do
    {:finished, c, t  + 1 }
 end

 defp game(:one, [], player_b, stack, x, y, c, t, round) do
    {:finished, c, t + 1}
 end
 
 defp game(:one, [head|player_a], player_b, stack, 0, y, c, t, round) do
    stack = stack ++ [head]
    if valuecard(head) > 10 do
       game(:two, player_a, player_b, stack, 0, due(head), c + 1, t, round) 
 
    else
       game(:two, player_a, player_b, stack, 0, 0, c + 1, t, round) 
    end
 end

 defp game(:one, [head|player_a], player_b, stack, x, y, c, t, round) do
    stack = stack ++ [head]
    if valuecard(head) > 10 do
       game(:two, player_a, player_b, stack, 0, due(head), c + 1, t, round) 
    else
       if x == 1   do
          player_b = player_b ++ stack
          if length(player_a) == 0 do
              {:finished, c + 1, t + 1}
          else
              actround = getnameround(player_a, player_b)
              if actround in round do
                   {:loop, c + 1, t + 1}
              else          
                 round = round ++ [actround] 
                 game(:two, player_a, player_b, [], x - 1, 0, c + 1, t + 1, round) 
             end    
          end
       else
          game(:one, player_a, player_b, stack, x - 1, 0, c + 1, t, round) 
       end
    end
 end

 defp game(:two, player_a, [], stack, x, y, c, t, round) do
    {:finished, c, t + 1}
 end

 defp game(:two, player_a, [head|player_b], stack, x, 0, c, t, round) do
    stack = stack ++ [head]
    if valuecard(head) > 10 do
       game(:one, player_a, player_b, stack, due(head), 0, c + 1, t, round) 
    else
       game(:one, player_a, player_b, stack, 0, 0, c + 1, t, round) 
    end
 end

 defp game(:two, player_a, [head|player_b], stack, x, y, c, t, round) do
    stack = stack ++ [head]
    if valuecard(head) > 10 do
       game(:one, player_a, player_b, stack, due(head), 0, c + 1, t, round) 
    else
       if y == 1   do
          player_a = player_a ++ stack
          if length(player_b) == 0 do
               {:finished, c + 1, t + 1}
          else
              actround = getnameround(player_a, player_b)
              if actround in round do
                   {:loop, c + 1, t + 1}
              else
                  round = round ++ [actround]
                  game(:one, player_a, player_b, [], 0, y - 1, c + 1, t + 1, round) 
              end
              
          end 
       else
          game(:two, player_a, player_b, stack, 0, y - 1, c + 1, t, round) 
       end       
    end
 end

 defp getnameround(player_a, player_b) do
    one = Enum.reduce(player_a, "", fn(el, acc) -> acc <> getchar(el) end)
    two = Enum.reduce(player_b, "", fn(el, acc) -> acc <> getchar(el) end)
    one <> "#" <> two
 end

 defp getchar(el) do
   case el do
      "A" -> "A"
      "K" -> "K"
      "Q" -> "Q"
      "J" -> "J"
      _ -> "_"
   end
 end
 
  defp valuecard(card) do
     case card do
        "A" -> 14
        "K" -> 13
        "Q" -> 12
        "J" -> 11 
        _ -> String.to_integer(card)
     end
  end

  defp due(card) do
     case card do
        "A" -> 4
        "K" -> 3
        "Q" -> 2
        "J" -> 1 
        _ ->  0
     end
  end
end
