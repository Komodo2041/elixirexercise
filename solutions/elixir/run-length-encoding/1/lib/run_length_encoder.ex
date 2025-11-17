defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
      res = String.graphemes(string)
      new = getString(res, "", 0)
      Enum.join(new, "")  
      
  end

  defp getString([], x, nr) do
      if nr > 1 do 
          [Integer.to_string(nr) <> x]
      else 
          [x] 
      end 
  end    
  defp getString([head|tail], x, nr) do
  IO.inspect(nr)
     if x == head || x == "" do
         getString(tail, head, nr + 1)
        
     else
        if nr > 1 do 
           [Integer.to_string(nr) <> x] ++ getString(tail, head, 1)
        else
           [x] ++ getString(tail, head, 1)
         end 
     end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
      new = breakstring(String.graphemes(string), "")
      IO.inspect(new)
      expandstring(new)
  end

   defp breakstring([],  nr), do: []
   defp breakstring([head|tail], nr) do
       if head in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"] do
           breakstring(tail, nr <> head)
       else
           if nr == "" do
              [["1", head]] ++ breakstring(tail, "")
           else
              [[nr, head]] ++ breakstring(tail, "")
           end
       end
   end

   defp expandstring([]), do: ""
   defp expandstring([[nr, c]|tail]) do
       nr = String.to_integer(nr)
       createlongstring(nr, c)  <> expandstring(tail)
   end

   defp createlongstring(0, c), do: ""
   defp createlongstring(nr, c) do
       c <> createlongstring(nr - 1, c)
   end
  
end
