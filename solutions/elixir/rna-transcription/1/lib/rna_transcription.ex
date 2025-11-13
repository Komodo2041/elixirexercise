defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
      dna = List.to_string(dna)
      dna = String.replace(dna, "G", "L")
      dna = String.replace(dna, "C", "G")
      dna = String.replace(dna, "L", "C")
      dna = String.replace(dna, "A", "U")
      dna = String.replace(dna, "T", "A")
   
      to_charlist(dna)
  end
end
