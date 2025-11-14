defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    # Your implementation here
    %{:data => data, :left => nil, :right => nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
     
     el =  BinarySearchTree.new(data)
      makeTree(tree, el)
  
  end

  defp makeTree(tree, el) do
     if ( tree[:data] >= el[:data]) do
        if (tree[:left]) do
             %{tree | :left => makeTree(tree[:left], el)}   
        else
             %{tree | :left => el}
        end
        
     else
        if (tree[:right]) do
            %{tree | :right => makeTree(tree[:right], el)}  
        else
           %{tree | :right => el}  
        end    
         
     end
     
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
     list = getList(tree)
     IO.inspect(list)
     list
  end

  defp getList(nil), do: []
  defp getList(tree) do
     getList(tree[:left]) ++ [tree[:data]] ++  getList(tree[:right])
  end
  
end
