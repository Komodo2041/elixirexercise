defmodule FileSniffer do
  def type_from_extension(extension) do
    # Please implement the type_from_extension/1 function
    case extension do
       "bmp" -> "image/bmp"
       "exe" -> "application/octet-stream"
       "png" -> "image/png"
       "jpg" -> "image/jpg"
       "gif" -> "image/gif"
       _ -> nil
    end
  end

  def type_from_binary(file_binary) do
    # Please implement the type_from_binary/1 function
      if byte_size(file_binary) < 8 || byte_size(file_binary)  == 9 do
        nil
      else  
       <<one::binary-size(8), body::binary>> = file_binary 
         <<a,b ,c, d, e, f, g, h>> = one
         cond do
            a == 0x7F && b == 0x45 && c == 0x4C && d == 0x46 -> "application/octet-stream"
            a == 0x42 && b == 0x4D -> "image/bmp"
            a == 0x89 && b == 0x50 && c == 0x4E && d == 0x47 && e == 0x0D && f == 0x0A ->"image/png"
            a == 0xFF && b == 0xD8 && c == 0xFF -> "image/jpg"
            a == 0x47 && b == 0x49 && c == 0x46 -> "image/gif"
            true -> nil
         end
     
      end 
  end

  def verify(file_binary, extension) do
    # Please implement the verify/2 function
     if FileSniffer.type_from_binary(file_binary) == FileSniffer.type_from_extension(extension) && FileSniffer.type_from_extension(extension) != nil do
        {:ok, FileSniffer.type_from_extension(extension)}
     else
       
        {:error, "Warning, file format and file extension do not match."}
  
     end
  end
end
