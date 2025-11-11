defmodule LogLevel do
  def to_label(level, legacy) do
    # Please implement the to_label/2 function
    cond do
        !legacy and level == 0 -> 
            :trace
          level == 1 -> 
            :debug
         level == 2 -> 
            :info
         level == 3 -> 
            :warning
        level == 4 -> 
            :error
        !legacy and level == 5 ->
            :fatal  
        level > 5 || legacy || level < 0 -> 
            :unknown
    end
        
  end

  def alert_recipient(level, legacy?) do
    # Please implement the alert_recipient/2 function
    res = LogLevel.to_label(level, legacy?)
 
    cond do
        res == :fatal -> 
           :ops
        res == :error -> 
           :ops
        res == :unknown && legacy? -> 
           :dev1
         res == :unknown && !legacy? && level > 0 -> 
           :dev2           
 
         res ==  :trace || res ==  :debug ||  res ==  :info ||  res ==  :warning ->   
            false
    end
 
  end
end

 