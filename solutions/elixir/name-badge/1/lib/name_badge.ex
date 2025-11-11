defmodule NameBadge do
  def print(id, name, department ) do
    # Please implement the print/3 function
    if (!department) do
      if (id ) do
          "[" <> Integer.to_string(id) <> "] - " <> name <> " - " <> String.upcase("owner")
      else
          name <> " - " <> String.upcase("owner")
      end 
    else
      if (id ) do
          "[" <> Integer.to_string(id) <> "] - " <> name <> " - " <> String.upcase(department)
      else
          name <> " - " <> String.upcase(department)
      end       
    end
    
 
  end
end
