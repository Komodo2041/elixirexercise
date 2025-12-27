defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: any) :: {:ok, opts} | {:error, error}
  def init(opts) do
    {:ok, opts}
  end
  # Please implement the module
  @callback handle_frame(dot :: any, frame :: any, opts :: any) :: any
  def handle_frame(dot, frame, options) do
     raise "handle_frame/3 must be implemented by the using module"
  end

 defmacro __using__(_opts) do
    quote do
      @behaviour DancingDots.Animation

      @impl DancingDots.Animation
      def init(opts), do: DancingDots.Animation.init(opts)

      # Nadpisywanie init/1 jest dozwolone, więc używamy @impl true
      defoverridable init: 1

      # handle_frame/3 musi być zaimplementowane przez moduł używający
      # więc nie podajemy tu ciała (lub podajemy raise jak powyżej)
    end
  end
  
end

defmodule DancingDots.Flicker do
use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame, _opts) do
    if rem(frame, 4) == 0 do
      # Klatka jest wielokrotnością 4 → zmniejsz opacity do połowy
      %{dot | opacity: dot.opacity / 2}
    else
      # Pozostałe klatki → kropka bez zmian
      dot
    end
  end
end

defmodule DancingDots.Zoom do
use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    # Sprawdzenie, czy opts to keyword list z kluczem :velocity
    if Keyword.keyword?(opts) and Keyword.has_key?(opts, :velocity) do
      velocity = opts[:velocity]

      if is_number(velocity) do
        {:ok, opts}
      else
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
      end
    else
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(opts[:velocity])}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame, opts) do
    velocity = opts[:velocity]
    # Zwiększenie promienia o (frame - 1) * velocity
    # Dla frame = 1: (1 - 1) * velocity = 0 → promień bez zmian
    # Dla frame = 2: (2 - 1) * velocity = 1 * velocity → +velocity
    new_radius = dot.radius + (frame - 1) * velocity
    %{dot | radius: new_radius}
  end
end
