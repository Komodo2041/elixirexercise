defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    # Please implement the get_combinations/3 function
    max_price = setoption(options[:maximum_price])
       IO.inspect(options[:maximum_price])
    res = for top <- tops,
        bottom <- bottoms, 
        top.base_color != bottom.base_color,
        top.price + bottom.price < max_price,
        (options[:other_option] != "" && 1 == 0) || !options[:other_option],
        into: [], 
        do:  {top, bottom} 
  
        
     
    res
  end

  defp setoption(op) do
     if op do
        op
     else
        100
     end   
   end  
end
