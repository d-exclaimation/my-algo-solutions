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
  @spec odd_sum_subarray([integer]) :: integer
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

  @doc """
  Find smallest number that cannot be summed from the sorted list
  """
  @spec find_smallest([integer]) :: integer
  def find_smallest(arr) do
    do_find_smallest(arr, 0)
  end

  @spec do_find_smallest([integer], integer) :: integer
  defp do_find_smallest(arr, k) do
    case Array.two_sum(arr, k) do
      {-1, -1} -> k
      _ -> do_find_smallest(arr, k + 1)
    end
  end

  @doc """
  Given a 2n size array of integers
  returns the n-repeated integers, if the unique items' count is n + 1
  """
  @spec n_repeated([integer]) :: integer
  def n_repeated(arr) do
    length = Enum.count(arr)

    if length == 4 and Enum.at(arr, 0) == Enum.at(arr, 3) do
      [head | _] = arr
      head
    else
      [head | _] =
        1..2
        |> Enum.flat_map(fn k ->
          arr
          |> Enum.with_index()
          |> Enum.filter(fn {x, i} -> x == Enum.at(arr, i + k) end)
          |> Enum.map(fn {x, _} -> x end)
        end)

      head
    end
  end

  @doc """
  Find smallest sorting window
  """
  @spec smallest_window_sort([integer]) :: {integer, integer}
  def smallest_window_sort(arr) do
    sorted_arr =
      arr
      |> Enum.sort()
      |> Enum.with_index()

    find_diff_window(Enum.with_index(arr), sorted_arr, {-1, -1})
  end

  defp find_diff_window([], [], {-1, -1}), do: {0, 0}
  defp find_diff_window([], [], res), do: res

  defp find_diff_window([{lhs, i} | lt], [{rhs, _} | rt], {-1, -1}) do
    find_diff_window(lt, rt, if(lhs != rhs, do: {i, -1}, else: {-1, -1}))
  end

  defp find_diff_window([{lhs, i} | lt], [{rhs, _} | rt], {low, up}) do
    if lhs == rhs do
      find_diff_window([], [], {low, i - 1})
    else
      find_diff_window(lt, rt, {low, up})
    end
  end
end
