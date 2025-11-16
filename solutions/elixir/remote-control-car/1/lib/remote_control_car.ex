defmodule RemoteControlCar do
  # Please implement the struct with the specified fields
  @enforce_keys [:nickname]
  defstruct [:nickname, distance_driven_in_meters: 0, battery_percentage: 100]

  def new() do
    # Please implement the new/0 function
       %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    # Please implement the new/1 function
     %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car) do
    # Please implement the display_distance/1 function
 
     case remote_car do
       %RemoteControlCar{nickname: nick, distance_driven_in_meters: dist} ->
          {:ok, value} = Map.fetch(remote_car, :distance_driven_in_meters)
          Integer.to_string(value) <> " meters" 
        _ -> raise FunctionClauseError
     end
    
  end

 

  def display_battery(remote_car) do
    # Please implement the display_battery/1 function
     case remote_car do
      %RemoteControlCar{nickname: nick, distance_driven_in_meters: dist, battery_percentage: bp} ->
        if bp == 0 do
           "Battery empty"
        else
           "Battery at " <> Integer.to_string(bp) <> "%"
        end
      _ -> raise FunctionClauseError  
      end  
      
  end

  def drive(remote_car) do
    # Please implement the drive/1 function
      case remote_car do
      %RemoteControlCar{nickname: nick, distance_driven_in_meters: dist, battery_percentage: bp} ->
        if bp == 0 do
           remote_car
        else
           %RemoteControlCar{nickname: nick, distance_driven_in_meters: dist + 20, battery_percentage: bp - 1}
        end
      _ -> raise FunctionClauseError  
      end     
  end
end
