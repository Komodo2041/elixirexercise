defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    # Please implement new_collection/1
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    # Please implement add_card/2
    if MapSet.member?(collection, card) do
        {true, MapSet.put(collection, card)}
    else
       {false, MapSet.put(collection, card)}
    end
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    # Please implement trade_card/3
       if MapSet.member?(collection, your_card) && !MapSet.member?(collection, their_card) do 
           collection = MapSet.delete(collection, your_card)
           collection = MapSet.put(collection, their_card)
           {true, collection}
       else 
           collection = MapSet.delete(collection, your_card)
           collection = MapSet.put(collection, their_card)
          {false, collection}
       end
 
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
     Enum.sort(MapSet.to_list(MapSet.new(cards)))
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    coll = MapSet.difference(your_collection, their_collection)
    MapSet.size(coll)
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards(collections) do
       call = Enum.reduce(collections, Enum.at(collections, 0), fn(el, acc) -> MapSet.intersection(el, acc) end)
      
     Enum.sort(MapSet.to_list(call))
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0
  def total_cards(collections) do
     call = Enum.reduce(collections, Enum.at(collections, 0), fn(el, acc) -> MapSet.union(el, acc)  end)
     MapSet.size(call)
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
     {a, b} = MapSet.split_with(collection, fn v -> String.starts_with?(v, "Shiny") end)
     {Enum.sort(MapSet.to_list(a)), Enum.sort(MapSet.to_list(b))}
  end
end
