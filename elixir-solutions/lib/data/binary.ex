#
#  Binary.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 2:06 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Binary do
  @moduledoc """
  Binary module
  """

  @type binary_str :: String.t()
  @type binary_arr :: list(integer())

  @doc """
  Find highest binary
  -> val, idx: integer
  :: integer
  """
  def find_highest_binary(val, idx) do
    if :math.pow(2, idx) >= val do
      idx - 1
    else
      find_highest_binary(val, idx + 1)
    end
  end

  @doc """
  Convert to binary
  -> val: integer
  :: String.t
  """
  def to_binary(val) do
    highest = find_highest_binary(val, 0)
    _to_binary(val, highest)
  end

  defp _to_binary(_val, idx) when idx < 0, do: ""
  defp _to_binary(val, idx) do
    curr = :math.pow(2, idx)
    cond do
      val >= curr -> "1" <> _to_binary(val - curr, idx - 1)
      true -> "0" <> _to_binary(val, idx - 1)
    end
  end
end
