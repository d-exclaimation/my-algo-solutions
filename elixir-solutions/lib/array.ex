#
#  Array.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 7:23 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Array do
  @moduledoc """
  Array manipulation
  """

  @doc """
  Get the only unique element in a list
  -> list: list(any: Equatable)
  :: any: Equatable
  """
  def one_value(list) when is_list(list) do
    list
    |> Enum.filter(fn x -> Enum.count(list, fn y -> y == x end) == 1 end)
    |> Enum.fetch!(0)
  end

  @doc """
  Rotate a one dimensional array
  -> [head | rest]: list(any)
  :: list(any)
  """
  def rotate_1d([head | rest], count) when count == 0, do: [head] ++ rest
  def rotate_1d([head | rest], count) do
    rotate_1d(rest ++ [head], count - 1)
  end

  @doc """
  Merge Sort "list"
  -> list: list(any: Comparable)
  :: list(any: Comparable)
  """
  def merge_sort(list) when length(list) <= 1, do: list
  def merge_sort(list) do
    mid = div(length(list), 2)
    lhs = merge_sort(Enum.slice(list, 0..mid - 1))
    rhs = merge_sort(Enum.slice(list, mid..-1))
    merge(lhs, rhs)
  end

  defp merge(lhs, rhs) when length(lhs) == 0 or length(rhs) == 0, do: lhs ++ rhs
  defp merge([l_head | l_rest], [r_head | r_rest]) do
    cond do
      l_head < r_head -> [l_head] ++ merge(l_rest, [r_head | r_rest])
      l_head == r_head -> [l_head, r_head] ++ merge(l_rest, r_rest)
      l_head > r_head -> [r_head] ++ merge([l_head | l_rest], r_rest)
    end
  end

  @doc """
  Find the min subarray that is bigger or equal
  """
  def min_subarray(list, s) when is_list(list) do
    0..length(list) - 1
    |> Enum.filter(fn r -> min_subs(list, 0, r, s) end)
    |> Enum.map(fn r -> r + 1 end)
    |> Enum.min()
  end

  defp min_subs(list, at, count, _s) when is_list(list) and at + count >= length(list), do: false
  defp min_subs(list, at, count, s) when is_list(list) do
    curr = list
      |> Enum.slice(at..(at + count))
      |> Enum.sum()
    if curr >= s, do: true, else: min_subs(list, at + 1, count, s)
  end

  @doc """
  Equal share, given a positive integer determine whether the array can be partition with equal sums
  -> list: list(integer)
  :: boolean
  """
  def equal_share?(list) do
#    _equalize?(list, 0)
    _optimized_eq?(list, 0, 0, Enum.sum(list))
  end

  defp _optimized_eq?(list, index, lhs, rhs) when length(list) == index, do: lhs == rhs
  defp _optimized_eq?(list, index, lhs, rhs) do
    curr = Enum.at(list, index)
    cond do
      lhs + curr == rhs - curr -> true
      true -> false or _optimized_eq?(list, index + 1, lhs + curr, rhs - curr)
    end
  end

  @doc """
  Max increasing subsequence
  O(n) time, and O(n) space (given the recursive stack consist of prev, curr, best: integer. No mutation)
  -> arr: list(integer)
  :: integer
  """
  def max_increasing(arr) do
    _max_increasing(arr, Enum.at(arr, 0) - 1, 0, 0)
  end

  defp _max_increasing([head | rest], prev, curr, best) when length(rest) == 0 do
    cond do
      head > prev -> if best > curr + 1, do: best, else: curr + 1
      true -> if best > curr, do: best, else: curr
    end
  end
  defp _max_increasing([head | rest], prev, curr, best) do
    cond do
      head > prev ->
        _max_increasing(rest, head, curr + 1, best)
      true ->
         next_max = if best > curr, do: best, else: curr
         _max_increasing(rest, head, 1, next_max)
    end
  end

#  defp _equalize?(list, index) when length(list) == index, do: false
#  defp _equalize?(list, index) do
#    sum_first = Enum.sum(Enum.slice(list, 0..index))
#    sum_rest = Enum.sum(Enum.slice(list, index + 1..-1))
#    cond do
#      sum_first == sum_rest -> true
#      true -> false or _equalize?(list, index + 1)
#    end
#  end
end
