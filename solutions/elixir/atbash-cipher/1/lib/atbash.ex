defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
     plain = to_charlist(String.downcase(plaintext))
     str = goAtbash(plain)
     gofive(str)
  end

  defp gofive(str) do
     list = String.graphemes(str)
     newlist = Enum.chunk_every(list, 5)
     newlist = Enum.map(newlist, fn(el) -> Enum.join(el, "") end)
     Enum.join(newlist, " ")
  end

  defp goAtbash([]), do: ""
  defp goAtbash([head|tail]) do
      if (head >= ?a && head <= ?z) do
         pom = ?z - (head - ?a)
         <<pom::utf8>> <> goAtbash(tail)
      else
         if head > ?0 && head < ?9 do
             <<head::utf8>> <> goAtbash(tail)
         else
             goAtbash(tail)
         end 
      end
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
      cipher = to_charlist(String.downcase(cipher))
      goAtbash(cipher)
  end
end
