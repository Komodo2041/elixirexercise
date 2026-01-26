defmodule Forth do
  @opaque evaluator :: any

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
     %{:case => [], :str => ""}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
     s = String.downcase(s) |> String.replace(~r/[\x00-\x1F\x7F-\x9F ]/u, " ")
     stack = String.split(s)
     stack = gocase(stack, ev.case, stack)
     reschecked = checked_string(stack, stack)
       
     cond do
           reschecked == 1 ->
            
              overstack = useforth(stack, []) 
              
              ev = Map.put(ev, :str,  Enum.join(overstack, " "))         
              ev
            reschecked == 2 ->  
            
             {name, definition, resocond} = getdefinition(stack)
              definition_common = gocase(definition, ev.case, definition)
             cases = removecase(ev.case, name) ++ [{name, definition_common}]
        
             ev = Map.put(ev, :case,  cases) 
             if resocond == [] do
                ev
             else
                str = Enum.join(resocond)
                ev =  Forth.eval(ev, str)
                ev
             end
          true ->
              raise "Error"
      end        
     
  end

 defp removecase([], name), do: []
 defp removecase([head|tail], name) do
    {namecase, change} = head
    if namecase == name do
       removecase(tail, name)
    else
        [head] ++  removecase(tail, name)
    end
 end

 defp gocase([], cases, allstack), do: []
 defp gocase([head|tail], cases, allstack) do
    slimo = chooseslimo( ["+", "-", "*", "/", "swap", "drop", "over", "dup" ], cases)
    
    cond do
       Enum.at(allstack, 0) == ":" -> allstack
       head in slimo -> 
          [head] ++ gocase(tail, cases, allstack)
       true ->
       
          res = Integer.parse(head)
           
          if res != :error do
             [head] ++ gocase(tail, cases, allstack)
          else
              res = changecase(cases, head)
              if res == [] do  
                 raise Forth.UnknownWord
                 gocase(tail, cases, allstack)
              else
                 res ++ gocase(tail, cases, allstack)
              end
          end
    end
 end

defp chooseslimo( defo, []), do: defo  
defp chooseslimo( defo, [head|tail]) do
   {name, change} = head
   defo = defo -- [name]
   chooseslimo( defo, tail)
end

 defp changecase([], head), do: []
 defp changecase([cas|tail], head) do
    {name , tochange} = cas
    if name == head do
        tochange
    else
        changecase(tail, head)
    end
 end
  
 defp getdefinition([head|tail]) do
    [name | rest ] = tail
    {defo, usecases} = diffmiddle(rest, [], [])
     
    res = Integer.parse(name)
    if res == :error do
         {name, defo, usecases}
    else
       raise Forth.InvalidWord
    end
   
 end

defp diffmiddle([], one, two), do: {one, two}
defp diffmiddle([head|tail], one, two) do
   if head == ";" do
     {one, tail}
   else
      one = one ++ [head]
      diffmiddle(tail, one, two)
   end
end
 
 
  defp useforth([], result), do: result
  defp useforth([head|tail], result) do
     cond do 
        head == "+" ->
           {one, two, newresult} = use_two_cond(result)
           result = newresult ++ [one + two]
            useforth(tail, result)
         head == "-" ->
           {one, two, newresult} = use_two_cond(result)
           result = newresult ++ [one - two]
            useforth(tail, result)     
         head == "*" ->
           {one, two, newresult} = use_two_cond(result)
           result = newresult ++ [one * two]
           useforth(tail, result)  
          head == "/" ->
           {one, two, newresult} = use_two_cond(result)
           if two != 0 do 
                result = newresult ++ [div(one, two)]
                useforth(tail, result)  
           else 
              raise Forth.DivisionByZero
           end
         head == "dup"   ->
            {one, newresult} = use_one_cond(result)
            result = newresult ++ [one, one]
            useforth(tail, result) 
         head == "drop"   ->
            {one, newresult} = use_one_cond(result) 
            useforth(tail, newresult)  
         head == "swap"    ->
           {one, two, newresult} = use_two_cond(result)
           result = newresult ++ [two, one]
           useforth(tail, result)   
         head == "over"   ->
           {one, two, newresult} = use_two_cond(result)
           result = newresult ++ [one, two, one]
           useforth(tail, result)   
         true ->  
           result = result ++ [String.to_integer(head)]
           useforth(tail, result)  
     end
  end

 defp use_one_cond(result) do
   if length(result) < 1 do
      raise Forth.StackUnderflow
   else
      rev = Enum.reverse(result)
      [one | rest] = rev 
      {one, Enum.reverse(rest)}
   end
    
 end

 defp use_two_cond(result) do
   if length(result) < 2 do
      raise Forth.StackUnderflow
   else
      rev = Enum.reverse(result)
      [two | rest] = rev
      [one| rest] = rest
      {one, two, Enum.reverse(rest)}
   end
    
 end

  defp checked_string([], odo), do: 1
  defp checked_string([head|tail], odo)  do

     cond do 
      Enum.at(odo, 0) == ":" &&  Enum.at(odo, length(odo) - 1) -> 2
      head in ["+", "-", "*", "/", "swap", "drop", "over", "dup" ] -> checked_string(tail, odo)     
      true ->
        res = String.to_integer(head)
        if is_integer(res) do
           checked_string(tail, odo)
        else
           0
        end
        
     end
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(ev) do
      ev.str
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
