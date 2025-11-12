defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    []
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
      if (school[String.to_atom(name)]) do
        {:error, school}
      else
        school = school ++ [{String.to_atom(name), grade}] 
        {:ok, school}
      end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
   school = Enum.filter(school, fn {_name, grade2} -> grade2 == grade end)
   
   Enum.sort(Enum.map(Keyword.keys(school), fn(el) -> to_string(el) end))
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school = Enum.sort_by(school, fn {_name, grade} -> {grade, _name} end)
    Enum.map(Keyword.keys(school), fn(el) -> to_string(el) end)
  end
end
