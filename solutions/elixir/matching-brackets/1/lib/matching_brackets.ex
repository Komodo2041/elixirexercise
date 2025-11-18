defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
     brackets = Regex.replace(~r/[^\[\]\{\}\(\)]/, str, "")
     
     res = delbracker(brackets)
    
     if res == "" do
        true
     else
        false
     end   
  end

  defp delbracker(brackets) do
  IO.inspect(brackets)
  
     cond do
         String.replace(brackets, "[]", "") != brackets -> delbracker(String.replace(brackets, "[]", ""))
         String.replace(brackets, "{}", "") != brackets -> delbracker(String.replace(brackets, "{}", ""))
         String.replace(brackets, "()", "") != brackets -> delbracker(String.replace(brackets, "()", ""))   
         true -> brackets
     end
   end   
     
   
end
