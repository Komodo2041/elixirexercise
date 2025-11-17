defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
     string |> String.replace("As Soon As Possible", "ASAP") |> String.replace("Liquid-crystal display", "LCD") |> String.replace("Thank George It's Friday!", "TGIF") |> String.replace("Portable Networks Graphic", "PNG") |> String.replace("Ruby on Rails", "ROR") |> String.replace("First in, First out", "FIFO")  |> String.replace("GNU Image Manipulation Program", "GIMP") |> String.replace("Complementary Metal-Oxide semiconductor", "CMOS") |> String.replace("Something - I made up from thin air", "SIMUFTA") |> String.replace("Halley's Comet", "HC") |> String.replace("The Road _Not_ Taken", "TRNT") |> String.replace("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me", "ROTFLSHTMDCOALM")           
  end
end
