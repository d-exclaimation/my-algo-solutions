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
  Sum binary
  """
  @spec sum(binary_str(), binary_str()) :: binary_str()
  def sum(bin1, bin2) do
    lhs = to_arr(bin1) |> Enum.reverse()
    rhs = to_arr(bin2) |> Enum.reverse()

    do_sum(lhs, rhs, 0)
    |> Enum.map(fn x -> "#{x}" end)
    |> Enum.join("")
  end

  @spec do_sum(binary_arr(), binary_arr(), integer()) :: binary_arr()
  defp do_sum([], [], carry),
    do: if(carry == 0, do: [], else: do_sum([], [], div(carry, 2)) ++ [1])

  defp do_sum(lhs, rhs, carry) when length(lhs) == 0 or length(rhs) == 0 do
    still = if length(rhs) == 0, do: lhs, else: rhs
    tot = Enum.at(still, 0) + carry
    extra = div(tot, 2)
    remain = rem(tot, 2)
    rest = Enum.slice(still, 1..-1)

    cond do
      extra == 0 -> rest ++ [remain]
      length(rhs) == 0 -> do_sum(rest, [], extra) ++ [remain]
      true -> do_sum([], rest, extra) ++ [remain]
    end
  end

  defp do_sum([hl | tl], [hr | tr], carry) do
    total = hl + hr + carry
    extra = div(total, 2)
    remain = rem(total, 2)
    do_sum(tl, tr, extra) ++ [remain]
  end
end
