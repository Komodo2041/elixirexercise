defmodule React do
  @opaque cells :: pid

  @type cell :: {:input, String.t(), any} | {:output, String.t(), [String.t()], fun()}

  @doc """
  Start a reactive system
  """
  @spec new(cells :: [cell]) :: {:ok, pid}
  def new(cells) do
     pid = spawn(fn -> loop(cells, []) end)
     {:ok, pid}
  end

defp loop(cells \\ [], callbacks \\ [] ) do
    receive do
       {:getvalue, name, sender_pid} -> 
         value = getValue(cells, name, cells)
        
         send(sender_pid, value) 
 
         loop(cells, callbacks)
      {:setvalue, name, value, sender_pid} -> 
   
         new_cells = setValue(cells, name, value )       
         send(sender_pid, 1) 
 
         usecallbacs(callbacks, name, new_cells, sender_pid, cells)
         
         loop(new_cells, callbacks)

      {:setcallback, cell_name, callback_name, callback, sender_pid} ->
         usedpools = getPools(cells, cell_name, cells)
         callbacks = callbacks ++ [{callback_name, usedpools, cell_name, callback}]
         send(sender_pid, 1) 
         loop(cells, callbacks)      
      {:removecallback,  cell_name, callback_name, sender_pid} ->
          callbacks = removeCallback(callbacks, callback_name)
         send(sender_pid, 1) 
         loop(cells, callbacks)       
      :stop -> nil
      _other ->
        loop(cells, callbacks)
    end
  end


defp removeCallback([], callback_name), do: []
defp removeCallback([head|tail], callback_name) do
   if elem(head, 0) == callback_name do
      removeCallback(tail, callback_name)
   else
      [head] ++ removeCallback(tail, callback_name)
   end
end

defp usecallbacs([], name, new_cells, sender_pid, cells), do: []
defp usecallbacs([head|tail], name, new_cells, sender_pid, cells) do
   if name in  elem(head, 1) do
      value = getValue(new_cells, elem(head, 2), new_cells)
      oldvalue = getValue(cells, elem(head, 2), cells)
      if value != oldvalue do
        IO.inspect({:callback, elem(head, 0), value})
        send(sender_pid, {:callback, elem(head, 0), value}) 
        usecallbacs(tail, name, new_cells, sender_pid, cells) 
      else
          IO.inspect("no_callback")
      end
   else
      usecallbacs(tail, name, new_cells, sender_pid, cells) 
   end
end

defp getPools([], cell_name, cells), do: []
defp getPools([head|tail], cell_name, cells) do
  if elem(head, 0) == :output && elem(head, 1) == cell_name do
      reso = Enum.uniq(getInputOnly(elem(head, 2), cells))
 
      reso
  else
     getPools(tail, cell_name, cells)
  end
end

defp getInputOnly([], cells), do: []
defp getInputOnly([head|tail], cells) do
    field = getFields(cells, head)
   
      cond do
           elem(field, 0) == :input ->   [elem(field, 1)] ++ getInputOnly(tail, cells)
           elem(field, 0) == :output ->   getInputOnly(elem(field, 2), cells) ++ getInputOnly(tail, cells)
          true -> []
     end
 
end

defp getFields([], cell_name ), do: []
defp getFields([head|tail], cell_name ) do
  if elem(head, 1) == cell_name do
        head
  else
     
     getFields(tail, cell_name )
  end
end

defp getValue([], name, cells), do: nil
defp getValue([head|tail], name, cells) do
    
   if elem(head, 1) == name do
      if elem(head, 0) == :input do
          elem(head, 2)
      else
         params = getParams(elem(head, 2), cells)
         fno =  elem(head, 3)
         result = apply(fno, params)
        
         result
      end
      
   else
      getValue(tail, name, cells) 
   end
end

defp getParams([], cells), do: []
defp getParams([head|tail], cells) do
    [getValue(cells, head, cells)] ++ getParams(tail, cells)
end


defp setValue([], name, value ) do 
   []
end   
defp setValue([head|tail], name, value ) do
    
 if elem(head, 1) == name do
     
     [{elem(head, 0), name, value} | tail]
  else
     [head | setValue(tail, name, value)]
  end  
end

  @doc """
  Return the value of an input or output cell
  """
  @spec get_value(cells :: pid, cell_name :: String.t()) :: any()
  def get_value(cells, cell_name) do
     send(cells, {:getvalue, cell_name, self()})
     receive do
        value when is_integer(value) ->
          value
        value when is_binary(value) ->
          value   
        value when value == nil ->
          nil
      after
        1_000 ->    
          {:error, :timeout}
      end
  end

  @doc """
  Set the value of an input cell
  """
  @spec set_value(cells :: pid, cell_name :: String.t(), value :: any) :: :ok
  def set_value(cells, cell_name, value) do
     send(cells, {:setvalue, cell_name, value, self()})
     receive do
        value when is_integer(value) ->
           :ok
        {:callback, cn, cval} ->
           {:callback, cn, cval}
      after
        1_000 ->    
          {:error, :timeout}
      end  
  end

  @doc """
  Add a callback to an output cell
  """
  @spec add_callback(
          cells :: pid,
          cell_name :: String.t(),
          callback_name :: String.t(),
          callback :: fun()
        ) :: :ok
  def add_callback(cells, cell_name, callback_name, callback) do
     send(cells, {:setcallback, cell_name, callback_name, callback, self()})
     receive do
        value when is_integer(value) ->
           :ok
 
      after
        1_000 ->    
          {:error, :timeout}
      end    
  end

  @doc """
  Remove a callback from an output cell
  """
  @spec remove_callback(cells :: pid, cell_name :: String.t(), callback_name :: String.t()) :: :ok
  def remove_callback(cells, cell_name, callback_name) do
     send(cells, {:removecallback, cell_name, callback_name, self()})
     receive do
        value when is_integer(value) ->
           :ok
 
      after
        1_000 ->    
          {:error, :timeout}
      end      
  end
end
