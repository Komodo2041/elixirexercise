defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
 
     map = set_param(opts, %{}, [])
     IO.inspect(map)
     map
  end

  defp set_param([], map, used), do: map
  defp set_param([head|tail], map, used) do
    {color, {x,y}} = head
    if x < 0 || y < 0 || x > 7 || y > 7 || color not in [:white, :black] do
       raise ArgumentError
    else
       if [x,y] in used do
          raise ArgumentError
       else
         map = Map.put(map, color, {x, y})
         map = set_param(tail, map, used ++ [[x,y]])
       end
    end
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
     plans = for x <- 0..7 do
        for y <- 0..7 do
           charq(queens, x, y)
        end
     end  
     plans = Enum.map(plans, fn(el) -> Enum.join(el, " ") end)
     Enum.join(plans, "\n")
  end

  defp charq(queens, x, y) do
    cond do
       Map.has_key?(queens, :white) && queens.white == {x,y} -> "W"
       Map.has_key?(queens, :black) && queens.black == {x,y} -> "B"  
       true -> "_"
    end
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
      if !Map.has_key?(queens, :white) || !Map.has_key?(queens, :black) do
         false
      else
        {x, y} = queens.white
        {x2, y2} = queens.black
        cond do
           x == x2 -> true
           y == y2 -> true
           abs(x - x2) == abs(y - y2) -> true
           true -> false
        end
      end
  end
end
