defmodule Poker do
  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
      res = check_hand(hands)
      best = getbesthand(res, -1, [], 0)
      nrs = goodnrs(res, best, 0)
 
      choosehands = gethands(hands, nrs, 0)
      choosehands
  end

  defp gethands([], nrs, act), do: []
  defp gethands([head|tail], nrs, act) do
    if act in nrs do
      [head] ++ gethands(tail, nrs, act + 1) 
    else
       gethands(tail, nrs, act + 1) 
    end
  end

  defp goodnrs([], best, pos), do: []
  defp goodnrs([head|tail], best, pos) do
     if head == best do
        [pos] ++ goodnrs(tail, best, pos+1)
     else
        goodnrs(tail, best, pos+1)
     end
  end

  defp getbesthand([], nr, best, act), do: best
  defp getbesthand([head|tail], nr, best, act) do
     if nr == -1 do
        getbesthand(tail, 0, head, act + 1)
     else
        cond do
        Enum.at(head, 0) > Enum.at(best, 0) -> getbesthand(tail, act, head, act + 1) 
        Enum.at(head, 0) == Enum.at(best, 0) && Enum.at(head, 1) > Enum.at(best, 1) -> getbesthand(tail, act, head, act + 1) 
        Enum.at(head, 0) == Enum.at(best, 0) && Enum.at(head, 1) == Enum.at(best, 1) && Enum.at(head, 2) > Enum.at(best, 2)-> getbesthand(tail, act, head, act + 1) 
        Enum.at(head, 0) == Enum.at(best, 0) && Enum.at(head, 1) == Enum.at(best, 1) && Enum.at(head, 2) == Enum.at(best, 2) && Enum.at(head, 3) > Enum.at(best, 3)-> getbesthand(tail, act, head, act + 1) 
                Enum.at(head, 0) == Enum.at(best, 0) && Enum.at(head, 1) == Enum.at(best, 1) && Enum.at(head, 2) == Enum.at(best, 2) && Enum.at(head, 3) == Enum.at(best, 3) && Enum.at(head, 4) > Enum.at(best, 4) -> getbesthand(tail, act, head, act + 1) 
 Enum.at(head, 0) == Enum.at(best, 0) && Enum.at(head, 1) == Enum.at(best, 1) && Enum.at(head, 2) == Enum.at(best, 2) && Enum.at(head, 3) == Enum.at(best, 3) && Enum.at(head, 4) == Enum.at(best, 4) && Enum.at(head, 5) > Enum.at(best, 5)  -> getbesthand(tail, act, head, act + 1) 
        true -> getbesthand(tail, nr, best, act + 1) 
        end
     end
  end

  defp check_hand([]), do: []
  defp check_hand([head|tail]) do
     [seehand(head)] ++ check_hand(tail)
  end

  defp seehand(hand) when length(hand) != 5, do: 0
  defp seehand(hand) do
     hand = Enum.map(hand, fn(el) -> String.split(String.replace(el, "10", "D"), "") |> Enum.filter(fn(el) -> el != "" end) end)
    
     position = get_position()
     hand = Enum.sort(hand, fn(el1, el2) -> position[Enum.at(el1, 0)] > position[Enum.at(el2, 0)] end)
     histhand = gethist(hand)
      
     cond do
        checkroyalflush(hand, position) -> [10, checksmallstright(position, hand)] ++ listcardwins(hand, position)
        checkpoker(hand, position) -> [9, checksmallstright(position, hand)] ++ listcardwins(hand, position)
        elem(Enum.at(histhand, 0), 1) == 4 -> [8, position[elem(Enum.at(histhand, 0), 0)]] ++ listcardwins(hand, position)
        elem(Enum.at(histhand, 0), 1) == 3 && elem(Enum.at(histhand, 1), 1) == 2 -> [7, position[elem(Enum.at(histhand, 0), 0)]] ++ listcardwins(hand, position)
        checkcolorhand(hand) -> [6, position[firstcardone(hand)]] ++ listcardwins(hand, position)
        checkstright(hand, position) -> [5, checksmallstright(position, hand)] ++ listcardwins(hand, position)
        elem(Enum.at(histhand, 0), 1) == 3 -> [4, position[elem(Enum.at(histhand, 0), 0)]] ++ listcardwins(hand, position)
         elem(Enum.at(histhand, 0), 1) == 2 && elem(Enum.at(histhand, 1), 1) == 2 -> [3, position[elem(Enum.at(histhand, 0),0)], position[elem(Enum.at(histhand, 1),0)]] ++ listcardwins(hand, position)
        elem(Enum.at(histhand, 0), 1) == 2 ->  [2, position[elem(Enum.at(histhand, 0), 0)]] ++ listcardwins(hand, position)
        true ->  [1, position[firstcardone(hand)]] ++ listcardwins(hand, position)
     end
  end

  defp checksmallstright(position, hand) do
   
      if cardpos(hand, 0) == "A" && cardpos(hand, 1) == "5"  do
         0
      else
         position[firstcardone(hand)]
      end
  end

  defp listcardwins(hand, position) do
 
    [position[cardpos(hand, 0)], position[cardpos(hand, 1)], position[cardpos(hand, 2)], position[cardpos(hand, 3)], position[cardpos(hand, 4)]]
  end

  defp get_position() do
    %{"1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "D" => 10, 
     "J" => 11, "Q" => 12, "K" => 13, "A" => 14}
  end

  defp firstcardone(hand) do
     Enum.at(Enum.at(hand, 0), 0)
  end
 
  defp checkroyalflush(hand, position) do
     iscolor = checkcolorhand(hand)
     isposition = checkstright(hand, position)
     firstass = cardpos(hand, 0) == "A" && cardpos(hand, 1) == "K"
     iscolor && isposition && firstass
  end

  defp checkpoker(hand, position) do
     iscolor = checkcolorhand(hand)
     isposition = checkstright(hand, position)
     iscolor && isposition
  end

  defp checkcolorhand(hand) do
     if colorcard(hand, 0) == colorcard(hand, 1) && colorcard(hand, 1) == colorcard(hand, 2) && colorcard(hand, 2) == colorcard(hand, 3) && colorcard(hand, 3) == colorcard(hand, 4) do
        true
     else
        false
     end   
  end

  defp checkstright(hand, position) do
 
    if (position[cardpos(hand, 0)] == position[cardpos(hand, 1)] + 1 && position[cardpos(hand, 1)] == position[cardpos(hand, 2)] + 1 && position[cardpos(hand, 2)] == position[cardpos(hand, 3)] + 1 && position[cardpos(hand, 3)] == position[cardpos(hand, 4)] + 1) || (position[cardpos(hand, 0)] == 14 && position[cardpos(hand, 1)] == position[cardpos(hand, 2)] + 1 && position[cardpos(hand, 2)] == position[cardpos(hand, 3)] + 1 && position[cardpos(hand, 3)] == position[cardpos(hand, 4)] + 1 ) do
       true
     else
       false
     end  
  end

  defp colorcard(hand, nr) do
     Enum.at(Enum.at(hand, nr), 1)
  end

  defp cardpos(hand, nr) do
     Enum.at(Enum.at(hand, nr), 0)
  end

  defp gethist(hand) do
     list = Enum.map(hand, fn(el) -> Enum.at(el, 0) end)
     f = Enum.frequencies(list)
     Enum.sort( Map.to_list(f), fn(el1, el2) -> elem(el1, 1) > elem(el2, 1) end)
     
  end
end
