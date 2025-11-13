defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
     table = []
 
     table = [SecretHandshake.checktable(8, code) | table] 
      table = [SecretHandshake.checktable(4, code) | table] 
      table = [SecretHandshake.checktable(2, code) | table] 
      table = [SecretHandshake.checktable(1, code) | table] 
      
     table = Enum.filter(table, fn(el) -> el end) 
  
     if (div(rem(code, 32), 16) == 1) do
         table = Enum.reverse(table)
         table
     else   
         table
     end
       
    
  end

  def checktable(n, code) do 
  
     case n do
       1 -> if (rem(code, 2) == 1) do 
          "wink"
       end
       2 -> if (div(rem(code, 4), 2) == 1) do
 
           "double blink" 
       end
       4 -> if (div(rem(code, 8), 4) == 1) do
          "close your eyes"
       end
       8 -> if (div(rem(code, 16), 8) == 1) do 
           "jump"
       end
     end
  end
end
