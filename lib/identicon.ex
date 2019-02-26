defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> list_of_numbers
    |> image_struct
    |> color_picker
    |> build_grid
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
  
  def build_grid(%Identicon.Image{hex: hex}) do
    hex
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_row/1)
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end
end
