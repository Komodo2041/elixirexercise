defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
     
     table = to_charlist(text)
     table = Enum.map(table, fn(c) -> goshift(c, shift)  end )
     List.to_string(table)
  end

  defp goshift(nr, shift) do
    cond do
        ?a <= nr && nr <= ?z ->
           c = nr + shift  
           if (c > ?z) do c = ?a + (c- ?z - 1 ) else c end
        ?A <= nr && nr <= ?Z ->
           c = nr + shift  
           if (c > ?Z) do c = ?A + (c- ?Z - 1 ) else c end           
        true -> nr
    end
  end

  
end
