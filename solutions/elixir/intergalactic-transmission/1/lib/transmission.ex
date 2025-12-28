defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()

  def get_transmit_sequence(<<>>), do: "" 
 def get_transmit_sequence(data) when is_bitstring(data) do
  bit_count = bit_size(data)

  code = getcode(data, bit_count)
 
end

  defp getcode(data, bit_count) do
      if data == "" do
        <<>>
      else
         
        size = getsize(bit_count)
       <<first::size(size), _rest::bitstring>> = data
    
       partity = getbitparrity(first)
       <<first::size(size), partity::size(8 - size)>> <> getcode(_rest, bit_count - 7)     
      end
 
  end

 defp getsize(x) do
    if x < 7 do
       x
    else
       7
    end   
 end

  defp getbitparrity(x) do
    bits = getbits(x)
    rem(Enum.sum(bits), 2)
  end

  defp getbits(x) do
    if x == 0 do
      []
    else
       [rem(x,2)] ++ getbits(div(x, 2))
    end
  end
 

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(<<>>), do: {:ok, ""}
  def decode_message(received_data) do
     bit_count = bit_size(received_data)
     IO.inspect(bit_count)
      differs = getparts(received_data)
      IO.inspect(differs)
      if -1 in differs do
         {:error, "wrong parity"}
      else
            IO.inspect("b")
         bits = goallbits(differs, 0)
           IO.inspect(bits)
         IO.inspect("a")
         parts = Enum.chunk_every(bits , 8)
         IO.inspect(bits)
         msg = createmsg(parts, length(parts))
         IO.inspect(msg)
         {:ok, msg}
      end
  end

  defp createmsg([], gog), do: <<>>
  defp createmsg([head|tail], gog) do
      
     if gog == 1 do
       str = Enum.join(head, "")
       nr = String.to_integer(str, 2)
       <<nr::size(8)>> <> createmsg(tail, gog)
     else
       if Enum.sum(head) == 0 && tail == [] do
        
         <<>>
       else
            <<getbit(head, 0)::size(1), getbit(head, 1)::size(1), getbit(head, 2)::size(1), getbit(head, 3)::size(1), getbit(head, 4)::size(1), getbit(head, 5)::size(1), getbit(head, 6)::size(1), getbit(head, 7)::size(1)>> <> createmsg(tail, gog)
       end
 
     end
  end

  defp getbit(table, nr) do
    if Enum.at(table, nr) do
      Enum.at(table, nr)
    else
      0
    end
  end
  
  defp cutzero([]), do: [0]
  defp cutzero([head|tail]) do
     if head == 1 do
        Enum.reverse([1] ++ tail)
     else
       cutzero(tail)
     end
  end

  defp goallbits([], nr), do: [] 
  defp goallbits([head|tail], nr) do
     if head == 0 do
           fillzero([0]) ++ goallbits(tail, nr)
     else
          fillzero(Enum.reverse(getbits(head)))  ++ goallbits(tail, nr + 1)
     end
   
  end

   defp fillzero(table) do
   
     if length(table) >= 7 do
        table
     else
        lack = 7 - length(table)
        res = for x <- 1..lack do
          0
        end
        res ++ table
     end
   end

  defp getparts(data) do
      if data == "" do
         []
      else
         <<first::size(7), _rest::bitstring>> = data
         <<parity::size(1), _rest::bitstring>> = _rest
         if getbitparrity(first) == parity do
            [first] ++ getparts(_rest)
         else
            [-1]
         end
      end
  end
  
end
