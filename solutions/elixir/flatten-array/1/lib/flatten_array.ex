defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1, 2, 3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
     table = FlattenArray.checkList(list)
     Enum.filter(table, fn(el) -> is_integer(el) end )
     
  end

  def checkList([]) do
    []
  end
  def checkList([head | tail]) do
     if (is_list(head)) do
         FlattenArray.checkList(head) ++  FlattenArray.checkList(tail)
     else
        [head | FlattenArray.checkList(tail)]
     end
  end
end
