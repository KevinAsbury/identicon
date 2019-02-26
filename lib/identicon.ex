defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> list_of_numbers
  end

  def hash_input(input) do
    :crypto.hash(:md5, input)
  end

  def list_of_numbers(input) do
    :binary.bin_to_list(input)
  end
end
