defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do 
     if length(colors) >= 3 do
       number = 10 * getnumber(Enum.at(colors, 0)) + getnumber(Enum.at(colors, 1))       
       number3 = 10 ** getnumber(Enum.at(colors, 2))
       result = number * number3  
       info(result)
     else  
        :error
     end
  end

  defp getnumber(color) do
      case color do
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

  defp info(number) do
     cond do
        div(number, 1000000000) > 0 -> {div(number, 1000000000), :gigaohms}  
        div(number, 1000000) > 0 -> {div(number, 1000000), :megaohms} 
        div(number, 1000) > 0 -> {div(number, 1000), :kiloohms} 
        true -> {number, :ohms} 
     end
  end
  
end
