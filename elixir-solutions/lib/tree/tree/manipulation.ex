#
#  Tree.Manipulation.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:04 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Tree.Manipulation do
  @moduledoc """
  Tree Manipulation
  """

  @doc """
  Boring tree, tree with one value
  """
  @spec boring?(%Tree{} | none()) :: boolean()
  def boring?(root), do: do_boring?(root, root.val)

  def do_boring?(root, _value) when root == nil, do: true

  def do_boring?(%Tree{val: val, left: left, right: right}, value),
    do: val == value && do_boring?(left, value) && do_boring?(right, value)

  @doc """
  Find all only children of a tree
  """
  @spec only_children(%Tree{} | nil) :: list(Tree.value())
  def only_children(nil), do: []

  def only_children(%Tree{left: left, right: right}) do
    children =
      [left, right]
      |> Enum.filter(fn x -> x != nil end)

    cond do
      length(children) != 1 ->
        only_children(left) ++ only_children(right)

      true ->
        [Enum.at(children, 0).val] ++ only_children(left) ++ only_children(right)
    end
  end

  @doc """
  Max total depth
  """
  @spec max_total(Tree.t(integer())) :: integer()
  def max_total(nil), do: 0

  def max_total(%Tree{left: left, right: right, val: val}) do
    val + max(max_total(left), max_total(right))
  end
end
