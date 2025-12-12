defmodule SwiftScheduling do
  @doc """
  Convert delivery date descriptions to actual delivery dates, based on when the meeting started.
  """
  @spec delivery_date(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t()
  def delivery_date(meeting_date, description) do
  
     cond do 
        description == "NOW" -> NaiveDateTime.add(meeting_date, 2, :hour)
        description == "ASAP" -> if  meeting_date.hour < 13 do
           NaiveDateTime.new!(NaiveDateTime.to_date(meeting_date), ~T[17:00:00])
           
           else 
           meeting_date = NaiveDateTime.add(meeting_date, 1, :day)
           NaiveDateTime.new!(NaiveDateTime.to_date(meeting_date), ~T[13:00:00])          
           end
        description == "EOW" -> 
          day = Date.day_of_week(meeting_date)
          diff = 5 - day
          cond do
             day <= 3 ->
                 meeting_date = NaiveDateTime.add(meeting_date, diff, :day)
                 NaiveDateTime.new!(NaiveDateTime.to_date(meeting_date), ~T[17:00:00]) 
             day > 3 ->
                  meeting_date = NaiveDateTime.add(meeting_date, diff + 2, :day)
                 NaiveDateTime.new!(NaiveDateTime.to_date(meeting_date), ~T[20:00:00]) 
          end 
        Regex.match?( ~r/[0-9]+M/, description) -> 
        m = String.replace(description, "M", "") |> String.to_integer
           if m > meeting_date.month do
              meeting_date = meeting_date = %{meeting_date | month: m, day: 1} 
              NaiveDateTime.new!(NaiveDateTime.to_date(meeting_date), ~T[08:00:00]) 
           else 
             meeting_date = meeting_date = %{meeting_date | month: m, day: 1, year: meeting_date.year + 1}
             day = Date.day_of_week(meeting_date)
             if day <= 5 do
                 NaiveDateTime.new!(NaiveDateTime.to_date(meeting_date), ~T[08:00:00]) 
             else
                  diff = 9 - day
                  meeting_date = meeting_date = %{meeting_date | day: diff }
                  NaiveDateTime.new!(NaiveDateTime.to_date(meeting_date), ~T[08:00:00]) 
             end 
           end

         Regex.match?( ~r/Q[0-9]+/, description) -> 
            q = String.replace(description, "Q", "") |> String.to_integer
            checkm = q * 3
            if checkm > meeting_date.month do
                meeting_date = %{meeting_date | month: checkm }
                date = Date.end_of_month(NaiveDateTime.to_date(meeting_date))
                movedateback(NaiveDateTime.new!(date, ~T[08:00:00])) 
            else
                meeting_date = %{meeting_date | month: checkm, year: meeting_date.year + 1}
                date = Date.end_of_month(NaiveDateTime.to_date(meeting_date))
                movedateback(NaiveDateTime.new!(date, ~T[08:00:00]))
            end
            
      end     
  end

  defp movedateback(meeting_date) do
             day = Date.day_of_week(meeting_date)
             if day <= 5 do
                 meeting_date
             else
                  diff = day - 5
                  NaiveDateTime.add(meeting_date, -1 * diff , :day)
                  
             end 
  end
  
end
