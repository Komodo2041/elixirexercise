defmodule GuessingGame do
  def compare(secret_number, guess) when secret_number == guess do
    "Correct"
   end  
  def compare(secret_number, guess) when abs( secret_number - guess) == 1 do
    "So close"  
   end     
  def compare(secret_number, guess \\ "x") when guess == "x" do
    "Make a guess"  
   end  
  def compare(secret_number, guess) when guess == :no_guess do
    "Make a guess"   
   end     
  def compare(secret_number, guess) when secret_number < guess do
    "Too high"   
   end    
  def compare(secret_number, guess) when secret_number > guess do
    "Too low"     
    # Please implement the compare/2 function
  end
end
