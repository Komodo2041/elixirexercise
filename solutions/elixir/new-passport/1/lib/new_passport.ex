defmodule NewPassport do
  def get_new_passport(now, birthday, form) do
    # Please implement the 'get_new_passport/3' function
    with {:ok, t} <- enter_building(now) do
        naive_now = DateTime.from_unix!(t)
        
        naive_now2 = NaiveDateTime.new!(DateTime.to_date(naive_now), DateTime.to_time(naive_now))
        with {:ok, count} <- find_counter_information(naive_now2) do
             coount = count.(birthday)
 
             with {:ok, moc} <- stamp_form(t, coount, form) do
                  num = get_new_passport_number(t, coount, moc)  
                  {:ok,  num}
             else
                  {:error, _reason} ->
                      {:error, _reason}
             end
           
        else
           {:coffee_break, _reason} ->
             dt = Date.day_of_week(DateTime.to_date(naive_now))
             
             if  dt != 5  do
                 {:retry, NaiveDateTime.new!(DateTime.to_date(naive_now), Time.add(DateTime.to_time(naive_now), 15*60)) }
             else
                  {:retry, NaiveDateTime.new!(DateTime.to_date(naive_now), ~T[14:30:00]) }  
             end
             
            
        end    
  else
    {:error, _reason} ->
       {:error, _reason}
  end
    
  end

  defp getcount(form) do
     case form do
        :blue -> 1
        :red -> 3
        _ -> 3
     end
  end

  # Do not modify the functions below

  defp enter_building(%NaiveDateTime{} = datetime) do
    day = Date.day_of_week(datetime)
    time = NaiveDateTime.to_time(datetime)

    cond do
      day <= 4 and time_between(time, ~T[13:00:00], ~T[15:30:00]) ->
        {:ok, datetime |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix()}

      day == 5 and time_between(time, ~T[13:00:00], ~T[14:30:00]) ->
        {:ok, datetime |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix()}

      true ->
        {:error, "city office is closed"}
    end
  end

  @eighteen_years 18 * 365
  defp find_counter_information(%NaiveDateTime{} = datetime) do
    time = NaiveDateTime.to_time(datetime)

    if time_between(time, ~T[14:00:00], ~T[14:20:00]) do
      {:coffee_break, "information counter staff on coffee break, come back in 15 minutes"}
    else
      {:ok, fn %Date{} = birthday -> 1 + div(Date.diff(datetime, birthday), @eighteen_years) end}
    end
  end

  defp stamp_form(timestamp, counter, :blue) when rem(counter, 2) == 1 do
    {:ok, 3 * (timestamp + counter) + 1}
  end

  defp stamp_form(timestamp, counter, :red) when rem(counter, 2) == 0 do
    {:ok, div(timestamp + counter, 2)}
  end

  defp stamp_form(_timestamp, _counter, _form), do: {:error, "wrong form color"}

  defp get_new_passport_number(timestamp, counter, checksum) do
    "#{timestamp}-#{counter}-#{checksum}"
     
  end

  defp time_between(time, from, to) do
    Time.compare(from, time) != :gt and Time.compare(to, time) == :gt
  end
end
