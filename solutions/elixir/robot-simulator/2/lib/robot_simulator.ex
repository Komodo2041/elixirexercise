defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0,0}) do
     if  direction in [:north, :east, :south, :west ] do
       robot = savedirection(%{}, direction)
       checkpos = checkposition(position)
       if (checkpos) do
         robot = savepos(robot, position)
         robot      
       else
         {:error, "invalid position"}
       end
     else
       {:error, "invalid direction"}
     end
 
  end

  defp checkposition({a, b}) do
     if is_integer(a) && is_integer(b) do
        true
     else
        false
     end
  end
   
  defp checkposition(_),  do: false
 
  defp savedirection(robot, direction) do
      Map.put(robot, :direction, direction)
  end

  defp savepos(robot, position) do
      Map.put(robot, :position, position)
  end
  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
      table = String.graphemes(instructions)
      check = checkinstruction(table, true)
      if check do
         gorobot(robot, table)
      else
         {:error, "invalid instruction"}
      end 
  end

  defp checkinstruction([], res), do: res
  defp checkinstruction([head|tail], res) do
     if head in ["R", "L", "A"] do
        checkinstruction( tail, res)
     else
        checkinstruction( tail, false)
     end
  end

  defp gorobot(robot, []), do: robot 
  defp gorobot(robot, [head|tail]) do
     robot = behave(robot, head)
     gorobot(robot, tail) 
  end
 
  defp behave(robot, order) do
     {x, y} = robot.position
     cond do
        robot.direction == :north && order == "R" -> Map.put(robot, :direction, :east)             
        robot.direction == :east && order == "R" -> Map.put(robot, :direction, :south) 
        robot.direction == :south && order == "R" -> Map.put(robot, :direction, :west) 
        robot.direction == :west && order == "R" -> Map.put(robot, :direction, :north) 
         robot.direction == :north && order == "L" -> Map.put(robot, :direction, :west) 
        robot.direction == :east && order == "L" -> Map.put(robot, :direction, :north) 
        robot.direction == :south && order == "L" -> Map.put(robot, :direction, :east) 
        robot.direction == :west && order == "L" -> Map.put(robot, :direction, :south) 
         robot.direction == :north && order == "A" -> Map.put(robot, :position, {x ,y + 1}) 
        robot.direction == :east && order == "A" -> Map.put(robot, :position, {x + 1 , y}) 
        robot.direction == :south && order == "A" -> Map.put(robot, :position, {x ,y - 1})  
        robot.direction == :west && order == "A" -> Map.put(robot, :position, {x - 1, y})    
        true -> robot
     end
  end
  

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
      robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
     robot.position
  end
end
