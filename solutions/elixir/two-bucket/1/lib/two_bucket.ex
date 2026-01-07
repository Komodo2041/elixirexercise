defmodule TwoBucket do
  defstruct [:bucket_one, :bucket_two, :moves]
  @type t :: %TwoBucket{bucket_one: integer, bucket_two: integer, moves: integer}

  @doc """
  Find the quickest way to fill a bucket with some amount of water from two buckets of specific sizes.
  """
  @spec measure(
          size_one :: integer,
          size_two :: integer,
          goal :: integer,
          start_bucket :: :one | :two
        ) :: {:ok, TwoBucket.t()} | {:error, :impossible}

 def measure(size_one, goal, goal, :one) do
     {:ok, %TwoBucket{bucket_one: size_one, bucket_two: goal, moves: 2}}
 end    

 def measure(size_one, size_two, goal, start_bucket) when goal > size_two and goal > size_one,  do: {:error, :impossible}     
 
  def measure(size_one, size_two, goal, start_bucket) do

 
      # USED RANDOM - IS BRUTAL FORCE :)
     {first, two} = gofirstmove(size_one, size_two, start_bucket)
 
     res = for _ <- 1..80000 do
         action(first, two, size_one, size_two, goal, 1, start_bucket)
     end |> Enum.filter( fn(el) -> el != [] end)
 
     if res != [] do
       res = Enum.sort(res, fn(el1, el2) -> el1 < el2 end) 
   
       result = Enum.at(res, 0)
       {:ok, %TwoBucket{bucket_one: Enum.at(result, 0), bucket_two: Enum.at(result, 1), moves: Enum.at(result, 2)}}
     else
       {:error, :impossible}
     end
    
  end

 


  defp gofirstmove2(size_one, size_two, start_bucket) do
    if start_bucket == :one do
       {size_one, 0, size_one, size_two}
    else
        {size_two, 0, size_two, size_one}
    end
  end


  defp gofirstmove(size_one, size_two, start_bucket) do
    if start_bucket == :one do
       {size_one, 0}
    else
        {0, size_two}
    end
  end

  defp action(goal, two, onemax, twomax, goal, move, start_bucket)  do
     [goal, two, move]
  end   
  defp action(one, goal, onemax, twomax, goal, move, start_bucket) do
     [one, goal, move]
  end
  
  defp action(one, two, onemax, twomax, goal, move, start_bucket) when move > 30, do: []
  defp action(one, two, onemax, twomax, goal, move, start_bucket) do
     
    x = Enum.random(1..5) 
    chooseaction = changeChoose(x, one, two, onemax, twomax, start_bucket)

    
     
     case chooseaction do
        1 -> 
           if start_bucket == :one do
             {newone, newtwo} = fill(one, two, onemax, twomax)   
             action(newone, newtwo, onemax, twomax, goal, move + 1, start_bucket) 
           else
             {newtwo, newone} = fill(two, one, twomax, onemax)
             action(newone, newtwo, onemax, twomax, goal, move + 1, start_bucket) 
           end
        2 -> action(0, two, onemax, twomax, goal, move + 1, start_bucket)
        3 -> action(one, 0, onemax, twomax, goal, move + 1, start_bucket) 
        4 -> action(onemax, two, onemax, twomax, goal, move + 1, start_bucket)
        5 -> action(one, twomax, onemax, twomax, goal, move + 1, start_bucket)         
     end 
  end
 

  defp changeChoose(action, one, two, onemax, twomax, start_bucket) do
     
     cond do
     action == 2 && one == 0 -> 1
     action == 2 && two == 0 -> 1
     action == 3 && two == 0 -> 1
     action == 3 && one == 0 -> 1
     action == 4 && one == onemax -> 1
     action == 4 && two == twomax -> 1
     action == 5 && two == twomax -> 1
     action == 5 && one == onemax -> 1
     action == 1 && start_bucket == :one && one == 0 -> 4
     action == 1 && start_bucket == :two && two == 0 -> 5
     action == 1 && start_bucket == :one && two == twomax -> 3
     action == 1 && start_bucket == :two && one == onemax -> 2
     true -> action 
     end
  end

  defp fill(one, two, onemax, twomax) do
     cond do
        one == 0 -> {one, two}
        one + two > twomax ->
 
         {one + two - twomax, twomax}
        true -> {0, one + two}
     end
  end

  
end
