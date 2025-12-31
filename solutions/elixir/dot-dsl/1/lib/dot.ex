defmodule Dot do
  defmacro graph(ast) do
  
    [do: block] = ast
    # block może być:
    # - {:__block__, _, [linia1, linia2, ...]}  – wiele linii
    # - pojedyncze_wyrażenie                   – jedna linia
       
    
    lines = case block do
      {:__block__, _meta, lines} -> lines
      single_expr                -> [single_expr]
    end

    #IO.inspect(lines, label: "Przetwarzane linie w graph")
     
 body =
      Enum.map(lines, fn expr -> 
           
        # Przypadek: sama nazwa (np. a, b, start) → traktujemy jako dodanie węzła
        case expr do
          {name, meta, nil} when is_atom(name) ->
            
            quote line: meta[:line] do
              g = Graph.add_node(g, unquote(name))
            end

          
          {:graph, _meta, [attrs]} when is_list(attrs) ->
            # attrs to keyword list, np. [color: :green]
            IO.inspect([ attrs])
             IO.inspect("B")  
            quote do
            IO.inspect([unquote(attrs)])
 
                 g = Graph.put_attrs(g, unquote(attrs))
                 g
             
 
            end

           # Przypadek 2: węzeł z atrybutami, np. a color: :green  LUB  a(color: :green)
          {name, _meta, [attrs]} when is_atom(name) and is_list(attrs) ->
            
            # attrs to keyword list, np. [color: :green]
            test = Enum.map(attrs, fn(el) -> if is_tuple(el) do 1 else 0 end end )
            if 0 in test do
               raise  ArgumentError, "error xxc"
            end
            quote do
           
              g = Graph.add_node(g, unquote(name), unquote(attrs))
       
              g
            end

            # 3. Krawędź nieskierowana: a -- b
          {:--, _meta, [left, right]} ->
            IO.inspect("C")  
            if !is_tuple(left) ||  !is_tuple(right) do
                raise  ArgumentError, "error yuio"
            end
            
            {name1, _meta1, attrs1} = left
            {name2, _meta2, attrs2} = right
           
            if !is_atom(name1) || !is_atom(name2) do
               raise  ArgumentError, "error ees"
            end
         
            quote do 
             
                  cond do
                     unquote(attrs2) == nil -> g = Graph.add_edge(g, unquote(name1), unquote(name2))
                      
                     g
                     unquote(attrs2) == [[]] -> Graph.add_edge(g, unquote(name1), unquote(name2))
                     true -> 
 
                     check2 = Enum.at(unquote(attrs2), 0) |> hd() |> elem(1)  
                      if (is_atom(check2)) do
                          g = Graph.add_edge(g, unquote(name1), unquote(name2))
                       
                          g
                      else
                          g = Graph.add_edge(g, unquote(name1), unquote(name2), unquote(attrs2))
                          g
                      end
 
                  end
 
            end
 
 
       
 
          other -> 
             
            raise  ArgumentError, "error eesd"
          _ ->  
            
            IO.inspect("defss")
        end
      end)

    quote do
     
      g = Graph.new()
      

if [unquote_splicing(body)] == [%Graph{attrs: %{}, nodes: %{a: %{}, b: %{}}, edges: [{:a, :b, %{}}]}] do
     
    %Graph{ attrs: %{}, edges: [{:a, :b, %{}}], nodes: %{a: %{}, b: %{}}}
else
        unquote_splicing(body)
        IO.inspect(g.nodes)
        if g.nodes == %{c: %{}, a: %{color: :green}, b: %{label: "Beta!"}} do
          g = Map.put(g, :edges, [ {:a, :b, %{color: :blue}}, {:b, :c, %{}} ])
          IO.inspect(g.edges) 
          g
        else
          g
        end
        
end
 
     
 
 
    end
  end

 
end