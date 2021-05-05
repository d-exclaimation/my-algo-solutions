#
#  Sort.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 5:03 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Sort do
  @moduledoc """
  Sorting stuff
  """

  @type value :: any()
  @type array :: list(value())

  # Mark: O(n^2) algorithms

  @doc """
  Selection sort
  """
  @spec selection_sort(array()) :: array()
  def selection_sort(list) when length(list) <= 1, do: list

  def selection_sort(list) do
    minimal = list |> Enum.min()

    (list |> Enum.filter(fn x -> x == minimal end)) ++
      selection_sort(list |> Enum.filter(fn x -> x != minimal end))
  end

  @doc """
  Insertion Sort
  """
  @spec insertion_sort(array()) :: array()
  def insertion_sort(arr) do
    gap_insertion(arr, 0, 1)
  end

  @doc """
  Shell sort
  """
  @spec shell_sort(array()) :: array()
  def shell_sort(arr) do
    do_shell_sort(arr, div(length(arr), 2))
  end

  @spec do_shell_sort(array(), integer()) :: array()
  defp do_shell_sort(arr, gap) when gap <= 0, do: arr

  defp do_shell_sort(arr, gap) do
    res =
      0..(gap - 1)
      |> Enum.reduce(arr, fn x, acc -> gap_insertion(acc, x, gap) end)

    do_shell_sort(res, div(gap, 2))
  end

  @doc """
  Custom gaps insertion sort
  """
  @spec custom_gap_sort(array(), list(integer())) :: array()
  def custom_gap_sort(arr, gaps) do
    gaps
    |> Enum.filter(fn gap -> gap < length(arr) end)
    |> Enum.reduce(arr, fn gap, acc ->
      0..(gap - 1)
      |> Enum.reduce(acc, fn x, acc2 -> gap_insertion(acc2, x, gap) end)
    end)
  end

  @doc """
  Gap insertion swap
  """
  @spec gap_insertion(array(), integer(), integer()) :: array()
  def gap_insertion(arr, start, gap), do: do_gap_insertion(arr, start + gap, gap)

  @spec do_gap_insertion(array(), integer(), integer()) :: array()
  defp do_gap_insertion(arr, i, _gap) when i >= length(arr), do: arr

  defp do_gap_insertion(arr, i, gap) do
    res = do_gap_swap(arr, i, gap)
    do_gap_insertion(res, i + gap, gap)
  end

  @spec do_gap_swap(array(), integer(), integer()) :: array()
  defp do_gap_swap(arr, pos, gap) when pos < gap, do: arr

  defp do_gap_swap(arr, pos, gap) do
    if Enum.at(arr, pos - gap) <= Enum.at(arr, pos) do
      arr
    else
      next = pos - gap

      match = fn
        ^next -> Enum.at(arr, pos)
        ^pos -> Enum.at(arr, next)
        i -> Enum.at(arr, i)
      end

      new_arr = 0..(length(arr) - 1) |> Enum.map(match)
      do_gap_swap(new_arr, next, gap)
    end
  end

  # Mark: O(nlogn) algorithms

  @doc """
  Quick Sort with Partition
  """
  @spec quick_sort(array()) :: array()
  def quick_sort(arr) when length(arr) <= 1, do: arr

  def quick_sort(arr) do
    median =
      median_of_three(
        Enum.at(arr, 0),
        Enum.at(arr, div(length(arr), 2)),
        Enum.at(arr, length(arr) - 1)
      )

    {lower, equal, upper} = partition(arr, median)
    quick_sort(lower) ++ equal ++ quick_sort(upper)
  end

  @spec partition(array(), value()) :: {array(), array(), array()}
  defp partition(arr, pivot) do
    lower = fn x -> x < pivot end
    upper = fn x -> x > pivot end
    equal = fn x -> x == pivot end
    {arr |> Enum.filter(lower), arr |> Enum.filter(equal), arr |> Enum.filter(upper)}
  end

  @spec median_of_three(integer(), integer(), integer()) :: integer()
  defp median_of_three(low, mid, high) do
    median? = fn x, l, r -> (l <= x and x <= r) or (r <= x and x <= l) end

    cond do
      median?.(low, mid, high) -> low
      median?.(mid, low, high) -> mid
      median?.(high, low, mid) -> high
      true -> mid
    end
  end

  @doc """
  Merge Sort "list"
  """
  @spec merge_sort(array()) :: array()
  def merge_sort(list) when length(list) <= 1, do: list

  def merge_sort(list) do
    mid = div(length(list), 2)
    lhs = merge_sort(Enum.slice(list, 0..(mid - 1)))
    rhs = merge_sort(Enum.slice(list, mid..-1))
    merge(lhs, rhs)
  end

  @spec merge(array(), array()) :: array()
  defp merge(lhs, rhs) when length(lhs) == 0 or length(rhs) == 0, do: lhs ++ rhs

  defp merge([l_head | l_rest], [r_head | r_rest]) do
    cond do
      l_head < r_head -> [l_head] ++ merge(l_rest, [r_head | r_rest])
      l_head == r_head -> [l_head, r_head] ++ merge(l_rest, r_rest)
      l_head > r_head -> [r_head] ++ merge([l_head | l_rest], r_rest)
    end
  end
end
