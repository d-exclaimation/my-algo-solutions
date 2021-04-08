#
#  Math.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:05 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule MyMath do
  @moduledoc """
  Mathematical computation
  """
  @doc """
  Square root of a value
  """
  def square_root_f(val) when val <= 1, do: val
  def square_root_f(val) do
    2..div(val, 2)
    |> Enum.filter(fn x -> x * x <= val end)
    |> Enum.fetch!(-1)
  end

  @doc """
  Add one to the number list
  """
  def add_list(num_list, carry) when carry == 0, do: num_list
  def add_list(num_list, carry) do
    last = Enum.fetch!(num_list, -1) + carry
    if last > 9 do
      add_list(Enum.slice(num_list, 0..-2), 1) ++ [rem(last, 10)]
    else
      add_list(Enum.slice(num_list, 0..-2), 0) ++ [last]
    end
  end

  @doc """
  Square root
  -> num: integer
  """
  def square_root(num) do
    Float.round(find_square(num, num / 2), 2)
  end

  defp find_square(num, guess) when abs(num - (guess * guess)) < 0.001, do: guess
  defp find_square(num, guess) do
    next_guess = (guess + num/guess) / 2
    find_square(num, next_guess)
  end


  @doc """
  Generate all subsets
  -> arr: list(integer)
  :: list(list(integer)
  """
  def generate_subset([head | rest]) when length(rest) == 0, do: [[head]]
  def generate_subset([head | rest]) do
    _gen_subset([head | rest], 0, [head]) ++ generate_subset(rest)
  end

  defp _gen_subset(arr, idx, curr) when length(arr) == idx + 1, do: curr
  defp _gen_subset(arr, idx, curr) do
     [curr | idx + 1..length(arr) - 1
           |> Enum.map(fn i -> _gen_subset(arr, i, curr ++ [Enum.at(arr, i)]) end)
           |> Enum.reduce([], fn x, acc -> acc ++ if is_list(Enum.at(x, 0)), do: x, else: [x] end)]
  end

end
