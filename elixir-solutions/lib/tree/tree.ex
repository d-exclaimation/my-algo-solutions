#
#  Tree.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 8:56 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Tree do
  @moduledoc """
  Tree Node for Binary Trees
  """
  use TypedStruct
  alias __MODULE__

  @type value() :: any()

  typedstruct do
    @typedoc ""
    field(:val, any(), enforce: true)
    field(:left, Tree.t())
    field(:right, Tree.t())
  end

  @doc """
  In Order Traversal, leftest first, mid then right
  """
  @spec in_order(Tree.t() | none()) :: list(value())
  def in_order(root) when root == nil, do: []

  def in_order(%Tree{val: val, left: left, right: right}) do
    in_order(left) ++ [val] ++ in_order(right)
  end

  @doc """
  Pre Order Traversal, mid first, left then right
  """
  @spec pre_order(Tree.t() | none()) :: list(value())
  def pre_order(root) when root == nil, do: []

  def pre_order(%Tree{val: val, left: left, right: right}) do
    [val] ++ pre_order(left) ++ pre_order(right)
  end

  @doc """
  Post Order Traversal, left first, right then mid
  """
  @spec post_order(Tree.t() | none()) :: list(value())
  def post_order(root) when root == nil, do: []

  def post_order(%Tree{val: val, left: left, right: right}) do
    post_order(left) ++ post_order(right) ++ [val]
  end

  @doc """
  Inverse a tree
  """
  @spec inversed(Tree.t() | none()) :: nil
  def inversed(nil), do: nil

  def inversed(%Tree{val: val, left: left, right: right}) do
    %Tree{
      val: val,
      left: inversed(right),
      right: inversed(left)
    }
  end

  @doc """
  Minimum depth of index
  """
  @spec min_depth(Tree.t() | none()) :: integer
  def min_depth(nil), do: 0

  def min_depth(%Tree{left: left, right: right}) do
    1 + min(min_depth(left), min_depth(right))
  end

  @doc """
  """
  @spec reconstruct([any()], [any()]) :: t() | nil
  def reconstruct([], []), do: nil
  def reconstruct(pre_order, in_order) when length(pre_order) != length(in_order), do: nil

  def reconstruct([top_node | pre_order], in_order) do
    find_index = fn arr, elem ->
      res =
        arr
        |> Enum.find_index(fn each ->
          each == elem
        end)

      if res == nil,
        do: :error,
        else: {:ok, res}
    end

    with {:ok, i} <- find_index.(in_order, top_node),
         {:ok, j} <- find_index.(pre_order, Enum.at(in_order, i - 1)) do
      # In orders
      l_in_order = Enum.slice(in_order, 0..(i - 1))
      r_in_order = Enum.slice(in_order, (i + 1)..-1)

      # Pre orders
      l_pre_order = Enum.slice(pre_order, 0..j)
      r_pre_order = Enum.slice(pre_order, (j + 1)..-1)

      %Tree{
        val: top_node,
        left: reconstruct(l_pre_order, l_in_order),
        right: reconstruct(r_pre_order, r_in_order)
      }
    else
      _ ->
        %Tree{val: top_node}
    end
  end

  @doc """
  Get all paths
  """
  @spec paths(Tree.t(), (any(), any() -> any())) :: [any()]
  def paths(%Tree{val: val, left: nil, right: nil}, _apply),
    do: [val]

  def paths(%Tree{val: val, left: left, right: nil}, apply),
    do: paths(left, apply, val)

  def paths(%Tree{val: val, left: nil, right: right}, apply),
    do: paths(right, apply, val)

  def paths(%Tree{val: val, left: left, right: right}, apply) do
    paths(left, apply, val) ++ paths(right, apply, val)
  end

  @spec paths(Tree.t(), (any(), any() -> any()), any()) :: [any()]
  def paths(%Tree{val: val, left: nil, right: nil}, apply, carry),
    do: [apply.(carry, val)]

  def paths(%Tree{val: val, left: left, right: nil}, apply, carry),
    do: paths(left, apply, apply.(carry, val))

  def paths(%Tree{val: val, left: nil, right: right}, apply, carry),
    do: paths(right, apply, apply.(carry, val))

  def paths(%Tree{val: val, left: left, right: right}, apply, carry) do
    paths(left, apply, apply.(carry, val)) ++ paths(right, apply, apply.(carry, val))
  end
end

defimpl Inspect, for: Tree do
  @doc """
  Inspect a tree
  """
  @spec inspect(Tree.t(), any()) :: String.t()
  def inspect(%Tree{val: val, left: nil, right: nil}, _), do: "#Tree<{#{val}}>"

  def inspect(%Tree{val: val, left: left, right: nil}, _),
    do: "#Tree<{#{val}} left => #{inspect(left)}>"

  def inspect(%Tree{val: val, left: nil, right: right}, _),
    do: "#Tree<{#{val}} right => #{inspect(right)}>"

  def inspect(%Tree{val: val, left: left, right: right}, _) do
    """
    #Tree<
      {#{val}}
      left => #{inspect(left)}
      right => #{inspect(right)}
    >
    """
  end
end
