defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
     case category do
      :yacht -> if Enum.at(dice, 0) == Enum.at(dice, 1) && Enum.at(dice, 1) == Enum.at(dice, 2)  do 50 else 0 end
      :choice -> Enum.sum(dice)
      :big_straight -> teststright(dice, 6)
      :little_straight -> teststright(dice, 5)
      :ones -> calc(1, dice)
      :twos -> calc(2, dice)
      :threes -> calc(3, dice)
      :fours -> calc(4, dice)
      :fives -> calc(5, dice)
      :sixes  -> calc(6, dice)
      :full_house -> full_house(dice)
      :four_of_a_kind -> fourkind(dice)
      _ -> 500
     end
  end

  defp calc(nr, dice) do
    nr * Enum.reduce(dice, 0, fn(el, acc) -> if nr == el do acc + 1 else acc end end )
  end

  defp full_house(dice) do
    dice = Enum.sort(dice)
    if (Enum.at(dice, 0) == Enum.at(dice, 1) && Enum.at(dice, 1) == Enum.at(dice, 2) && Enum.at(dice, 3) == Enum.at(dice, 4) && Enum.at(dice, 0) != Enum.at(dice, 3)) ||
    (Enum.at(dice, 4) == Enum.at(dice, 3) && Enum.at(dice, 3) == Enum.at(dice, 2) && Enum.at(dice, 1) == Enum.at(dice, 0) && Enum.at(dice, 0) != Enum.at(dice, 2) ) do
      Enum.sum(dice)
    else
       0
    end
  end

  defp fourkind(dice) do
     dice = Enum.sort(dice)
     if (Enum.at(dice, 0) == Enum.at(dice, 1) && Enum.at(dice, 1) == Enum.at(dice, 2) && Enum.at(dice, 2) == Enum.at(dice, 3)) || (Enum.at(dice, 1) == Enum.at(dice, 2) && Enum.at(dice, 2) == Enum.at(dice, 3) && Enum.at(dice, 3) == Enum.at(dice, 4))  do
        4 * Enum.at(dice, 1)
     else
        0
     end
  end

  defp teststright(dice, nr) do
     dice = Enum.sort(dice, :desc)
    
     if Enum.at(dice, 0) == Enum.at(dice, 1) + 1 && Enum.at(dice, 1) == Enum.at(dice, 2) + 1 && Enum.at(dice, 2) == Enum.at(dice, 3) + 1 && Enum.at(dice, 3) == Enum.at(dice, 4) + 1  && Enum.at(dice, 0) == nr do
      30
    else
      0
    end  
  end
  
end
