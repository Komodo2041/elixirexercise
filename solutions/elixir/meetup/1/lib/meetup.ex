defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    endo = get_end(schedule)
    date_one = Integer.to_string(year) <> "-" <> format(Integer.to_string(month)) <> endo  
    {res, date_one} =  Date.from_iso8601(date_one)
    IO.inspect(date_one)
    plus = Date.day_of_week(date_one)
    dw = getNrDays(weekday)
    dm = Date.days_in_month(date_one)
  numbers = getschedule(schedule, dw, plus, dm)
  
  date = Integer.to_string(year) <> "-" <> format(Integer.to_string(month)) <> "-" <> format(Integer.to_string(numbers))
  {res, date} =  Date.from_iso8601(date)
  IO.inspect(date)
  date
  
  end

  defp get_end(x) do
     if x == :teenth do
        "-13"
     else
        "-01"
     end
  end

  defp format(x) do
     if String.length(x) == 1 do 
        "0" <> x
     else
        x
     end
  end

  defp getNrDays(x) do
     case x do
         :monday -> 1
         :tuesday -> 2
         :wednesday -> 3
         :thursday -> 4
         :friday -> 5
         :saturday -> 6
         :sunday -> 7    
     end
  end

  defp getschedule(check, dw, plus, dm) do
      first = getFirst(dw, plus) 
      IO.inspect(first )
      IO.inspect(dw )
      IO.inspect(plus )
       IO.inspect(dm)
      
      case check do
         :first ->    first
         :second -> 7 + first
         :third -> 14 + first
         :fourth -> 21 + first
         :last -> if 28 + first > dm do 21 + first else 28 + first end  
         :teenth -> 13 + first - 1
      end
  end

  defp getFirst(dw, plus) do
     if plus <= dw do
        dw - plus + 1
     else
        dw + 7 - plus + 1
     end
  end
end
