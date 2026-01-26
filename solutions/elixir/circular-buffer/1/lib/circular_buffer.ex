defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
     pid = spawn(fn -> loop(0, capacity, []) end)
     {:ok, pid}
  end

  defp loop(current \\ 0, capacity \\ 0, values \\ []) do
    receive do
       {:write, i, sender_pid} ->
            if length(values) < capacity do
              values = values ++ [i]
              send(sender_pid, 1) 
              loop(current, capacity, values)
            else
               send(sender_pid, {:error, :full}) 
               loop(current, capacity, values)
            end
       {:overwrite, i, sender_pid} ->   
         if length(values) <  capacity do
              values = values ++ [i]
              send(sender_pid, 1) 
              loop(current, capacity, values)
         else
             [first | rest] = values
             send(sender_pid, 1) 
              loop(current, capacity, rest ++ [i])
         end
      {:read, sender_pid} ->
        if length(values) > 0 do
           [first | rest] = values
          send(sender_pid, first) 
          loop(current, capacity, rest)
        else
          send(sender_pid, {:error, :empty}) 
          loop(current, capacity, values)        
        end
      {:clear, sender_pid} ->
          send(sender_pid, 1) 
          loop(current, capacity, [])
      :stop -> nil
      _other ->
        loop(current, capacity, values)
    end
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
     send(buffer, {:read, self()})
     receive do
          values when is_integer(values)  ->
            {:ok, values}
         {:error, :empty} ->
            {:error, :empty}
      after
        1_000 ->    
          {:error, :timeout}
      end  
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
     send(buffer, {:write, item, self()})
     receive do
          values when values == 1  ->
            :ok
           {:error, :full} ->
              {:error, :full}
      after
        1_000 ->    
          {:error, :timeout}
      end   
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
     send(buffer, {:overwrite, item, self()})
     receive do
          values when values == 1  ->
            :ok 
      after
        1_000 ->    
          {:error, :timeout}
      end    
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
       send(buffer, {:clear, self()})
     receive do
          values when values == 1  ->
            :ok
 
      after
        1_000 ->    
          {:error, :timeout}
      end  
  end
end
