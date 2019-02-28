defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> list_of_numbers
    |> image_struct
    |> color_picker
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
  end

  def hash_input(input) do
    :crypto.hash(:md5, input)
  end

  def list_of_numbers(input) do
    :binary.bin_to_list(input)
  end

  def image_struct(input) do
    %Identicon.Image{hex: input}
  end

  def color_picker(%Identicon.Image{hex: [r, g, b | _tail]} = input) do    
    %Identicon.Image{input | color: {r, g, b}}
  end
  
  def build_grid(%Identicon.Image{hex: hex} = input) do
    grid = 
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{input | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = input) do
    grid = Enum.filter grid, fn({x, _index}) -> 
      rem(x, 2) == 0 
    end

    %Identicon.Image{input | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = input) do
    pixel_map = Enum.map grid, fn({_code, index}) -> 
      x = rem(index, 5) * 50
      y = rem(index, 5) * 50
      top = {x, y}
      bottom = {x + 50, y + 50}
      {top, bottom}
    end
    %Identicon.Image{input | pixel_map: pixel_map }
  end

  def calculate_points() do
    
  end
end
