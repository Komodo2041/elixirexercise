defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
     if rem(a, 2) == 0 || rem(a, 13) == 0  do
         {:error, "a and m must be coprime."}
     else
     
       str  = String.replace(message, " ", "") |> String.replace(",", "") |> String.replace(".", "") 
       str = String.to_charlist(String.downcase(str))  
       str = Enum.map(str, fn(el) -> encall(el, a, b) end)
       str = Enum.chunk_every(str, 5) |> Enum.join(" ")
        
       {:ok, str}
     end
  end

  defp encall(x, a, b) do
      if x >= ?a && x <= ?z do
        i = x - ?a 
        res = rem(a*i + b, 26)
        ?a + res
      else
        x
      end 
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
       if rem(a, 2) == 0 || rem(a, 13) == 0  do
         {:error, "a and m must be coprime."}
      else
        encrypted = String.replace(encrypted, " ", "")
        str = String.to_charlist(encrypted)  
        str = Enum.map(str, fn(el) -> dencall(el, a, b) end)
        {:ok, List.to_string(str)}
      end  
  end

  defp dencall(x, a, b) do
      if x >= ?a && x <= ?z do
        i = x - ?a 
 
        res =  rem( fogo(a, 1) * (i - b), 26)
        if res < 0 do
           ?z + res + 1
        else
           ?a + res
        end   
      else
        x
      end 
  end

  defp fogo(a, start) do
     if rem(a*start, 26) == 1 || start > 200 do
        start
     else
        fogo(a, start+1)
     end
  end
  
end
