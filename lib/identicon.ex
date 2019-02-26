defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> list_of_numbers
    |> image_struct
    |> color_picker
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
end
