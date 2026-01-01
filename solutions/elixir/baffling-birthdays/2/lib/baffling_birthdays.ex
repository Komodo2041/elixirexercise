defmodule BafflingBirthdays do
  @moduledoc """
  Estimate the probability of shared birthdays in a group of people.
  """

  @spec shared_birthday?(birthdates :: [Date.t()]) :: boolean()
  def shared_birthday?(birthdates) do
     birthdates = Enum.map(birthdates, fn(el) ->  el.day end)
     b2 = Enum.uniq(birthdates)
     if length(birthdates) == length(b2) do
        false
     else
        true
     end   
  end

  
  

  @spec random_birthdates(group_size :: integer()) :: [Date.t()]
  def random_birthdates(group_size) do
    res = for i <- 1..group_size do
        m = Enum.random(1..12)
        y = Enum.random(2025..2025)
       dates = [y, m, Enum.random(1..Date.days_in_month(Date.new!(y, m, 1)))]
  
       dates
    end
    
    Enum.map(res, fn(el) -> Date.new!(Enum.at(el, 0), Enum.at(el, 1), Enum.at(el, 2)) end)
   
  end

  @spec estimated_probability_of_shared_birthday(group_size :: integer()) :: float()
  def estimated_probability_of_shared_birthday(1), do: 0
  
  def estimated_probability_of_shared_birthday(group_size) do
   p = Enum.map(365..366 - group_size//-1, fn number -> number / 365 end)
    (1 - Enum.product(p)) * 100

  end
end
