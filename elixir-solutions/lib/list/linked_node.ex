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

end
