#
#  Math.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:05 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule MyMath do
  @moduledoc """
  Mathematical computation
  """
  @doc """
  Square root of a value
  """
  def square_root(val) when val <= 1, do: val
  def square_root(val) do
    2..div(val, 2)
    |> Enum.filter(fn x -> x * x <= val end)
    |> Enum.fetch!(-1)
  end

end
