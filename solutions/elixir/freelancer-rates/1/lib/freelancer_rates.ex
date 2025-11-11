defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    # Please implement the daily_rate/1 function
     8 * hourly_rate / 1 
  end

  def apply_discount(before_discount, discount) do
    # Please implement the apply_discount/2 function
    before_discount * ((100 - discount) / 100 )
  end

  def monthly_rate(hourly_rate, discount) do
    # Please implement the monthly_rate/2 function
    ceil(FreelancerRates.apply_discount(22 * 8 * hourly_rate, discount))  
  end

  def days_in_budget(budget, hourly_rate, discount) do
    # Please implement the days_in_budget/3 function
    Float.floor(budget / FreelancerRates.apply_discount( FreelancerRates.daily_rate(hourly_rate), discount), 1) 
  end
end
