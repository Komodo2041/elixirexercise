defmodule ZebraPuzzle do
  @nations ["english", "spaniard", "ukrainian", "norwegian", "japanese"]
  @colours ["red", "green", "ivory", "yellow", "blue"]
  @drinks ["coffee", "tea", "milk", "orange", "water"]
  @pets ["dog", "snails", "fox", "horse", "zebra"]
  @hobbies ["dancing", "painter", "reading", "football", "chess"]
  def solve do
    houses =
      for pos <- 1..5 do
        %{pos: pos, nation: nil, colour: nil, drink: nil, pet: nil, hobby: nil}
      end
    search(houses)
  end
  # Backtracking-Search
  defp search(houses) do
    case unassigned(houses) do
      nil ->
        if valid?(houses), do: houses, else: nil
      {pos, key, domain} ->
        Enum.find_value(domain, fn val ->
          new_houses = assign(houses, pos, key, val)
          if consistent?(new_houses) do
            search(new_houses)
          else
            nil
          end
        end)
    end
  end
  defp unassigned(houses) do
    Enum.find_value(houses, fn %{pos: pos} = h ->
      cond do
        h.nation == nil -> {pos, :nation, @nations}
        h.colour == nil -> {pos, :colour, @colours}
        h.drink == nil -> {pos, :drink, @drinks}
        h.pet == nil -> {pos, :pet, @pets}
        h.hobby == nil -> {pos, :hobby, @hobbies}
        true -> nil
      end
    end)
  end
  defp assign(houses, pos, key, val) do
    Enum.map(houses, fn
      %{pos: ^pos} = h -> Map.put(h, key, val)
      h -> h
    end)
  end
  # Konsistenzprüfung: keine Doppelwerte und alle Constraints ok
  defp consistent?(houses) do
    unique?(houses, :nation) and
      unique?(houses, :colour) and
      unique?(houses, :drink) and
      unique?(houses, :pet) and
      unique?(houses, :hobby) and
      Enum.all?(constraints(), & &1.(houses))
  end
  defp unique?(houses, key) do
    values =
      houses
      |> Enum.map(&Map.get(&1, key))
      |> Enum.reject(&is_nil/1)
    length(values) == length(Enum.uniq(values))
  end
  defp valid?(houses), do: consistent?(houses)
  defp constraints do
    [
      # Englishman -> red
      fn h -> implies(find(h, :nation, "english"), :colour, "red") end,
      # Spaniard -> dog
      fn h -> implies(find(h, :nation, "spaniard"), :pet, "dog") end,
      # Green -> coffee
      fn h -> implies(find(h, :colour, "green"), :drink, "coffee") end,
      # Ukrainian -> tea
      fn h -> implies(find(h, :nation, "ukrainian"), :drink, "tea") end,
      # Green right of ivory
      fn h ->
        case {index(h, :colour, "green"), index(h, :colour, "ivory")} do
          {nil, _} -> true
          {_, nil} -> true
          {g, i} -> g == i + 1
        end
      end,
      # Snails -> dancing
      fn h -> implies(find(h, :pet, "snails"), :hobby, "dancing") end,
      # Yellow -> painter
      fn h -> implies(find(h, :colour, "yellow"), :hobby, "painter") end,
      # Middle -> milk
      fn h -> at_pos(h, 3, :drink, "milk") end,
      # First -> norwegian
      fn h -> at_pos(h, 1, :nation, "norwegian") end,
      # Reader next to fox
      fn h -> neighbor(h, :hobby, "reading", :pet, "fox") end,
      # Painter next to horse
      fn h -> neighbor(h, :hobby, "painter", :pet, "horse") end,
      # Football -> orange
      fn h -> implies(find(h, :hobby, "football"), :drink, "orange") end,
      # Japanese -> chess
      fn h -> implies(find(h, :nation, "japanese"), :hobby, "chess") end,
      # Norwegian next to blue
      fn h -> neighbor(h, :nation, "norwegian", :colour, "blue") end
    ]
  end
  defp find(houses, key, val), do: Enum.find(houses, &(Map.get(&1, key) == val))
  defp index(houses, key, val) do
    case find(houses, key, val) do
      nil -> nil
      %{pos: p} -> p
    end
  end
  defp implies(nil, _key, _val), do: true
  defp implies(house, key, val) do
    case Map.get(house, key) do
      nil -> true
      v -> v == val
    end
  end
  defp at_pos(houses, pos, key, val) do
    case Enum.find(houses, &(&1.pos == pos)) do
      nil ->
        true
      house ->
        case Map.get(house, key) do
          nil -> true
          v -> v == val
        end
    end
  end
  defp neighbor(houses, k1, v1, k2, v2) do
    case {index(houses, k1, v1), index(houses, k2, v2)} do
      {nil, _} -> true
      {_, nil} -> true
      {i1, i2} -> abs(i1 - i2) == 1
    end
  end
  @doc """
  Determine who drinks the water
  """
  @spec drinks_water() :: atom
  def drinks_water() do
    solve()
    |> Enum.find_value(fn house ->
      if house.drink == "water" do
        String.to_atom(house.nation)
      end
    end)
  end
  @doc """
  Determine who owns the zebra
  """
  @spec owns_zebra() :: atom
  def owns_zebra() do
    solve()
    |> Enum.find_value(fn house ->
      if house.pet == "zebra" do
        String.to_atom(house.nation)
      end
    end)
  end
end