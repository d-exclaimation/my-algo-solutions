#
#  PhoneNumber.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10=>06 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule PhoneNumber do
  @moduledoc """
  Phone Number Module
  1, 2, 3,
  4, 5, 6,
  7, 8, 9
  """

  @doc """
  Num pad map
  """
  def num_pads do
    %{
      1 => [],
      2 => ["a", "b", "c"],
      3 => ["d", "e", "f"],
      4 => ["g", "h", "i"],
      5 => ["j", "k", "l"],
      6 => ["m", "n", "o"],
      7 => ["p", "q", "r", "s"],
      8 => ["t", "u", "v"],
      9 => ["w", "x", "y", "z"],
      0 => []
    }
  end

  @doc """
  Make Words
  """
  def make_words([head | rest]) when length(rest) == 0, do: num_pads()[head]
  def make_words([head | rest]) do
    next_line = make_words(rest)
    num_pads()[head]
    |> Enum.map(fn x ->
        Enum.map(next_line, fn y -> x <> y end)
      end)
    |> Enum.reduce([], fn x, acc -> acc ++ x end)
  end

  @doc """
  Make Valid Words
  """
  def make_valid_words(arr_num, valid) do
    checker = MapSet.new(valid)
    make_words(arr_num) |> Enum.filter(fn val -> MapSet.member?(checker, val) end)
  end
end
