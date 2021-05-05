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
  Convert to binary
  """
  def to_binary(val) do
    highest = find_highest_binary(val, 0)
    _to_binary(val, highest)
  end

  defp _to_binary(_val, idx) when idx < 0, do: ""

  defp _to_binary(val, idx) do
    curr = :math.pow(2, idx)

    cond do
      val >= curr -> "1" <> _to_binary(val - curr, idx - 1)
      true -> "0" <> _to_binary(val, idx - 1)
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
