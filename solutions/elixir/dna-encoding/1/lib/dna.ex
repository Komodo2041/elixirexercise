defmodule DNA do
  def encode_nucleotide(code_point) do
    # Please implement the encode_nucleotide/1 function
    case code_point do 
       ?A -> 0b0001
       ?C -> 0b0010
       ?G -> 0b0100
       ?T -> 0b1000
       32 -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    # Please implement the decode_nucleotide/1 function
    case encoded_code do 
       0b0001 -> ?A
       0b0010 -> ?C
       0b0100 -> ?G
       0b1000 -> ?T
       0b0000 -> 32
    end    
  end

 
  def encode(dna) do
    # Please implement the encode/1 function
    encoder(dna)
  end

  defp encoder([]), do: <<>>
  defp encoder([head|tail]) do 
 
      rl = <<DNA.encode_nucleotide(head)::4>>
 
       if (tail == []) do
            rl
       else
         # rl <> encoder(tail)
         <<rl::bitstring, encoder(tail)::bitstring >>
       end
       
    
  end

  def decode(dna) do
    # Please implement the decode/1 function
    decodert(dna)
  end
  
  def decodert(<<>>), do: []  
  def decodert(<<data::size(4), _rest::bitstring>> ) do
  
      [DNA.decode_nucleotide(data)] ++ DNA.decodert(_rest)
 
  end
  
end
