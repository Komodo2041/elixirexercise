defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
     ResistorColorDuo.checkcolor(Enum.at(colors, 0)) * 10 + ResistorColorDuo.checkcolor(Enum.at(colors, 1))
  end

  def checkcolor(c) do
      case c do
     :black -> 0
     :brown -> 1
     :red -> 2
     :orange -> 3
     :yellow -> 4
     :green -> 5
     :blue -> 6
     :violet -> 7
     :grey -> 8
     :white -> 9
  end
  end
  
end
