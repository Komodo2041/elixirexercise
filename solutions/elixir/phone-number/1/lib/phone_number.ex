defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
     raw = String.replace(raw, "(", "") |> String.replace(")", "") |> String.replace("-", "")  |> String.replace(" ", "")  |> String.replace(".", "") |> String.replace("+", "")
     IO.inspect(raw)
     {res, raw} = searchnumber(raw)
      if res == :error do
         {res, raw}
      else
         checknumber(raw)
      end
  end

 defp searchnumber(raw) do
     l = String.length(raw)
     cond do
        Regex.match?(~r/[a-z@]+/, raw) -> {:error, "must contain digits only"}
        l == 10 -> {:ok, raw}
        l < 10 -> {:error, "must not be fewer than 10 digits"}
        l == 11 -> if String.at(raw, 0) == "1" do
            {:ok, String.slice(raw, 1, 11)}
         else
            {:error, "11 digits must start with 1"}
         end
        l >= 12 -> {:error, "must not be greater than 11 digits"}
        true -> {:ok, raw}
     end
 end

 defp checknumber(raw) do
    cond do
       String.at(raw, 0) == "0" -> {:error, "area code cannot start with zero"}
       String.at(raw, 0) == "1" -> {:error, "area code cannot start with one"}
       String.at(raw, 3) == "0" -> {:error, "exchange code cannot start with zero"}
       String.at(raw, 3) == "1" -> {:error, "exchange code cannot start with one"}
       true -> {:ok, raw}
    end
   
 end
  
end
