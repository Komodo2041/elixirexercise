defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
      size = tuple_size(numbers)
      if (size == 0) do
        :not_found
      else
         binarysearch(numbers, key, 0, size - 1)
      end 
      
  end

  defp binarysearch(numbers, integer, start, ends) do
 
     if start == ends  do
         search = (elem(numbers, start))
         if (search == integer) do
            {:ok, start}
         else
            :not_found
         end
         
     else
        middle = floor((start + ends)/ 2)
        search = (elem(numbers, middle))
        cond do
           search == integer -> {:ok, middle}
           middle == start -> binarysearch(numbers, integer, middle + 1, ends)
           search > integer -> binarysearch(numbers, integer, start, middle)
           search < integer -> binarysearch(numbers, integer, middle, ends)
        end
     end 
  end
  
end
