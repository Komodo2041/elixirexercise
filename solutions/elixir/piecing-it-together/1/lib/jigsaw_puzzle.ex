defmodule JigsawPuzzle do
  @doc """
  Fill in missing jigsaw puzzle details from partial data
  """

  @type format() :: :landscape | :portrait | :square
  @type t() :: %__MODULE__{
          pieces: pos_integer() | nil,
          rows: pos_integer() | nil,
          columns: pos_integer() | nil,
          format: format() | nil,
          aspect_ratio: float() | nil,
          border: pos_integer() | nil,
          inside: pos_integer() | nil
        }

  defstruct [:pieces, :rows, :columns, :format, :aspect_ratio, :border, :inside]

  @spec data(jigsaw_puzzle :: JigsawPuzzle.t()) ::
          {:ok, JigsawPuzzle.t()} | {:error, String.t()}
  def data(jigsaw_puzzle) do
      jigsaw_puzzle = go_calc_rowsandcolumns(jigsaw_puzzle)
      jigsaw_puzzle = go_calc_rowsandcolumns(jigsaw_puzzle)
      jigsaw_puzzle = go_calc_rowsandcolumns(jigsaw_puzzle)
      jigsaw_puzzle = go_calc_rowsandcolumns(jigsaw_puzzle)
      jigsaw_puzzle = go_calc_rowsandcolumns(jigsaw_puzzle)
      if jigsaw_puzzle.aspect_ratio do
         if (jigsaw_puzzle.rows != jigsaw_puzzle.columns && jigsaw_puzzle.format == :square) do
              {:error, "Contradictory data"}
         else
              {:ok, jigsaw_puzzle}
         end
     
       else
       {:error, "Insufficient data"}
      end
  end

  defp go_calc_rowsandcolumns(puzzle) do
  
    cond do
         puzzle.border && puzzle.pieces && !puzzle.rows && !puzzle.columns -> useborder(puzzle)
         puzzle.aspect_ratio && ((puzzle.rows && !puzzle.columns) || (!puzzle.rows && puzzle.columns))  -> useratio(puzzle) 
        !puzzle.pieces && puzzle.aspect_ratio == 1.0 && puzzle.inside -> goinside(puzzle)
         puzzle.format == :square && ((puzzle.rows && !puzzle.columns) || (!puzzle.rows && puzzle.columns)) -> calcrowcolumn(puzzle)
         !puzzle.pieces && puzzle.rows && puzzle.columns -> calcpieces(puzzle)
         puzzle.pieces && puzzle.aspect_ratio && !puzzle.rows -> calcrowsandcolumnsfromaspectratio(puzzle)
         !puzzle.aspect_ratio && puzzle.columns && puzzle.rows -> getRatio(puzzle)
         !puzzle.format && puzzle.aspect_ratio -> getformat(puzzle)
         !puzzle.border && puzzle.rows && puzzle.columns -> calcborder(puzzle) 
         true -> puzzle
    end
  end

  defp useborder(puzzle) do
    xplusy = div(puzzle.border, 2) + 2
    table = for x <- 1..xplusy do
       if x * (xplusy - x) == puzzle.pieces do
          x
       else
          []
       end
    end
    res = Enum.filter(table, fn(el) -> el != [] end)
    columns = Enum.at(res, 0)
    rows = round(puzzle.pieces/ columns)
    %{puzzle| :columns => columns, :rows => rows , :inside => puzzle.pieces - puzzle.border}
  end

  defp useratio(puzzle) do
    
     if puzzle.rows do
        %{puzzle| :columns => round(puzzle.rows * puzzle.aspect_ratio )}
     else
       %{puzzle| :rows => round(puzzle.columns / puzzle.aspect_ratio )}
     end
  end

  defp goinside(puzzle) do
 
     size = :math.sqrt(puzzle.inside)
     size = size + 2
      %{puzzle| :pieces => size * size, :rows=>size, :columns => size}
  end

  defp calcpieces(puzzle) do
    IO.inspect("B")
     %{puzzle| :pieces => puzzle.rows * puzzle.columns }
  end

  defp calcrowsandcolumnsfromaspectratio(puzzle) do
    
     rows = round(:math.sqrt(round(puzzle.pieces/ puzzle.aspect_ratio)))
     columns = div(puzzle.pieces, rows)
     %{puzzle| :columns => columns, :rows => rows}
  end

  defp calcrowcolumn(puzzle) do
    
     if puzzle.rows do
        %{puzzle| :columns => puzzle.rows}
     else
       %{puzzle| :rows => puzzle.columns}
     end
  end

  defp getformat(puzzle) do
  
    cond do
       puzzle.aspect_ratio > 1 -> %{puzzle| :format => :landscape}
       puzzle.aspect_ratio == 1 -> %{puzzle| :format => :square}
       puzzle.aspect_ratio < 1 -> %{puzzle| :format => :portrait}
    end 
  end

  defp getRatio(puzzle) do
   
     ratio = puzzle.columns/ puzzle.rows
      %{puzzle| :aspect_ratio => ratio}
  end

  defp calcborder(puzzle) do
   
   bord = 2 * (puzzle.rows + puzzle.columns) - 4
   insode = puzzle.pieces - bord
   %{puzzle| :border => bord, :inside => insode }
  end
  
end
