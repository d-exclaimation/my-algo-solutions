#
#  Binary.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 2:06 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Binary do
  @moduledoc """
  Binary module
  """

  @type binary_str :: String.t()
  @type binary_arr :: list(integer())

  @type t() :: binary_str()

  @doc """
  Binary string from integer
  """
  @spec from(integer()) :: t()
  def from(num) when num < 0 do
    ("0" <> from(-num))
    |> inverse()
    |> add("1")
    |> compress()
  end

  def from(num) do
    do_from([], num)
  end

  @spec do_from(binary_arr(), integer()) :: t()
  defp do_from(acc, 0), do: acc |> Enum.map(&Integer.to_string/1) |> Enum.join()

  defp do_from(acc, value) do
    do_from([rem(value, 2) | acc], div(value, 2))
  end

  @doc """
  Invert all bits in binary
  """
  @spec inverse(t()) :: t()
  def inverse(bin) do
    to_arr(bin)
    |> Enum.map(fn x -> abs(x - 1) end)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
  end

  @doc """
  Add two binary string
  """
  @spec add(t(), t()) :: t()
  def add(bin1, bin2) do
    bins1 =
      bin1
      |> to_arr()
      |> Enum.reverse()

    bins2 =
      bin2
      |> to_arr()
      |> Enum.reverse()

    {acc, carry} =
      0..max(length(bins1), length(bins2))
      |> Enum.map(fn i -> {Enum.at(bins1, i, 0), Enum.at(bins2, i, 0)} end)
      |> Enum.reduce({[], 0}, fn
        {l, r}, {acc, carry} ->
          res = l + r + carry
          {[rem(res, 2) | acc], div(res, 2)}
      end)

    if(carry == 1, do: [carry | acc], else: acc)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
  end

  @doc """
  Compress binary to remove front zeros
  """
  @spec compress(binary_arr()) :: binary_arr()
  def compress([1 | res]), do: [1 | res]

  def compress([0 | res]) do
    compress(res)
  end

  @spec compress(t()) :: t()
  def compress("0" <> res), do: compress(res)

  def compress("1" <> res) do
    "1" <> res
  end

  @doc """
  Find highest binary
  """
  def find_highest_binary(val, idx) do
    if :math.pow(2, idx) >= val do
      idx - 1
    else
      find_highest_binary(val, idx + 1)
    end
  end

  @doc """
  """
  @spec to_arr(binary_str()) :: binary_arr()
  def to_arr(bin) do
    bin
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Turn binary into integers
  """
  @spec to_integer(binary_arr()) :: integer()
  def to_integer([] = bins) do
    bins
    |> Enum.reverse()
    |> Enum.zip(Array.indices(bins))
    |> Enum.map(fn {x, i} -> x * 2 ** i end)
    |> Enum.sum()
  end

  @spec to_integer(binary_str()) :: integer()
  def to_integer(bin), do: to_integer(to_arr(bin))

  @doc """
  Sum all paths of a binary tree
  """
  @spec sum_tree_paths(Tree.t()) :: integer()
  def sum_tree_paths(tree) do
    tree
    |> Tree.paths(fn acc, x -> acc <> "#{x}" end)
    |> Enum.map(&Binary.to_integer/1)
    |> Enum.sum()
  end

  @doc """
  Binary string from fraction
  """
  @spec float(float()) :: t()
  def float(num) do
    floored = floor(num)
    remainder = num - floored
    "#{from(floored)}.#{do_float(remainder, -1, "")}"
  end

  @spec do_float(float(), neg_integer(), t()) :: t()
  defp do_float(0.0, _depth, res), do: res
  defp do_float(_f, depth, res) when depth < -32, do: res

  defp do_float(fractional, depth, res) do
    removing = 2 ** depth

    if fractional < removing do
      do_float(fractional, depth - 1, res <> "0")
    else
      do_float(fractional - removing, depth - 1, res <> "1")
    end
  end
end
