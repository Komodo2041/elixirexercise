defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    # Please implement the palette_bit_size/1 function
    countNumber(color_count - 1, 0)
  end

  def countNumber(color_count, bit) do
       if (color_count == 0  ) do
          bit 
       else
          countNumber(div(color_count, 2), bit + 1)
       end
  end

  def empty_picture() do
    # Please implement the empty_picture/0 function
    <<>>
  end

  def test_picture() do
    # Please implement the test_picture/0 function
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    # Please implement the prepend_pixel/3 function
    size = PaintByNumber.palette_bit_size(color_count)
    pallete = <<pixel_color_index::size(size)  >>
      
    <<pallete::bitstring  , picture::bitstring>>
   # pallete
  end

  def get_first_pixel(picture, color_count) do
    # Please implement the get_first_pixel/2 function
    if (picture == "") do
       nil
    else
      size = PaintByNumber.palette_bit_size(color_count)
      <<first_pixel::size(size), _rest::bitstring>> = picture
      first_pixel    
    end
 
  end

  def drop_first_pixel(picture, color_count) do
    # Please implement the drop_first_pixel/2 function
     if (picture == "") do
       picture
    else   
        size = PaintByNumber.palette_bit_size(color_count)
      <<first_pixel::size(size), _rest::bitstring>> = picture
      _rest
    end
  end

  def concat_pictures(picture1, picture2) do
    # Please implement the concat_pictures/2 function
    <<picture1::bitstring, picture2::bitstring>>
  end
end
