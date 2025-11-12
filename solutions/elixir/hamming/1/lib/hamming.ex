 
defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
 
   nr = Hamming.pom(strand1, strand2)
   if (nr >= 0) do
   {:ok, nr }
       else
   {:error, "strands must be of equal length"}
   end
  end
 
  def pom([], []), do: 0 
  def pom([h1 | t1], [h2 | t2]) do
    if (h1 == "" || h2 == "") do
      
      1 + Hamming.pom(t1, t2)
    else
      if h1 == h2 do
        0 + Hamming.pom(t1, t2)
      else
        1 + Hamming.pom(t1, t2)
      end    
    end
  end
  
   def pom([], _),  do: -1000
  def pom(_,  []), do: -1000
  
 
end
