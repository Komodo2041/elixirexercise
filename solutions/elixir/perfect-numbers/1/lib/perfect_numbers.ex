defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) do
     if (number <= 0) do
         {:error, "Classification is only possible for natural numbers."}
     else
       nr = ceil(number /2)
       list = Enum.to_list(1..nr)
       alldiv = for x <- list, rem(number, x) == 0, do: x
       IO.inspect(alldiv)
       sum = Enum.sum(alldiv)
       cond do
          sum > number -> {:ok, :abundant}
          sum < number || number == 1 -> {:ok, :deficient}
          sum == number -> {:ok, :perfect}
        
          true -> {:ok, :other}
       end
     end
  end
end
