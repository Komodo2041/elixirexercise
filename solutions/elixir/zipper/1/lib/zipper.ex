defmodule Zipper do
 
  @doc """
  Get a zipper focused on the root node.
  """
 
  #@spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
  x = %BinTree{:value => 1, :left => 2, :right => 3}
  
       {bin_tree, bin_tree, []}
      
  end

  @doc """
  Get the complete tree from a zipper.
  """
  #@spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(zipper) do
     {now, tree, prev} = zipper
    
     IO.inspect( %BinTree{value: tree.value, left: tree.left, right: tree.right} )
     %BinTree{:value => tree.value, :left => tree.left, :right => tree.right}
  end

  @doc """
  Get the value of the focus node.
  """
  #@spec value(Zipper.t()) :: any
  def value(zipper) do
     {now, tree, prev} = zipper
     now.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  #@spec left(Zipper.t()) :: Zipper.t() | nil
  def left(zipper) do
     {now, tree, prev} = zipper
     left = now.left
     if left do
        {left, tree, [[now, :left]] ++ prev} 
     else
         nil
     end
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  #@spec right(Zipper.t()) :: Zipper.t() | nil
  def right(zipper) do
     {now, tree, prev} = zipper
     left = now.right
      if left do
        {left, tree, [[now, :right]] ++ prev} 
     else
       nil
     end
       
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  #@spec up(Zipper.t()) :: Zipper.t() | nil
  def up(zipper) do
    {now, tree, prev} = zipper
     if prev != [] do
        [last | old] = prev
       {Enum.at(last, 0), tree, old}
    else
      nil
    end
  end

  @doc """
  Set the value of the focus node.
  """
  #@spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
     {now, tree, prev} = zipper
     now = %BinTree{value: value, left: now.left, right: now.right}
      
     newprev = changeprev(now, prev)
        
     t2 = changetree(now, prev)
     {now, t2, newprev}
  end

  defp changetree(now, []), do: now
  defp changetree(now, [head|tail]) do
  
     level = getlevel(now, head)
     changetree(level, tail)
  end

  defp getlevel(now, head) do
  
     act = Enum.at(head, 0)
   
     if Enum.at(head, 1) == :left do 
        %BinTree{value: act.value, left: now, right: act.right}      
     else 
        %BinTree{value: act.value, left: act.left, right: now}
     end
  end

  defp changeprev(now, []), do: []
  defp changeprev(now, [head|tail]) do
     
     act = Enum.at(head, 0)
     if Enum.at(head, 1) == :left do
     
        [ %BinTree{:value => act.value, :left => now, :right => act.right}, :left] ++ tail
     else
        [ %BinTree{:value => act.value, :left => act.left, :right => now}, :right] ++ tail
     end
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  #@spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
     {now, tree, prev} = zipper
      now = %BinTree{value: now.value, left: left, right: now.right}
      
     newprev = changeprev(now, prev)
        
     t2 = changetree(now, prev)
     {now, t2, newprev}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  #@spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do

     {now, tree, prev} = zipper
      now = %BinTree{value: now.value, left: now.left, right: right}
      
     newprev = changeprev(now, prev)
        
     t2 = changetree(now, prev)
     {now, t2, newprev}
  
  end
 

 
  
end
