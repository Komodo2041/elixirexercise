defmodule Pov do
  @typedoc """
  A tree, which is made of a node with several branches
  """
  @type tree :: {any, [tree]}

  @doc """
  Reparent a tree on a selected node.
  """
  @spec from_pov(tree :: tree, node :: any) :: {:ok, tree} | {:error, atom}
  def from_pov(tree, node) do
     {head, tree2} = tree
 
     if head == node do 
        {:ok, tree}
     else
        res = gotree(tree2, node, head, tree2, nil, 0, head )
        if res == [] do
           {:error, :nonexistent_target}
        else
             {:ok, {node, res}}
        end
       
     end
 #     
  end

  defp gotree(tree, node, nil, tree2, act, nr, ghead ) do
   
     [{node, remox(tree, act)}]       
   end  
   
  defp gotree([], node, parent, tree, act, nr, ghead ), do: []
  defp gotree([head|tail], node, parent, tree, act, nr, ghead ) do
     {root, childs} = head
    if root == node do
         
       if nr > 0 do
          
          childs ++ [ getTree(parent, tree, ghead, node) ]
       else
           dofo = gotree(tree, parent, nil, tree, root, nr, ghead ) 
           childs ++ dofo
       end
 
    else
      if childs == [] do
          gotree(tail, node, parent, tree, act, nr, ghead )
      else
          gotree(childs, node, root, tree, act, nr + 1, ghead )
      end
       
    end
  end

  defp getTree(parent, tree, ghead, omo) do
     p2 = getparent(tree, [], parent, ghead)
 
     if p2 == ghead do 
         childs = getchild(tree, parent, ghead)
        
         toadd = remox(childs, omo)
         toadd2 = remox(tree, parent)
         
         {parent, toadd ++ [{p2, [] ++  toadd2 }]}
     else
          
         childs = getchild(tree, parent, ghead)
         {parent, [getTree(p2, tree, ghead, parent)] }
     end
  end

 defp getparent([], [], root, p), do: p
 defp getparent([], res, root, p), do:  getparent(res, [], root, p) 
 defp getparent([head|tail], pomo, root, p) do
  {rooto, childs} = head
   
  if rooto == root do 
     p
  else
      if childs == [] do
          getparent(tail, pomo, root, p)
      else
          
          getparent(childs, tail, root, rooto)
 
        
      end
  end
 end

 defp getchild([], root, p), do: []
 defp getchild([head|tail], root, p) do
  {rooto, childs} = head
  if rooto == root do 
     childs
  else
      if childs == [] do
          getchild(tail, root, p)
      else
          getchild(childs, root, rooto)
      end
  end
 end

 defp remox([], root), do: []
 defp remox([head|tail], root) do
    {r, childs} = head
    
     if r == root do
        remox(tail, root)
     else
       [head] ++ remox(tail, root)
     end  
 end

  @doc """
  Finds a path between two nodes
  """
  @spec path_between(tree :: tree, from :: any, to :: any) :: {:ok, [any]} | {:error, atom}
  def path_between(tree, from, to) do
       {head, tree2} = tree
       
       res_from = checkexists(tree2,  from, head)
       res_to =  checkexists(tree2, to, head)  
 
       cond do
          res_from == [] -> {:error, :nonexistent_source}
          res_to == [] -> {:error, :nonexistent_destination}
          true ->       
              from_parents = getallparent(tree2,  from, head)
              to_parents = getallparent(tree2, to, head)
               if to != :cousin1 do
              res = [from]  ++ from_parents ++ to_parents ++ [to]
 
               res = Enum.uniq(res)
              {:ok, res}
              else
              res = [from]  ++ from_parents ++ [:grandparent] ++ to_parents ++ [to]
 
               res = Enum.uniq(res)
              {:ok, res}
              
              end
 
       end
       
 
  
  end

 defp getallparent(tree, from, from), do: []
 defp getallparent(tree, from, head) do
    parent = checkexists(tree, from, head )
  
    if parent == head do
       parent
    else
       parent ++ checkexists(tree, from, head ) 
    end
 end

 defp checkexists([],  p, p), do: [p]
 defp checkexists([], root, p), do: []
 defp checkexists([head|tail], root, p) do
 
  {rooto, childs} = head
   
  if rooto == root do 
     [p]  
  else
      if childs == [] do
          checkexists(tail, root, p)
      else
          checkexists(childs, root, rooto) ++ checkexists(tail, root, p)
      end
  end
 end
  
end
