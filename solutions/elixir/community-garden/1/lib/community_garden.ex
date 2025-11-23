# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ "") do
    # Please implement the start/1 function
     Agent.start_link(fn -> [] end )
  end

  def list_registrations(pid) do
    # Please implement the list_registrations/1 function
    res = Agent.get(pid, fn plots -> plots end)
    res = Enum.filter(res, fn(el) -> !Map.has_key?(el, :del) end)
  end

  def register(pid, register_to) do
    # Please implement the register/2 function
  
     plot = Agent.get_and_update(pid, fn(list) ->
        res = length(list) 
        plot =  %Plot{:plot_id => res + 1, :registered_to => register_to}
        {plot, list ++ [plot]}
      end)
 
     plot
  end

  def release(pid, plot_id) do
     Agent.update(pid, fn(list) ->
            list = Enum.map(list, fn(el) -> 
               if el.plot_id == plot_id do 
                  el = Map.put(el, :del, 1)
              else
                  el
              end 
            end)
            list
          end)

      :ok    
  end

  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
    res = CommunityGarden.list_registrations(pid)
    plot = Enum.reduce(res, [], fn(el, acc) -> if el.plot_id == plot_id do el else acc end end)
    if plot == [] do
       { :not_found, "plot is unregistered" }
    else
       plot
    end
  end
end
