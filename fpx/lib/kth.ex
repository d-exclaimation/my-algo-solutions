#
#  Kth.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 9:33 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Kth do
  @moduledoc """
  Kth Something
  """

  @doc """
  Kth closest
  """
  def closest_pivots(list, k, pivot) do
    list
    |> Enum.map(fn item -> %{val: item, close: abs(pivot - item)} end)
    |> Enum.sort_by(fn map -> map.close end)
    |> Enum.slice(0..k - 1)
    |> Enum.map(fn map -> map.val end)
  end

end
