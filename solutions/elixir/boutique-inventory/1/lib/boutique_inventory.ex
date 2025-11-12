defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    # Please implement the sort_by_price/1 function
    Enum.sort_by(inventory,  fn (el) -> el[:price] end, :asc)
  end

  def with_missing_price(inventory) do
    # Please implement the with_missing_price/1 function
    Enum.filter(inventory, fn (el) -> el[:price] == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    # Please implement the update_names/3 function
      Enum.map(inventory, fn (el ) -> %{:price => el[:price],:name => String.replace(el[:name], old_word, new_word), :quantity_by_size => el[:quantity_by_size]}  end)
  end

  def increase_quantity(item, count) do
    # Please implement the increase_quantity/2 function
    %{:name => item[:name], :price => item[:price], :quantity_by_size => Map.new(item[:quantity_by_size], fn {key, val} -> {key, val + count} end) }
  end
 
  def total_quantity(item) do
    # Please implement the total_quantity/1 function
    Enum.reduce(Map.values(item[:quantity_by_size]), 0, fn x, acc -> x + acc end)
  end
end
