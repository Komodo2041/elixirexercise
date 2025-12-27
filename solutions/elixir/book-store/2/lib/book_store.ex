defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total([]), do: 0
  def total(basket) do
     freq = Enum.frequencies(basket)
     basketsort = Enum.sort(basket, fn(e1, e2) -> freq[e1] > freq[e2] end) 
     one = calc(basketsort, 0, 5)
     two = calc(basketsort, 0, 4)
     
     if one > two do
        two
     else
        one
     end   
  end

  defp calc([], acc, _), do: acc
  defp calc(basket, acc, nr) do
     choosen = choosedifferent(basket, [], nr)
 
     price = calcprice(choosen)
     acc = acc + price
     basket = basket -- choosen
     calc(basket, acc, nr)
  end

  defp choosedifferent([], acc, nr), do: acc
  defp choosedifferent([head|tail], acc, nr) do
     if head in acc do
        choosedifferent(tail, acc, nr)
     else
        acc = acc ++ [head]
        cond do
           length(acc) >= nr -> acc 
           true -> choosedifferent(tail, acc, nr)
        end
 
     end
  end

  defp calcprice(basket) do
     price = 800 * length(basket)
     case length(basket) do
        0 -> price
        1 -> price
        2 -> round(0.95 * price)
        3 -> round(0.9 * price)
        4 -> round(0.8 * price)
        5 -> round(0.75 * price)
     end
  end
  
  
end
