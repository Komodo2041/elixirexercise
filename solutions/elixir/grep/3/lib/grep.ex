defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
 
    pattern = getPattern(pattern, flags)
    nr_files = length(files)
    res = search_infilile(pattern, flags, files, nr_files) 
    if length(res) > 0 do 
       res = Enum.join(res, "\n") <> "\n"
       String.replace(res, "\n\n", "\n")
    else 
       ""
    end   
  end

  defp search_infilile(pattern, flags, [], nr_files), do: []
  defp search_infilile(pattern, flags, [file|tail], nr_files) do
     {_, text} = File.read(file) 
     {is, rego} = getRego(pattern, flags)  
     res = searchV(rego, text, flags)  
     res = addLine(flags, text, res) 
     res = save_file_name(res, nr_files, file)
     res = getFile(file, flags, res)
     res ++ search_infilile(pattern, flags, tail, nr_files)
  end

 defp searchV(rego, text, flags) do
     if "-v" in flags do 
        lines = String.split(text, "\n") 
        res = get_linesV(rego, lines)
        IO.inspect(res)
        res
     else
       Regex.scan(rego, text, capture: :all )
    end  
 end

defp get_linesV(rego, []), do: []
defp get_linesV(rego, [head|tail]) do
   if (Regex.match?(rego, head <> "\n") || head == "") do
       get_linesV(rego, tail)
   else
       [head] ++ get_linesV(rego, tail)
   end
end
 
 defp save_file_name(res, nr_files, file) do
    if nr_files == 1 || res == [] do
       res
    else
       add_file_name_to_record(res, file)
    end
 end

 defp add_file_name_to_record(res, file) do
  
        res0 = Enum.map(res, 
        fn (elres) ->
           if is_binary(elres) do
                [file <> ":" <> elres]
           else
               [file <> ":" <> Enum.at(elres, 0)]
           end
           
         
        end 
        )
        res0
 end

 defp addLine(flags, text, res) do
    if "-n" in flags do 
       res = addNrLineToRes(res, text)
    else
       res
    end  
 end

 defp addNrLineToRes(res, text) do
      
    lines = String.split(text, "\n") 
  
    if (length(res) == 1) do
        res0 = Enum.map(Enum.at(res,0), 
        fn (elres) ->
  
           nr =  Enum.find_index(lines, fn x -> String.downcase(x) == String.trim(String.downcase(elres)) end)
           elres = Integer.to_string(nr + 1) <> ":" <> elres
         
        end 
        )
 
        [res0]
    else
    
        res0 = Enum.map(res, 
        fn (elres) ->
              
           nr =  Enum.find_index(lines, fn x -> x == Enum.at(elres, 0) end)
           
           [Integer.to_string(nr + 1) <> ":" <> Enum.at(elres, 0)]
         
        end 
        )
        res0
    end
 end

 defp getFile(file, flags, res) do
     if "-l" in flags && res != [] do
       [file]
    else
       res
    end
 end

 defp getPattern(pattern, flags) do
    if "-x" in flags do
      pattern <> "\n"
    else
       "[a-zA-Z0-9,.';!() ]*" <> pattern <> "[a-zA-Z0-9,.';!() ]*"
    end
 end

  defp getRego(pattern, flags) do
     cond do
         "-i" in flags ->   Regex.compile(pattern, "i")
         true -> Regex.compile(pattern)
     end
 
  end
end
