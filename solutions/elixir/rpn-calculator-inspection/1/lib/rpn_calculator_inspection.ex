defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    # Please implement the start_reliability_check/2 function
    pid = spawn_link(fn -> calculator.(input) end)
    %{:input => input, :pid => pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    # Please implement the await_reliability_check_result/2 function
    receive do
      {:EXIT, ^pid, :normal} ->
        Map.put(results, input, :ok)

      {:EXIT, ^pid, _reason} ->
        Map.put(results, input, :error)
    after
      100 ->
        Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    # Please implement the reliability_check/2 function
 
    original_trap = Process.flag(:trap_exit, true)

    # Uruchom sprawdzanie dla każdego inputu i zbierz struktury z PID-ami
    checks =
      Enum.map(inputs, fn input ->
        start_reliability_check(calculator, input)
      end)
 
    results =
      Enum.reduce(checks, %{}, fn check, acc ->
        await_reliability_check_result(check, acc)
      end)
 
    Process.flag(:trap_exit, original_trap)

    results
    
  end

  def correctness_check(calculator, inputs) do
    # Uruchamiamy asynchroniczne zadania za pomocą Task.async/1
    tasks = Enum.map(inputs, fn input ->
      Task.async(fn -> calculator.(input) end)
    end)

    # Czekamy na wynik każdego zadania z timeoutem 100ms
    Enum.map(tasks, fn task ->
      Task.await(task, 100)
    end)
  end
end
