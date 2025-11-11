defmodule RPG.CharacterSheet do
  def welcome() do
    # Please implement the welcome/0 function
    IO.puts("Welcome! Let's fill out your character sheet together.")
    :ok
  end

  def ask_name() do
    # Please implement the ask_name/0 function
    name = IO.gets("What is your character's name?\n")
    String.trim(name)
  end

  def ask_class() do
    # Please implement the ask_class/0 function
    name = IO.gets("What is your character's class?\n")
    String.trim(name)    
  end

  def ask_level() do
    # Please implement the ask_level/0 function
    name = IO.gets("What is your character's level?\n")
    String.to_integer(String.trim(name))      
  end

  def run() do
    name = IO.gets("Welcome! Let's fill out your character sheet together.\nWhat is your character's name?\nWhat is your character's class?\nWhat is your character's level?\n")
    name = String.trim(name)
     class = RPG.CharacterSheet.ask_class()
     level = RPG.CharacterSheet.ask_level()
       IO.puts("Your character: %{name: \"Anne\", level: 4, class: \""<> class <> "\"}")
     %{:name => name, :class => class, :level => level}
  end
end
