defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
     datetime = {{year, month, day}, {hours, minutes, seconds}}
     naive = NaiveDateTime.from_erl!(datetime)
     ndt = NaiveDateTime.add(naive, 1000000000, :second)
     {{ndt.year, ndt.month, ndt.day}, {ndt.hour, ndt.minute, ndt.second}}
  end
end
