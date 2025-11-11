defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    # Please implement the get_volume/1 function
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) do
    # Please implement the to_milliliter/1 functions
    case  elem(volume_pair, 0) do
      :milliliter -> volume_pair
      :cup -> {:milliliter, get_volume(volume_pair) * 240}
      :fluid_ounce -> {:milliliter, get_volume(volume_pair) * 30}
      :teaspoon -> {:milliliter, get_volume(volume_pair) * 5}
      :tablespoon -> {:milliliter, get_volume(volume_pair) * 15}
    end
   
  end

  def from_milliliter(volume_pair, unit) do
    # Please implement the from_milliliter/2 functions
     case unit do
      :milliliter -> volume_pair
      :cup -> {:cup, get_volume(volume_pair) / 240}
      :fluid_ounce -> {:fluid_ounce, get_volume(volume_pair) / 30}
      :teaspoon -> {:teaspoon, get_volume(volume_pair) / 5}
      :tablespoon -> {:tablespoon, get_volume(volume_pair) / 15}
    end
  end

  def convert(volume_pair, unit) do
    # Please implement the convert/2 function
    mil_pair = KitchenCalculator.to_milliliter(volume_pair)
    KitchenCalculator.from_milliliter( mil_pair, unit)
  end
end
