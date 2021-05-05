#
#  Kth.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 9:33 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Kth do
  @moduledoc """
  Kth Something
  """

  @doc """
  Kth closest
  """
  def closest_pivots(list, k, pivot) do
    list
    |> Enum.map(fn item -> %{val: item, close: abs(pivot - item)} end)
    |> Enum.sort_by(fn map -> map.close end)
    |> Enum.slice(0..(k - 1))
    |> Enum.map(fn map -> map.val end)
  end

  @doc """
  Find duplicate if only one is duplicated
  """
  @spec find_one_dup(list(integer())) :: integer() | nil
  def find_one_dup(arr) do
    _find_one_dup(arr, MapSet.new())
  end

  defp _find_one_dup(arr, _seen) when length(arr) == 0, do: nil

  defp _find_one_dup([head | rest], seen) do
    cond do
      MapSet.member?(seen, head) -> head
      true -> _find_one_dup(rest, seen |> MapSet.put(head))
    end
  end

  @doc """
  Min differences
  """
  @spec min_differences(list(integer())) :: list({integer(), integer()})
  def min_differences([]), do: []
  def min_differences([_]), do: []

  def min_differences(arr) do
    all =
      0..(length(arr) - 2)
      |> Enum.map(fn i ->
        curr = Enum.at(arr, i)

        {other, diff} =
          arr
          |> Enum.slice(i..(length(arr) - 1))
          |> Enum.filter(fn x -> x != curr end)
          |> Enum.map(fn x -> {x, abs(curr - x)} end)
          |> Enum.min(fn {_, l}, {_, r} -> l <= r end)

        {{curr, other}, diff}
      end)

    {_, min_diff} =
      all
      |> Enum.min(fn {_, l}, {_, r} -> l <= r end)

    all
    |> Enum.filter(fn {_, x} -> x == min_diff end)
    |> Enum.map(fn {res, _} -> res end)
  end

  @doc """
  Subtotal of all subarray that has an odd length
  """
  @spec odd_sum_subarray(list(integer())) :: integer()
  def odd_sum_subarray(arr) do
    1..length(arr)
    |> Enum.filter(fn i -> rem(i, 2) == 1 end)
    |> Enum.map(fn i ->
      0..(length(arr) - i)
      |> Enum.map(fn j ->
        Enum.sum(Enum.slice(arr, j..(j - 1 + i)))
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end
end
