defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
     question = String.replace(question, "?", "") |> String.replace("multiplied by", "multipliedby") |> String.replace("divided by", "dividedby")
     sentence = String.split(question, " ")
     if Enum.at(sentence, 0) == "What" && Enum.at(sentence, 1) == "is" do
        operation = Enum.at(sentence, 3)
        sente = Enum.slice(sentence, 2, length(sentence))
        res = gooperation(sente, nil)
        res
 
     else
        raise ArgumentError
     end
  end

  defp gooperation([], old), do: old
  defp gooperation(sentence, old) do
  
     if old do
        operation = Enum.at(sentence, 0)
        prime = old
        second = String.to_integer(Enum.at(sentence, 1))
        res = operation(operation, prime, second)
        sente = Enum.slice(sentence, 2, length(sentence))
        gooperation(sente, res)
     else
        operation = Enum.at(sentence, 1)
        prime = String.to_integer(Enum.at(sentence, 0))
        second = getat(sentence, 2)
        res = operation(operation, prime, second)
        sente = Enum.slice(sentence, 3, length(sentence))
        gooperation(sente, res)
     end
  end

  defp getat(sen, at) do
   if Enum.at(sen, at) do
      String.to_integer(Enum.at(sen, at))
   else
      nil
   end
 end

  defp operation(operation, prime, second) do
 
        cond do
          operation == nil -> prime
           operation == "plus" &&  second == nil ->  raise ArgumentError
          operation == "plus" -> prime + second
          operation == "minus" -> prime - second
          operation == "multipliedby" -> prime * second
          operation == "dividedby" -> prime / second
          true -> raise ArgumentError
        end
  end
  
end
