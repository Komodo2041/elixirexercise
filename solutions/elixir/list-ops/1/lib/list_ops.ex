defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do 
     length(l)
  end

  @spec reverse(list) :: list
  def reverse(l) do
     Enum.reverse(l)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
     Enum.map(l, fn(el) -> f.(el) end)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
      Enum.filter(l, fn(el) -> f.(el) end)
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f) do
     Enum.reduce(l, acc, fn(el, acc) -> f.(el, acc) end)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
     Enum.reduce(Enum.reverse(l), acc, fn(el, acc) -> f.(el, acc) end)
  end

  @spec append(list, list) :: list
  def append(a, b) do
     a ++ b
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
     Enum.concat(ll)
  end
end
