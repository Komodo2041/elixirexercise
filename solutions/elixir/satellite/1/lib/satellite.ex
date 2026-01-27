defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}

  def build_tree([], []), do: {:ok, {}}
    def build_tree(preorder, inorder) when length(preorder) != length(inorder), do: {:error, "traversals must have the same length"}
 
  def build_tree(preorder, inorder) do
 
       cond do
          preorder -- inorder != []  -> {:error, "traversals must have the same elements"}
          Enum.uniq(preorder) != preorder -> {:error, "traversals must contain unique items"}
          Enum.uniq(inorder) != inorder -> {:error, "traversals must contain unique items"}
          length(inorder) == 1 -> {:ok, {{}, Enum.at(inorder, 0), {}}}
          true -> 
             res = create_tree(preorder, inorder)
             {:ok, res}
       end
  end

  defp create_tree(preorder, inorder) do
       cond do
       length(inorder) == 0 -> {}
       length(inorder) == 1 -> {{}, Enum.at(inorder, 0) ,{}}
       true ->
          {part1, restorder} = geteleminorder(preorder, inorder)
          {inpart1, inpart2 } = diff(inorder, part1, []) 
          { create_tree(preorder, inpart1), part1,  create_tree(preorder, inpart2)}
       end
  end

 defp geteleminorder([], inorder), do: raise ErrorDiffer
  defp geteleminorder([head|tail], inorder) do
     if head in inorder do
        {head, tail}
     else
        geteleminorder(tail, inorder)
     end
  end

  defp diff([], part1, result), do: {result, []}
  defp diff([head|tail], part1, result) do
       if head == part1 do
          {result, tail}
       else
          result = result ++ [head]
          diff(tail, part1, result)
       end
  end
  
end
