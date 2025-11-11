defmodule WineCellar do
  def explain_colors do
    # Please implement the explain_colors/0 function
    [white: "Fermented without skin contact.", red: "Fermented with skin contact using dark-colored grapes.", rose: "Fermented with some skin contact, but not enough to qualify as a red wine."]
  end

  def filter(cellar, color, opts \\ []) do
    # Please implement the filter/3 function
    year = Keyword.get(opts, :year , "")
    country = Keyword.get(opts, :country, "" )
   
    wines = Keyword.get_values(cellar, color)
     
    if (opts == []) do  
        wines
     else 
     if year != "" && country != "" do
          newwines = WineCellar.filter_by_year(wines, year)
          newwines = WineCellar.filter_by_country(newwines, country) 
           newwines 
     else
         if year != "" do
     
           newwines = WineCellar.filter_by_year(wines, year) 
           newwines 
        else
           if country != "" do
       
             newwines = WineCellar.filter_by_country(wines, country) 
             newwines 
            end  
        end
     end   
   end
   
  end

  # The functions below do not need to be modified.

  def filter_by_year(wines, year)
  def filter_by_year([], _year), do: []

  def filter_by_year([{_, year, _} = wine | tail], year) do
    [wine |  filter_by_year(tail, year)]
  end

  def filter_by_year([{_, _, _} | tail], year) do
     filter_by_year(tail, year)
  end

  def filter_by_country(wines, country)
  def filter_by_country([], _country), do: []

  def filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | WineCellar.filter_by_country(tail, country)]
  end

  def filter_by_country([{_, _, _} | tail], country) do
    WineCellar.filter_by_country(tail, country)
  end
end
