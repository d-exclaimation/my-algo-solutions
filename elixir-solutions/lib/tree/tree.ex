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
    [val] ++ in_order(left) ++ in_order(right)
  end

  @doc """
  Post Order Traversal, left first, right then mid
  """
  @spec post_order(%Tree{} | none()) :: list(value())
  def post_order(root) when root == nil, do: []

  def post_order(%Tree{val: val, left: left, right: right}) do
    in_order(left) ++ in_order(right) ++ [val]
  end
end
