defmodule LibraryFees do
  def datetime_from_string(string) do
    # Please implement the datetime_from_string/1 function
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    # Please implement the before_noon?/1 function
    t = NaiveDateTime.to_time(datetime)
   
    if (Time.compare(t, ~T[12:00:00]) == :lt) do
       true
    else
       false
    end
    
  end

  def return_date(checkout_datetime) do
    # Please implement the return_date/1 function
    if (before_noon?(checkout_datetime)) do
     NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 28*24*3600))
    else
     NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 29*24*3600))
    end
    
  end

  def days_late(planned_return_date, actual_return_datetime) do
    # Please implement the days_late/2 function
    res = Date.diff( NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if res >= 0 do
       res
    else
        0
    end
  end

  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
       
  end

  def calculate_late_fee(checkout, return, rate) do
      checkout = LibraryFees.datetime_from_string(checkout)
      return = LibraryFees.datetime_from_string(return)
      return2 = LibraryFees.return_date(return)
      
       change =  !(LibraryFees.before_noon?(checkout))
       IO.inspect(LibraryFees.boolinteger(change))
       diff = LibraryFees.days_late( checkout ,  return) - 28 - LibraryFees.boolinteger(change)
  
 
      if diff <= 0 do
        0
     else
       if (LibraryFees.monday?(return)) do
           floor(diff * rate * 0.5)
        else
           diff * rate 
       end
     end    
  end

  def boolinteger(bool) do
     if (bool) do
        1
     else
        0
     end   
  end
  
end

