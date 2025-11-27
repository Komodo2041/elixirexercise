defmodule RPNCalculator do
  def calculate!(stack, operation) do
    # Please implement the calculate!/2 function
    operation.(stack)
  end

  def calculate(stack, operation) do
    # Please implement the calculate/2 function
    try do
       res = operation.(stack)
       {:ok, res}
    rescue
       _ in ArgumentError -> :error
       _ in RuntimeError -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    # Please implement the calculate_verbose/2 function
    try do
       res = operation.(stack)
       {:ok, res}
    rescue 
       e in ArgumentError ->  {:error, e.message}  
       e in RuntimeError ->  {:error, e.message}  
    end
    
  end
end
