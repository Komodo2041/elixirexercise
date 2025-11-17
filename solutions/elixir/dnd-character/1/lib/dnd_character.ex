defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
      floor((score - 10)/ 2)
  end

  @spec ability :: pos_integer()
  def ability do
   
     catches = for x <- Enum.to_list(1..4), do: Enum.random(1..6)
     Enum.sum(catches) - Enum.min(catches)
  end
 

  @spec character :: t()
  def character do
     constitution = DndCharacter.ability()
     %{:strength => DndCharacter.ability(),
     :dexterity => DndCharacter.ability(),
     :constitution => constitution,
     :intelligence => DndCharacter.ability(),
     :wisdom => DndCharacter.ability(),
     :charisma => DndCharacter.ability(),
     :hitpoints => 10 + DndCharacter.modifier(constitution)
     }
  end
end
