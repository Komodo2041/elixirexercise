defmodule TakeANumber do
  def start() do
    # Please implement the start/0 function
    spawn(&loop/0)
  end

defp loop(current \\ 0) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, current)
        loop(current)
      {:take_a_number, sender_pid} ->
        i = current + 1
        send(sender_pid, i)
        loop(i) 
      :stop -> nil
      _other ->
        loop(current)
    end
  end
  
end
