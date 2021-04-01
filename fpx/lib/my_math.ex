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

  @doc """
  Add one to the number list
  """
  def add_list(num_list, carry) when carry == 0, do: num_list
  def add_list(num_list, carry) do
    last = Enum.fetch!(num_list, -1) + carry
    if last > 9 do
      add_list(Enum.slice(num_list, 0..-2), 1) ++ [rem(last, 10)]
    else
      add_list(Enum.slice(num_list, 0..-2), 0) ++ [last]
    end
  end

end
