defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real(a) do
     {real, imaginare} = a
     real
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary(a) do
     {real, imaginare} = a
     imaginare
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) do
     {one_r, one_i} = checkinteger(a)
     {two_r, two_i} = checkinteger(b)
     {one_r * two_r - one_i * two_i, one_r*two_i + one_i * two_r}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) do
     {one_r, one_i} = checkinteger(a)
     {two_r, two_i} = checkinteger(b)
     {one_r + two_r,  one_i + two_i}  
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) do
     {one_r, one_i} = checkinteger(a)
     {two_r, two_i} = checkinteger(b)
     {one_r - two_r,  one_i - two_i} 
  end

  def checkinteger(i) do
    if is_integer(i) do
       {i, 0}
    else
       i
    end
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) do
     {one_r, one_i} = checkinteger(a)
     {two_r, two_i} = checkinteger(b)
     denominator = two_r * two_r + two_i * two_i
    real = (one_r * two_r + one_i * two_i) / denominator
    imag = (one_i * two_r - one_r * two_i) / denominator
    {real, imag}
  end
 
  
  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs(a) do
       {one_r, one_i} = a
       :math.sqrt(one_r ** 2 + one_i ** 2)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate(a) do
      {one_r, one_i} = a
      {one_r, -1 * one_i}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp(a) do
    {one_r, one_i} = checkinteger(a)
     ea = :math.exp(one_r)          # e^a
    {ea * :math.cos(one_i), ea * :math.sin(one_i)}
  end
end
