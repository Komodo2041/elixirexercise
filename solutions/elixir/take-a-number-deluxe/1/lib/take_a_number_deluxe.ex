defmodule TakeANumberDeluxe do
  # Client API
   use GenServer
  @impl GenServer
   def handle_call(data, _from, state) do
 
 
    cond do
     data == :info ->
        if length(state.queue.in) > 0 || length(state.queue.out) > 0 do
             res = TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
             {:reply, {:ok, state}, state, state.auto_shutdown_timeout }  
        else
           res = TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)        
           {:reply, res, state, state.auto_shutdown_timeout }        
        end
 
     data == :new_number ->
 
         refo = TakeANumberDeluxe.State.queue_new_number(state)
        
         cond do
            tuple_size(refo) == 3 ->
            {result, steate, machina} = refo
            {:reply, {result, machina, steate}, machina, state.auto_shutdown_timeout}
            tuple_size(refo) == 2 ->
             {result, napis} = refo
             {:reply, {result, state, napis}, state, state.auto_shutdown_timeout}
         end

      data == :reset ->
           {r, res} = TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)   
           {:reply, res, res, state.auto_shutdown_timeout } 
 

      elem(data, 0) == :serve_number ->   
         {:serve_number, piority} = data
     
         refo = TakeANumberDeluxe.State.serve_next_queued_number(state, piority)
       
          cond do
            tuple_size(refo) == 3 ->
            {result, steate, machina} = refo
            {:reply, {result, machina, steate}, machina, state.auto_shutdown_timeout}
            tuple_size(refo) == 2 ->
             {result, napis} = refo
             {:reply, {result, state, napis}, state, state.auto_shutdown_timeout}
         end        
    end
  end

 

 defp  getprority(piority, state ) do
    if piority do
       piority
    else
       state 
    end
 end


  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    # Please implement the start_link/1 function
     min_number = Keyword.get(init_arg, :min_number)
     max_number = Keyword.get(init_arg, :max_number) 
     timeout = getTime(Keyword.get(init_arg, :auto_shutdown_timeout) )
     if is_integer(min_number) and is_integer(max_number) and min_number < max_number do
           {res, init} = TakeANumberDeluxe.State.new(min_number, max_number, timeout) 
           if timeout == :infinity do
              GenServer.start_link(__MODULE__, init)
           else
              IO.inspect(timeout)
              GenServer.start_link(__MODULE__, init, timeout: timeout)
            
           end
     else
        {:error, :invalid_configuration}
     end
 
  
  end

  defp getTime(x) do
     if is_integer(x) do
        x
     else
       :infinity
     end  
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
 
    # Please implement the report_state/1 function
    {res, datas} = GenServer.call(machine, :info)
     datas
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    # Please implement the queue_new_number/1 function
         {result, steate, numero} = GenServer.call(machine, :new_number) 
 
       if result == :ok do
          {result, numero}
       else
          {:error, :all_possible_numbers_are_in_use}
       end
        
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
          {result, steate, numero} = GenServer.call(machine, {:serve_number, priority_number}) 
 
       if result == :ok do
          {result, numero}
       else
          {:error, numero}
       end
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    # Please implement the reset_state/1 function
     GenServer.call(machine, :reset) 
     :ok
  end

  # Server callbacks
def init(state) do
  
  {:ok, state, state.auto_shutdown_timeout}
end

def handle_info(:timeout, state) do
  # Wyłącz normalnie – proces znika bez crasha
  {:stop, :normal, state}
end

def handle_info(_msg, state) do
  # Reset timera nawet tu
  {:noreply, state, state.auto_shutdown_timeout}
end

  # Please implement the necessary callbacks
end
