defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
     str = Regex.replace(~r/[\t\n!&@$%^&:.]/, String.downcase(sentence), "")
     elem = Enum.filter(Regex.split(~r/ |,|_/, str), fn(el) -> el != "" end)
     res = createhist(elem, %{})
     res
  end

  defp createhist([], result), do: result
  defp createhist([head|tail], result) do
     head = String.trim(head, "'")
     if (result[head]) do
        result = %{ result | head => result[head] + 1 }
        createhist(tail, result)
     else
        result = Map.put(result, head, 1)
        createhist(tail, result)
     end
  end
end
