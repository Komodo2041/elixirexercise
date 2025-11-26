defmodule Clock do
  @type t() :: %__MODULE__{hour: integer, minute: integer}
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: t()
 
  def new(hour, minute) do
     hour = hour + div(minute, 60) |> rem(24)  |> isminuteunder0(rem(minute, 60))  |> checkminus(24)
     minute = rem(minute, 60) |> checkminus(60)
     check_nine(hour) <> ":" <> check_nine(minute)
  end

  defp check_nine(l) do
     if l < 10 do
        "0" <> Integer.to_string(l)
     else
         Integer.to_string(l)
     end
  end

  defp isminuteunder0(nr, x) do
     if x < 0 do
        nr - 1
     else
        nr
     end
  end

  defp checkminus(nr, des) do
     if nr < 0 do
       des - abs(nr)
     else
        nr
     end   
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(t(), integer) :: t()
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
      
     diffminute = rem(add_minute + minute, 60)
      diffhour = div(add_minute + minute, 60) + hour |> checkminus(24)  
      Clock.new(  diffhour, diffminute)
  end

  def add(str, add_minute) do
     part = String.split(str, ":")
     hour = String.to_integer(Enum.at(part, 0))
     minute = String.to_integer(Enum.at(part, 1))
     Clock.add(%Clock{:hour => hour, :minute => minute}, add_minute)
  end

# Implementacja protokołu
defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: h, minute: m }) do
    formatted = :io_lib.format("~2..0B:~2..0B", [h, m ])
    IO.iodata_to_binary(formatted)
    # albo prościej:
    # "#{String.pad_leading(Integer.to_string(h), 2, "0")}:#{String.pad_leading(Integer.to_string(m), 2, "0")}:#{String.pad_leading(Integer.to_string(s), 2, "0")}"
  end
end
  
end
