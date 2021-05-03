#
#  LInkedNode.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:26 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule LinkedNode do
  alias __MODULE__
  @moduledoc """
  Linked List Node
  """
  @enforce_keys [:val]
  defstruct [:val, :next]

  @doc """
  Remove all duplicates node
  """
  @spec remove_sorted(%LinkedNode{}) :: %LinkedNode{}
  def remove_sorted(root) do
    do_remove_sorted(root, MapSet.new())
  end

  defp do_remove_sorted(root, _) when root == nil, do: nil
  defp do_remove_sorted(%LinkedNode{val: val, next: next}, seen_values) do
    cond do
      MapSet.member?(seen_values, val) -> do_remove_sorted(next, seen_values)
      true ->
        %LinkedNode{
          val: val,
          next: do_remove_sorted(next, seen_values |> MapSet.put(val))
        }
    end
  end

  @doc """
  Sum of the linked list
  """
  @spec sum(%LinkedNode{}, integer(), integer()) :: integer()
  def sum(root, _, _) when root == nil, do: 0
  def sum(_, _, last) when last <= 0, do: 0
  def sum(root, start, last) when start > 0, do: sum(root.next, start - 1, last - 1)
  def sum(root, _, last) do
    do_sum(root, last)
  end

  @spec do_sum(%LinkedNode{}, integer()) :: integer()
  defp do_sum(root, _) when root == nil, do: 0
  defp do_sum(_, last) when last < 0, do: 0
  defp do_sum(root, last) do
    root.val + do_sum(root.next, last - 1)
  end

end
