defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}
  defstruct [:map]

  @spec new(Enum.t()) :: t
 
  def new([]), do:  %CustomSet{:map => nil} 
  def new(enumerable) do
 
       if is_list(enumerable) do  
          %CustomSet{:map => Enum.uniq(enumerable)} 
       else
          false
       end
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
     if custom_set.map ==  nil || custom_set.map ==  [] do
        true
     else
        false
     end
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
     if custom_set.map do
        element in custom_set.map
     else
        false 
     end
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
       diff = lookup(custom_set_1.map) -- lookup(custom_set_2.map) 
       if diff == [] do
          true
       else
          false
       end   
   
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
      if custom_set_1.map && custom_set_2.map do
        common = Enum.filter(custom_set_1.map, fn(el) -> el in custom_set_2.map end) 
        if common == [] do
           true
        else
           false
        end  
     else
        true
     end       
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
      if custom_set_1.map && custom_set_2.map do
          Enum.sort(custom_set_1.map) == Enum.sort(custom_set_2.map)
      else
         custom_set_1.map == custom_set_2.map
      end
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
     if (custom_set.map) do
       list = Enum.uniq(custom_set.map ++ [element])
       CustomSet.new(list)
     else
       CustomSet.new([element])
     end
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
     common = Enum.filter(lookup(custom_set_1.map), fn(el) -> el in lookup(custom_set_2.map) end)  
     CustomSet.new(common)
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
     diff = lookup(custom_set_1.map) -- lookup(custom_set_2.map)
     CustomSet.new(diff)
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
      list = lookup(custom_set_1.map) ++ lookup(custom_set_2.map)
       CustomSet.new(list)
  end

  defp lookup(nil), do: []
  defp lookup(list), do: list
end
