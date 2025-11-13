defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    
     Enum.filter(candidates, fn(str) -> Anagram.pom(base) == Anagram.pom(str) && String.downcase(base) != String.downcase(str) end)
      
  end

  def pom(str) do
   
    str |> String.downcase() |> String.to_charlist() |> Enum.sort()
    
    
  end
end
