defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) do
      if (number >= 0 && number < 1000000000000) do
         n = numero(number)
         {:ok, delbadstring(create_number(n))}
      else
         {:error, "number is out of range"}
      end
 
  end

  defp delbadstring(string) do
     string |> String.replace(" zero million", "") |> String.replace(" zero thousand", "") |> String.replace(" zero", "")
  end

  defp create_number(n) do
     cond do
        length(n) == 1 -> Enum.at(n, 0)
        length(n) == 2 -> Enum.at(n, 1) <> " thousand " <> Enum.at(n, 0)
        length(n) == 3 -> Enum.at(n, 2) <> " million " <> Enum.at(n, 1) <> " thousand " <> Enum.at(n, 0)
        length(n) == 4 -> Enum.at(n, 3) <> " billion " <> Enum.at(n, 2) <> " million " <> Enum.at(n, 1) <> " thousand " <> Enum.at(n, 0)
        true -> "zero"
     end
  end

  defp numero(number) do
      first = div(number, 1000)
      rest = rem(number, 1000)
      if (first > 0) do
         [String.trim(numbertosto(rest ))] ++ numero(first)
      else
         [String.trim(numbertosto(rest ))]
      end
  end

  defp numbertosto(nr) do
     h = div(nr, 100)
     rem = rem(nr, 100)
     if (rem > 19) do
        d = div(rem ,10)
        i = rem(rem, 10)
        if h == 0 do
            if i == 0 do
                overtwenty(d)
            else
                overtwenty(d) <> "-" <> zerototwenty(i)
            end
        else 
            zerototwenty(h) <> " hundred " <> overtwenty(d) <> "-" <> zerototwenty(i, true)
        end        
     else
        if h == 0 do
            zerototwenty(nr)
        else
            zerototwenty(h) <> " hundred " <> zerototwenty(rem, true)
        end
        
         
     end
  end

  defp zerototwenty(nr, bool \\ false) do
     if bool == true && nr == 0 do
         ""
     else
       case nr do
          0 -> "zero"
          1 -> "one"
          2 -> "two"
          3 -> "three"
          4 -> "four"
          5 -> "five"
          6 -> "six"
          7 -> "seven"
          8 -> "eight"
          9 -> "nine"
          10 -> "ten"
          11 -> "elf"
          12 -> "twelve"
          13 -> "theerteen"
          14 -> "fourteen"
          15 -> "fiveteen"
          16 -> "sixteen"
          17 -> "seventeen"
          18 -> "eightteen"
          19 -> "nineteen"
       end     
     end
 
  end

  defp overtwenty(nr) do
     case nr do 
        2 -> "twenty"
        3 -> "thirty"
        4 -> "forty"
        5 -> "fifty"
        6 -> "sixty"
        7 -> "seventy"
        8 -> "eighty"  
        9 -> "ninety" 
      end  
  end
end
