defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    table = String.split(path, ".")
    BasketballWebsite.godata(data, table, 0)
 
    # Please implement the extract_from_path/2 function
  end

  
  def godata(data, table, i) do
     path = Enum.at(table, i)
     if (path) do
         BasketballWebsite.godata(data[path], table, i + 1)
     else
         data
     end
  end

  def get_in_path(data, path) do
    # Please implement the get_in_path/2 function
    get_in(data, String.split(path, "."))
  end
end
