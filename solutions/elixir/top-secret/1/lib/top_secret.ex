defmodule TopSecret do
  def to_ast(string) do
    # Please implement the to_ast/1 function
    {res, mess} = Code.string_to_quoted(string)
     
    mess
  end

  def decode_secret_message_part(ast_node, acc) do
        # Please implement the decode_secret_message_part/2 function
case ast_node do
      {op, _meta, [{name, _name_meta, args} | _tail]}
      when op in [:def, :defp] and (is_nil(args) or is_list(args))  ->
        if name == :when do
            IO.inspect(args)
           [{name, _name_meta, args} | _tail] = args
           arity = if is_nil(args), do: 0, else: length(args)
            partial_name =
              name
              |> Atom.to_string()
              |> String.slice(0, arity)
            {ast_node, [partial_name | acc]}
        else
          arity = if is_nil(args), do: 0, else: length(args)
           
          partial_name =
            name
            |> Atom.to_string()
            |> String.slice(0, arity)
          {ast_node, [partial_name | acc]}
        end
      _ ->
        {ast_node, acc}
    end
  end

  def decode_secret_message(string) do
    # Please implement the decode_secret_message/1 function
 
    {:ok, ast} = Code.string_to_quoted(string)

    {_ast, parts} =
      Macro.prewalk(ast, [], &decode_secret_message_part/2)

    parts
    |> Enum.reverse()
    |> Enum.join()
   
    
  end
end
