defmodule HighSchoolSweetheart do
  def first_letter(name) do
    # Please implement the first_letter/1 function
    String.first(String.trim(name))
  end

  def initial(name) do
    # Please implement the initial/1 function
   name |> String.trim |> String.upcase() |> String.first |> Kernel.<>(".")
  end

  def initials(full_name) do
    # Please implement the initials/1 function
    parts = String.split(full_name)
    HighSchoolSweetheart.initial(Enum.at(parts, 0)) <> " " <> HighSchoolSweetheart.initial(Enum.at(parts, 1))
  end

  def pair(full_name1, full_name2) do
    # ❤-------------------❤
    # |  X. X.  +  X. X.  |
    # ❤-------------------❤

    # Please implement the pair/2 function
    "❤-------------------❤\n" <> "|  " <> HighSchoolSweetheart.initials(full_name1) <> "  +  " <> HighSchoolSweetheart.initials(full_name2)  <> "  |\n❤-------------------❤\n"
  end
end
