defmodule Username do
  def sanitize(username) do
    # ä becomes ae 228 ->  97, 101
    # ö becomes oe 246 -> 111, 101
    # ü becomes ue 252 -> 117, 101
    # ß becomes ss
 
     username = Enum.filter(username, fn x -> (x > 96  && x < 123) || x == 223 ||  x == 228 || x == 246 || x == 252 || x == 95   end)
     if (username) do
        nawa = to_string(username) 
       nawa = String.replace(nawa, "ä", "ae");
       nawa = String.replace(nawa, "ö", "oe");
       nawa = String.replace(nawa, "ü", "ue");
       nawa = String.replace(nawa, "ß", "ss");
    
       username = to_charlist(nawa)
     else 
       ""
     end  
      
    # Please implement the sanitize/1 function
  end
 
 
end
