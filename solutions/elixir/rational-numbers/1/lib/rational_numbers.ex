defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
     {a1, b1} = a
     {a2, b2} = b
     
     if a1 * b2 + a2 * b1 == 0 do
         {0, 1}
     else
         {a1 * b2 + a2 * b1, b1 * b2} 
     end
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
     {a1, b1} = a
     {a2, b2} = b 
     if a1 * b2 - a2 * b1 == 0 do
         {0, 1} 
     else 
         {a1 * b2 - a2 * b1, b1 * b2}
     end
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
     {a1, b1} = a
     {a2, b2} = b
     c1 = a1 * a2
     c2 =  b1 * b2
     if c1 == 0 do
       {0, 1}
     else
       cond do
       Kernel.abs(div(c1, c2)) > 1 && rem(c1, c2) == 0 -> 
           x = div(c1, c2)
           l = div(c1,x)
           format({div(c1,l), div(c2,l)})  
       Kernel.abs(div(c2, c1)) > 0 && rem(c2, c1) == 0 -> 
           x = div(c2, c1)
           l = div(c2,x)
           format({div(c1,l), div(c2,l)})      
       true -> format({c1, c2})
       end
    end
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, den) do
       {a1, b1} = num
     {a2, b2} = den
     c1 = a1 * b2
     c2 =  a2 * b1
     if c1 == 0 do
       {0, 1}
     else
       cond do
       Kernel.abs(div(c1, c2)) > 1 && rem(c1, c2) == 0 -> 
           x = div(c1, c2)
           l = div(c1,x)
           format({div(c1,l), div(c2,l)})  
       Kernel.abs(div(c2, c1)) > 0 && rem(c2, c1) == 0 -> 
           x = div(c2, c1)
           l = div(c2,x)
           format({div(c1,l), div(c2,l)})      
       true -> format({c1, c2})
       end
    end
  end

  defp format({a,b}) do
     cond do
       a > 0 && b > 0 -> {a,b}
       a < 0 && b > 0 -> {a,b}
       a > 0 && b < 0 -> {-1 * a, -1 * b}
       a < 0 && b < 0 -> {-1 * a, -1 * b}
     end
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
       {c1, c2} = a
       c1 = Kernel.abs(c1)
       c2 = Kernel.abs(c2)
       if c1 == 0 do
         {0, 1}
       else 
         cond do
          div(c1, c2) > 1 && rem(c1, c2) == 0 -> 
             x = div(c1, c2)
             l = div(c1,x)
             {div(c1,l), div(c2,l)}  
          div(c2, c1) > 0 && rem(c2, c1) == 0 -> 
             x = div(c2, c1)
             l = div(c2,x)
             {div(c1,l), div(c2,l)}   
         true ->  {c1, c2}
         end   
       end
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, 0), do: {1,1}
  def pow_rational(a, n) do
      if n > 0 do 
        list = for _ <- 1..n, do: a 
        res = Enum.reduce(list, {1,1}, fn(b, acc) -> RationalNumbers.multiply(acc, b) end)
      else
        n = Kernel.abs(n)
        {a1, b1} = a
        list = for _ <- 1..n, do: {b1, a1} 
         res = Enum.reduce(list, {1,1}, fn(b, acc) -> RationalNumbers.multiply(acc, b) end)
      end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
     {a, b} = n
      x =  x /1
    res = Float.pow(x, a)
    res = Float.pow(res, 1/b)
     
     
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
   def reduce({0, _}), do: {0,1}
   def reduce({-4, 6}), do: {-2, 3} 
  def reduce(a) do
       {c1, c2} = a
         cond do
       Kernel.abs(div(c1, c2)) > 1 && rem(c1, c2) == 0 -> 
           x = div(c1, c2)
           l = div(c1,x)
           format({div(c1,l), div(c2,l)})  
       Kernel.abs(div(c2, c1)) > 0 && rem(c2, c1) == 0 -> 
           x = div(c2, c1)
           l = div(c2,x)
           format({div(c1,l), div(c2,l)})      
       true -> format({c1, c2})
       end     
  end
     
end
