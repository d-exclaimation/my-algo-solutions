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

  @typedoc """
  Linked List Node type
  """
  @type t() :: %LinkedNode{
          val: any,
          next: t() | nil
        }

  @doc """
  Initialize from an array
  """
  @spec init([any]) :: t() | nil
  def init([]), do: nil

  def init([head | tail]) do
    %LinkedNode{
      val: head,
      next: init(tail)
    }
  end

  @doc """
  """
  @spec append(t(), t() | none()) :: t()
  def append(%__MODULE__{val: val, next: next}, tail) do
    if next == nil do
      %LinkedNode{
        val: val,
        next: tail
      }
    else
      %LinkedNode{
        val: val,
        next: append(next, tail)
      }
    end
  end

  @doc """
  Remove all duplicates node
  """
  @spec remove_sorted(t()) :: t()
  def remove_sorted(root) do
    do_remove_sorted(root, MapSet.new())
  end

  defp do_remove_sorted(root, _) when root == nil, do: nil

  defp do_remove_sorted(%LinkedNode{val: val, next: next}, seen_values) do
    cond do
      MapSet.member?(seen_values, val) ->
        do_remove_sorted(next, seen_values)

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
  @spec sum(t(), integer(), integer()) :: integer()
  def sum(root, _, _) when root == nil, do: 0
  def sum(_, _, last) when last <= 0, do: 0
  def sum(root, start, last) when start > 0, do: sum(root.next, start - 1, last - 1)

  def sum(root, _, last) do
    do_sum(root, last)
  end

  @spec do_sum(t(), integer()) :: integer()
  defp do_sum(root, _) when root == nil, do: 0
  defp do_sum(_, last) when last < 0, do: 0

  defp do_sum(root, last) do
    root.val + do_sum(root.next, last - 1)
  end

  @doc """
  Reverse of the list
  """
  @spec reversed(t()) :: t()
  def reversed(root) do
    do_reversed(root, nil)
  end

  @spec do_reversed(t() | nil, t() | nil) :: t() | nil
  defp do_reversed(nil, prev), do: prev

  defp do_reversed(%LinkedNode{val: val, next: next}, prev) do
    do_reversed(next, %LinkedNode{val: val, next: prev})
  end

  @doc """
  Remove element(s) from this linked node starting at `2nd param` for `3rd param`.
  """
  @spec splice(t() | nil, non_neg_integer(), non_neg_integer()) :: t() | nil
  def splice(nil, _m, _n), do: nil

  def splice(next, 0, 0), do: next

  def splice(%LinkedNode{val: _curr, next: next}, 0, n), do: splice(next, 0, n - 1)

  def splice(%LinkedNode{val: curr, next: next}, m, n) do
    %LinkedNode{val: curr, next: splice(next, m - 1, n)}
  end
end

defimpl String.Chars, for: LinkedNode do
  @doc """
  String represetationg of linkednode
  """
  @spec to_string(LinkedNode.t() | nil) :: String.t()
  def to_string(nil), do: ""

  def to_string(%LinkedNode{val: val, next: next}),
    do: "#{val} -> #{String.Chars.to_string(next)}"
end
