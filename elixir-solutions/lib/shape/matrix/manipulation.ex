#
#  manipulation.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 14:17.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Matrix.Manipulation do
  @moduledoc """
    Matrix manipulation
  """

  @type grid :: list(list(number()))

  @doc """
  Sum of diagonal
  """
  @spec diagonal_sum(grid()) :: number()
  def diagonal_sum(matrix) do
    n = length(matrix)
    lhs = 0..(n - 1) |> Enum.map(fn i -> {i, i} end)
    lhs_set = MapSet.new(lhs)
    rhs = 0..(n - 1)
    |> Enum.map(fn i -> {i, n - 1 - i} end)
    |> Enum.filter(fn tup -> not MapSet.member?(lhs_set, tup) end)
    lhs ++ rhs
    |> Enum.map(fn {i, j} -> Enum.at(Enum.at(matrix, j), i) end)
    |> Enum.sum()
  end
end
