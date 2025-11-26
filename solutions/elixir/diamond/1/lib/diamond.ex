defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
     nr = letter - ?A + 1
     IO.inspect(nr)
     rows = (nr - 1) * 2 + 1
     build = for x <- 1..nr do
               for y <- 1..rows do
                  mid = ceil(rows/2)
                  if abs(y - mid - (x - 1)) == 0 || abs(y - mid + (x - 1)) == 0 do
                     <<(?A + x - 1)::utf8>>
                  else
                      " "
                  end
                  
               end
             end   
     [head| tail ] = Enum.reverse(build)  
      build = build ++ tail
  IO.inspect(build)
     Enum.join(build, "\n") <> "\n"
   
  end

 
 
end
