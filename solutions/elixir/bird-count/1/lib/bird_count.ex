defmodule BirdCount do
  def today(list) when list == [] do
     nil
  end
  def today(list) do
    # Please implement the today/1 function
    hd(list)
  end
  def increment_day_count(list) when list == [] do  
   [1]
  end
  def increment_day_count(list) do
    # Please implement the increment_day_count/1 function
    if length(list) == 1  do
      [hd(list)+ 1]
    else 
      [hd(list)+ 1] ++ tl(list)
     end
  end

 
  def has_day_without_birds?([]) do 
     false
  end
  def has_day_without_birds?(list) do
    # Please implement the has_day_without_birds?/1 function
 
    if hd(list) === 0 do
       true
    else    
       BirdCount.has_day_without_birds?(tl(list))
    end
   
  end
  
  def total([]) do
    0 
  end
  def total(list) do
    # Please implement the total/1 function
    hd(list) + BirdCount.total(tl(list))
  end

  def busy_days([]) do 
    0
   end 
  def busy_days(list) do
    # Please implement the busy_days/1 function
    if (hd(list) >= 5) do 
      1 + BirdCount.busy_days(tl(list))
    else
      0 + BirdCount.busy_days(tl(list))
    end
    
  end
end
