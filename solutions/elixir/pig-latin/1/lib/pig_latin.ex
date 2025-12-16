defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
     phs = String.split(phrase, " ")
     phrease = Enum.map(phs, fn(el) -> rule2(rule1(el)) end) 
     
    phrase = Enum.join(phrease, " ")
     IO.inspect(phrase)
     phrase
  end

  defp rule1(phrase) do
    cond do
       String.at(phrase, 0) in ["a", "e", "i" , "u", "o"] -> phrase <> "ay"
       String.at(phrase, 0) == "x" && String.at(phrase, 1) == "r" ->  phrase <> "ay"
       String.at(phrase, 0) == "y" && String.at(phrase, 1) == "t" ->  phrase <> "ay"
       true -> phrase  
    end
  end

  defp rule2(phrase) do
     list = String.graphemes(phrase)
     phraseres = createrule2(list, "", phrase )
     
  end


   defp createrule2([], endstring, phrase ), do: rule2use(endstring, phrase)
   defp createrule2([head|tail], endstring, phrase ) do
    
       if head in ["a", "e", "i", "y", "u", "o", "q", "x" ] do
           [h2|t2] = gotail(tail)
           cond do
              head == "q" && h2 == "u" ->  createrule2(t2, endstring <> head <> h2, phrase)
              head == "q" -> createrule2(tail, endstring <> head, phrase)
              endstring == "" && head == "x" && h2 == "r" -> phrase
              endstring == "" && head == "y" && h2 == "t" -> phrase
              head == "x" -> createrule2(tail, endstring <> head, phrase)
              head == "y" && endstring == "" -> createrule2(tail, endstring <> head, phrase)
              true -> rule2use(endstring, phrase)
           end
 
       else
          createrule2(tail, endstring <> head, phrase)
       end
   end

   defp gotail(tail) do
     if tail == [] do
       ["", []]
     else
       tail
     end
   end

   defp rule2use(endstring, phrase) do
     if endstring == "" do
        phrase
     else
        String.replace(phrase, endstring, "") <> endstring <> "ay"
     end
   end
  
end
