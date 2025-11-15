defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) do
     if (number < 1 || number > 64) do
         {:error, "The requested square must be between 1 and 64 (inclusive)"}
     else
         {:ok, 2**(number-1)}
     end
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
     list = Enum.to_list(1..64)
     {:ok, caltotal(list)}
  end

  defp caltotal([]), do: 0
  defp caltotal([head|tail]) do
     get_in(Grains.square(head), [Access.elem(1)])  + caltotal(tail)
  end
end
