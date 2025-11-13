defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
  NucleotideCount.cletter(strand, nucleotide)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  
  def histogram(strand) do
 
    %{
      65 => NucleotideCount.cletter(strand, ?A),
      ?C => NucleotideCount.cletter(strand, ?C),
      71 => NucleotideCount.cletter(strand, ?G),
      ?T => NucleotideCount.cletter(strand, ?T)
    }
  end

  def cletter(string, l) do
      Enum.reduce(string, 0, fn (el, acc) -> acc + NucleotideCount.bi(el == l)   end)
  end

  def bi(val) do
     if (val) do
         1
     else
         0
     end
  end
end
