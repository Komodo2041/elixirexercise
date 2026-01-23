defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    spawn(fn -> loop(0, 1) end)
  end

defp loop(current \\ 0, open \\ 0) do
    receive do
      {:balance, sender_pid} ->
          if open == 1 do
        send(sender_pid, current) 
        loop(current, open)
        else
           send(sender_pid,  {:error, :account_closed}) 
           loop(current, open)
        end
      {:withdraw, amount, sender_pid } ->
        if open == 1 do
           if amount <= current do
            current = current - amount
            send(sender_pid, current) 
            loop(current, open)
           else
            send(sender_pid, {:error, :not_enough_balance} ) 
            loop(current, open)   
           end 
        else
        send(sender_pid,  {:error, :account_closed}) 
        loop(current, open)
        
        end
        
      {:deposit, amount, sender_pid} -> 
        if open == 1 do
        current = current + amount
        send(sender_pid, current) 
        loop(current, open)
        else
        send(sender_pid,  {:error, :account_closed}) 
        loop(current, open)
        
        end
     {:close, sender_pid} -> 
        open = 0
        send(sender_pid, open) 
        loop(current, open)       
 
      :stop -> nil
      _other ->
        loop(current, open)
    end
  end


  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
      send(account, {:close, self()})
     receive do
        balance when  balance == 0  ->
           :ok
    
        {:error, :account_closed} ->
          {:error, :account_closed}
      after
        1_000 ->    
          {:error, :timeout}
      end
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
     send(account, {:balance, self()})
     receive do
        balance when is_integer(balance) ->
          balance
    
        {:error, :account_closed} ->
          {:error, :account_closed}
      after
        1_000 ->    
          {:error, :timeout}
      end
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) do
      if amount < 0 do
         {:error, :amount_must_be_positive}
      else

       send(account, {:deposit, amount, self()})
       receive do
          balance when is_integer(balance) ->
             :ok
      
          {:error, :account_closed} ->
            {:error, :account_closed}
        after
          1_000 ->    
            {:error, :timeout}
        end
      
      end
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) do
      if amount < 0 do
         {:error, :amount_must_be_positive}
      else

     send(account, {:withdraw, amount, self()})
     receive do
        balance when is_integer(balance) ->
           :ok
         {:error, :not_enough_balance} ->
          {:error, :not_enough_balance}  
        {:error, :account_closed} ->
          {:error, :account_closed}
      after
        1_000 ->    
          {:error, :timeout}
      end


      end
  end
end
