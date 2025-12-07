defmodule RPNCalculator.Exception do
  # Please implement DivisionByZeroError here.
  
defmodule DivisionByZeroError do
  defexception message: "division by zero occurred"
end
   
  # Please implement StackUnderflowError here.

defmodule StackUnderflowError do
  defexception message: "stack underflow occurred"
  @impl true
  def exception(value) do
    IO.inspect(value)
    case value do
      [] ->
        %StackUnderflowError{} 
      _ ->
        %RPNCalculator.Exception.StackUnderflowError{message: "stack underflow occurred, context: " <> value}
     end  
   end 
end 

 
def divide(stack) do
    if length(stack) < 2 do
       raise StackUnderflowError, "when dividing"
    else
     if Enum.at(stack, 0) == 0 || Enum.at(stack, 1) == 0 do
          raise DivisionByZeroError
     else
         Enum.at(stack, 1)/Enum.at(stack, 0)
     end
    end

end

end
