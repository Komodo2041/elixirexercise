defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
       String.trim(input) == ""   -> "Fine. Be that way!"
       String.upcase(input) == input && String.ends_with?(input, "?") && String.match?(input, ~r/[A-Z]+/) -> "Calm down, I know what I'm doing!"
       String.upcase(input) == input && String.match?(input, ~r/[A-ZУХОДИ]+/) -> "Whoa, chill out!"  
       String.ends_with?(String.trim(input), "?") -> "Sure."
       true -> "Whatever."
    end
  end
end
