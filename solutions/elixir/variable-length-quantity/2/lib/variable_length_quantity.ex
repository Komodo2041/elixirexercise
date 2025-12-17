defmodule VariableLengthQuantity do
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode([0]), do: <<0>>
  def encode(integers) do

    map = iscmap(integers)
  
  end

  defp iscmap([]), do: <<>>
  defp iscmap([head|tail]) do
    value = head 
    if value == 0 do
      <<0>> <> iscmap(tail) 
    else
      bits = getbits(value)
      alls = Enum.chunk_every(bits,7) 
       
      res = createBits(alls, 0) 
      map = somap(Enum.reverse(res))
      map <> iscmap(tail)    
    
    end
 
  end

  defp somap([] ), do: <<>>
  defp somap([head|tail] ) do
    <<head::size(8)>> <> somap(tail)
  end
  
 
  defp createBits([], nr), do: []
  defp createBits([head|tail], nr) do
     res =  Enum.reverse(head)
     tochange = String.to_integer(Enum.join(res, ""), 2)
     tochange = tochange + checkTail(nr)
     [tochange] ++ createBits(tail, nr + 1)
  end

  defp checkTail(0), do: 0
  defp checkTail(_), do: 128

  defp getbits(0), do: []
  defp getbits(value) do
      [rem(value, 2)] ++ getbits(div(value,2))
  end

  defp getbits2(0), do: [0,0,0,0,0,0,0]
  defp getbits2(value) do
      [rem(value, 2)] ++ getbits(div(value,2))
  end
  
  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
     # <<first_pixel::size(size), _rest::bitstring>> = picture
     differ = godiff(bytes, [], [])
     if differ == [] do
        {:error, "incomplete sequence"}
     else
        numbers = gonumbers(differ)
        IO.inspect(numbers)

        {:ok, numbers}
     end
     
  end

  defp gonumbers([]), do: []
  defp gonumbers([head|tit]) do
  
     num = itsnumber(head)
     
     [tonumb(num)] ++  gonumbers(tit)
  end

  defp tonumb(list) do
     num = String.to_integer(Enum.join(list, ""), 2)
     num
  end

  defp itsnumber([]), do: []
  defp itsnumber([head|tail]) do
     head = gonum(head)
     Enum.reverse(getbits2(head)) ++ itsnumber(tail)
  end

  defp gonum(head) do
     if  (head >= 128) do
        head - 128
     else
        head
     end   
  end

  defp godiff(<<>>, place, res), do: res
  defp godiff(pict, place, res)  do
     <<first::size(8), _rest::bitstring>> = pict
     if first >= 128 do
          # first = first - 128
          place = place ++ [first]
           godiff(_rest, place, res)
           
     else
          place = place ++ [first]
          res = res ++ [place]
           
           godiff(_rest, [], res)
           
     end
    
  end

  end
