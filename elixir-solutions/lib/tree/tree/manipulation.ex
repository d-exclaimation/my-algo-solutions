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
  -> root: %Tree | none
  :: boolean
  """
  @spec boring?(%Tree{} | none()) :: boolean()
  def boring?(root), do: do_boring?(root, root.val)

  def do_boring?(root, _value) when root == nil, do: true
  def do_boring?(%Tree{val: val, left: left, right: right}, value), do: val == value && do_boring?(left, value) && do_boring?(right, value)
end
