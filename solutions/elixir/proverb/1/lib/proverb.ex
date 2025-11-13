defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite(strings) do
      if (strings != []) do
         Enum.reduce(strings, "", fn (el, acc) -> acc <> Proverb.createPhrase(el, strings ) end)
      else
         ""
      end   
  end
 
  def createPhrase(el, strings ) do
     pos = Enum.find_index(strings, fn name -> name == el end)
     next = Enum.at(strings, pos + 1)
     if (!next) do
         one = Enum.at(strings, 0)
         "And all for the want of a " <> one <> ".\n"
     else
        
        "For want of a " <> el <> " the " <> next <> " was lost.\n"
     end
  end
  
end
