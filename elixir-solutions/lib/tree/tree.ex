#
#  Tree.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 8:56 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Tree do
  alias __MODULE__

  @moduledoc """
  Tree Node for Binary Trees
  """
  @enforce_keys [:val]
  defstruct [:val, :left, :right]

  @typedoc """
  Custom tree with values
  """
  @type t(k) ::
          %Tree{
            val: k,
            left: t(k),
            right: t(k)
          }
          | nil

  @type value() :: any()

  @doc """
  In Order Traversal, leftest first, mid then right
  """
  @spec in_order(%Tree{} | none()) :: list(value())
  def in_order(root) when root == nil, do: []

  def in_order(%Tree{val: val, left: left, right: right}) do
    in_order(left) ++ [val] ++ in_order(right)
  end

  @doc """
  Pre Order Traversal, mid first, left then right
  """
  @spec pre_order(%Tree{} | none()) :: list(value())
  def pre_order(root) when root == nil, do: []

  def pre_order(%Tree{val: val, left: left, right: right}) do
    [val] ++ pre_order(left) ++ pre_order(right)
  end

  @doc """
  Post Order Traversal, left first, right then mid
  """
  @spec post_order(%Tree{} | none()) :: list(value())
  def post_order(root) when root == nil, do: []

  def post_order(%Tree{val: val, left: left, right: right}) do
    post_order(left) ++ post_order(right) ++ [val]
  end

  @doc """
  Inverse a tree
  """
  @spec inversed(%Tree{} | none()) :: nil
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
  @spec min_depth(%Tree{} | none()) :: integer
  def min_depth(nil), do: 0

  def min_depth(%Tree{left: left, right: right}) do
    1 + min(min_depth(left), min_depth(right))
  end

  @doc """
  """
  @spec reconstruct([any()], [any()]) :: t(any()) | nil
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
end

defimpl Inspect, for: Tree do
  @doc """
  Inspect a tree
  """
  @spec inspect(%Tree{}, any()) :: String.t()
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
