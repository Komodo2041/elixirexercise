defmodule LogParser do
  def valid_line?(line) do
    # Please implement the valid_line?/1 function
    String.match?(line, ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/)  
  end

  def split_line(line) do
    # Please implement the split_line/1 function
    Regex.split(~r/<[-*~=]*>/, line)
  end

  def remove_artifacts(line) do
    # Please implement the remove_artifacts/1 function
    Regex.replace(~r/end-of-line[\d]+/i,  line, "")
     
  end

  def tag_with_user_name(line) do
    # Please implement the tag_with_user_name/1 function
    change = Regex.run(~r/User[\s]+[\w!_🙂АНАСТАСІЯ]+/, line)
    if (change) do
      row = Enum.at(change, 0)
      name = Regex.replace(~r/User[\s]+/, row, "")
      "[USER] " <> name <> " " <> line 
    else
       line 
    end
 
  end
end
