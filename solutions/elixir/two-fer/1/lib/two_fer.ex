defmodule TwoFer do
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  
  def two_fer(name \\ "you") do
 
     if !String.valid?(name) do
         raise UndefinedFunctionError, "function TwoFer.two_fer/0 is undefined or private. Did you mean:"
     end
     
     if (name) do
        "One for " <> name <> ", one for me."
     end
  end
end
