defmodule SplitSecondStopwatch do
  @doc """
  A stopwatch that can be used to track lap times.
  """

  @type state :: :ready | :running | :stopped

  defmodule Stopwatch do
    @type t :: :todo
    defstruct [:todo]
  end

  @spec new() :: Stopwatch.t()
  def new() do
     %{:state => :ready, :laps => [], :startTime => ~T[00:00:00], :stopTime => ~T[00:00:00]}
  end

  @spec state(Stopwatch.t()) :: state()
  def state(stopwatch) do
      stopwatch.state
  end

  @spec current_lap(Stopwatch.t()) :: Time.t()
  def current_lap(stopwatch) do 
      res = addLapTime(stopwatch.stopTime, stopwatch.laps)
  end

  @spec previous_laps(Stopwatch.t()) :: [Time.t()]
  def previous_laps(stopwatch) do
     stopwatch.laps       
  end

  @spec advance_time(Stopwatch.t(), Time.t()) :: Stopwatch.t()
  def advance_time(stopwatch, time) do
     case stopwatch.state do
        :ready -> stopwatch
        :stopped -> stopwatch
        :running -> %{stopwatch| :stopTime => addTime(stopwatch.stopTime, time) }
     end     
  end

  defp addTime(time1, time2) do
     diff1 = Time.diff(time1, ~T[00:00:00])
     diff2 = Time.diff(time2, ~T[00:00:00])
    Time.from_seconds_after_midnight(diff1 + diff2)
  end

  @spec total(Stopwatch.t()) :: Time.t()
  def total(stopwatch) do
     if stopwatch.state == :ready do
        stopwatch.stopTime
     else
       #Time.diff(stopwatch.stopTime, stopwatch.startTime)
       stopwatch.stopTime
     end
    
  end

  @spec start(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def start(stopwatch) do
     case stopwatch.state do
        :ready -> %{stopwatch| :state => :running, :startTime => Time.utc_now() }
        :stopped -> %{stopwatch| :state => :running, :startTime => Time.utc_now() }
        :running -> {:error, "cannot start an already running stopwatch"}
     end
  end

  @spec stop(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def stop(stopwatch) do
     case stopwatch.state do
        :ready -> {:error, "cannot stop a stopwatch that is not running"} 
        :stopped -> {:error, "cannot stop a stopwatch that is not running"} 
       # :running -> %{stopwatch| :state => :stopped, :stopTime => Time.utc_now() } 
       :running -> %{stopwatch| :state => :stopped } 
     end
  end

  @spec lap(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def lap(stopwatch) do
       case stopwatch.state do
        :ready -> {:error, "cannot lap a stopwatch that is not running"}
        :stopped -> {:error, "cannot lap a stopwatch that is not running"}
        :running -> %{stopwatch| :laps => stopwatch.laps ++ [addLapTime(stopwatch.stopTime, stopwatch.laps)]  } 
     end
  end

  defp addLapTime(stopm, laps) do
     if length(laps) > 0 do
        lastlap = Enum.at(laps, length(laps) - 1)
         diff1 = Time.diff(lastlap, ~T[00:00:00])
         sumLaps = sumAllLaps(laps)
         
         diff2 = Time.diff(stopm, ~T[00:00:00])
         Time.from_seconds_after_midnight(diff2 - sumLaps)      
     else
        stopm
     end
  end

  defp sumAllLaps([]), do: 0
  defp sumAllLaps([head|tail]) do
      diff = Time.diff(head, ~T[00:00:00])
      diff + sumAllLaps(tail)
  end

  @spec reset(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def reset(stopwatch) do
     case stopwatch.state do
     :ready -> {:error, "cannot reset a stopwatch that is not stopped"}
     :running -> {:error, "cannot reset a stopwatch that is not stopped"}
     :stopped -> %{stopwatch | :state => :ready, :stopTime => ~T[00:00:00], :laps => []}
     end
  end
end
