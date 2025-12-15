defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
     keysplus = String.graphemes(key)
           |> Enum.map(fn char ->
             <<codepoint::utf8>> = char
             codepoint - ?a
           end)
     
     plaintext = move(plaintext, keysplus, 1)
     List.to_string(plaintext)  
  end

  defp move(str, keys, isplus) do
     str = String.to_charlist(str)
     max = length(str) - 1
     for x <- 0..max do
        mv(Enum.at(str, x), keys, x, isplus)
     end
     
  end

  defp mv(l, keys, nr, isplus) do
 
     mn = length(keys)
     plus = Enum.at(keys, rem(nr, mn))
     if isplus == 1 do
         l =  l + plus
         goz(l)
     else
         l =  l - plus
         goz(l)    
     end
  end

  defp goz(l) do
     cond do
         l > ?z -> ?a + (l - ?z - 1)
         l < ?a -> ?z - (?a - l - 1)
        true -> l
     end
 
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
       keysplus = String.graphemes(key)
           |> Enum.map(fn char ->
             <<codepoint::utf8>> = char
             codepoint - ?a
           end)
     
     plaintext = move(ciphertext, keysplus,  0)
     List.to_string(plaintext)  
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
     list = for _ <- 1..(length ), do: Enum.random(1..(?z - ?a))
     list = Enum.map(list, fn(el) -> el + ?a end)
      List.to_string(list)  
  end
end
