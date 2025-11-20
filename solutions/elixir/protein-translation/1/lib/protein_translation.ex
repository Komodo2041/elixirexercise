defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) when rna == "", do:  {:ok, []}
  def of_rna(rna) do
      codoms = rna
         |> String.graphemes()
         |> Enum.chunk_every(3)
         |> Enum.map(&Enum.join/1)
 
      if codoms != [] do
        list = get_list(codoms, [])
        if "invalid codon" in list do
            {:error, "invalid RNA"}
        else
            {:ok, list}
        end 
      else
          {:error, "invalid RNA"}
      end
  end

  defp get_list([], list), do: list
  defp get_list([head|tail], list) do
     numero = get_codom(head)
     if numero == "" || numero == "STOP" do
        list
     else
        list = list ++ [numero] 
        get_list(tail, list)
     end
  end

  defp get_codom(str) do
     cond do
        str == "UGU" || str == "UGC" -> "Cysteine"
        str == "UUA" || str == "UUG" -> "Leucine"
        str == "AUG" -> "Methionine"
        str == "UUU" || str == "UUC" -> "Phenylalanine"
        str == "UCU" || str == "UCC" -> "Serine"
        str == "UCA" || str == "UCG" -> "Serine"
        str == "UGG" -> "Tryptophan"
        str == "UAU" || str == "UAC" -> "Tyrosine"
        str == "UAA" || str == "UAG" || str == "UGA" -> "STOP"
        true -> "invalid codon"
     end
  end
  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
 
  def of_codon(codon) do
       if String.length(codon) == 3 do
       m = get_codom(codon)
       if m == "" || m == "invalid codon" do
          {:error, "invalid codon"}
       else
          {:ok, m}
       end
     else
        {:error, "invalid codon"}
     end
  end
end
