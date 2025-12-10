defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
     %{:rools => [], :inframe => 10 , :throw => 0}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(any, integer) :: {:ok, any} | {:error, String.t()}
  def roll(game, roll) do
     if roll < 0 || roll > 10 do
          if roll < 0 do
            {:error, "Negative roll is invalid"}
          else 
            {:error, "Pin count exceeds pins on the lane"}
          end
     else 
         if  length(game.rools) >= 21 || (length(game.rools) == 20 && game.throw == 2) do
           {:error, "Cannot roll after game is over"}
         else
           frame = get_frame(game.inframe - roll, game.throw)
           throw = get_throw(frame, game.throw + 1, roll)
           if (frame < 0) do
              {:error, "Pin count exceeds pins on the lane"}
           else
             game = %{game| :rools => game.rools ++ [roll], :inframe => frame, :throw => throw }
             {:ok, game}
           end
         end
 
     end 
  end

  defp get_throw(frame, throw, roll) do
    if frame == 10 do
       if roll == 0 do
           if throw == 3 do
              0
           else
              throw
           end
       else
          0
       end
        
    else
       if throw == 3 do
          0
       else
          throw
       end
    end
  end

  defp get_frame(x,  throw) do
     if x == 0 do
        10
     else
        if  throw == 2 do
          10
        else
           x
        end
         
     end   
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
      if length(game.rools) < 10 do
        { :error, "Score cannot be taken until the end of the game" }
      else
        frames = Enum.filter( frame_diff(game.rools, []), fn(el) -> el != [] end)
        if Enum.at(frames, length(frames) - 1) == -1  do
           {:error, "Score cannot be taken until the end of the game"}
        else
           countframes = calc_frames(frames, 0, 1)
          
          {:ok, Enum.sum(countframes)}
        end
      end
  end

  defp calc_frames([], _ , nr), do: []
  defp calc_frames([head|tail], last, nr) do
     cond do
      tail == [] && last == 10 -> [0]
      
      true ->
       normalframe = Enum.sum(head)
       
       normal = normalframe + countnextframe(tail, head, last)
        
       [normal] ++ calc_frames(tail, normalframe, nr + 1)     
   
     end
  end

  defp countnextframe([], _, last ), do: 0
  defp countnextframe([next|next2], head, last ) do
     if length(head) > 2 || length(head) <= 0 do
       0
     else
     
        cond do
           Enum.at(head, 0) == 10 && Enum.at(next, 0) == 10  ->
              if next2 != [] do
                 Enum.at(next, 0) +  Enum.at(Enum.at(next2, 0), 0)
              else
                 Enum.at(next, 0) +  Enum.at(next, 1)
              end   
           Enum.at(head, 0) == 10  -> Enum.at(next, 0) +  Enum.at(next, 1)
           Enum.at(head, 0) + Enum.at(head, 1) == 10 ->  Enum.at(next, 0)
           true -> 0
        end
     end
  end


  defp frame_diff([], res), do: [res]
  defp frame_diff([head|tail], res) do
     res = res ++ [head]
     if length(res) == 3 do
        [res] ++ frame_diff(tail, [])
     else
        if Enum.sum(res) == 10  do
            if length(tail) <= 2 do
                  cond do
                   length(res) == 1 &&  length(tail) < 2 -> [res] ++ [-1]
                   length(res) == 2 &&  length(tail) < 1 -> [res] ++ [-1]
                   true -> [res] ++ [tail]
                  end
            else
                 [res] ++ frame_diff(tail, [])
            end
           
        else
            frame_diff(tail, res)
        end
     end

  end
  
end
