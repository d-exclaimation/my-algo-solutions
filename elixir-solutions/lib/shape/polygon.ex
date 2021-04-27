#
#  Polygon.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 8:47 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Polygon do
  @moduledoc """
  Polygon and friends
  """

  @type point :: integer()
  @type vector2 :: %{i: point(), j: point()}
#  @neighbours [
#    {-1, -1},
#    {-1, 0},
#    {-1, 1},
#    {0, -1},
#    {0, 1},
#    {1, -1},
#    {1, 0},
#    {1, 1},
#  ]
  @sides [
    {-1, 0},
    {0, -1},
    {0, 1},
    {1, 0},
  ]

  @doc """

  """
  @spec at(list(list(any())), point(), point()) :: any()
  def at(grid, i, j), do: Enum.at(Enum.at(grid, i), j)

  @doc """
  Max Connected dots
  """
  @spec max_connected_dots(list(list(integer()))) :: nil
  def max_connected_dots(grid) do
    0..(length(grid) - 1)
    |> Enum.map(fn i ->
        0..(length(Enum.at(grid, i)) - 1)
        |> Enum.filter(fn j -> at(grid, i, j) > 0 end)
        |> Enum.map(fn j -> find_max_conn(i, j, grid) end)
        |> Enum.max(&>=/2, fn -> 0 end)
      end)
    |> Enum.max(&>=/2, fn -> 0 end)
  end

  @spec find_max_conn(point(), point(), list(list(integer()))) :: integer()
  defp find_max_conn(i, j, grid) do
    @sides
    |> Enum.map(fn {y, x} -> {i + y, j + x} end)
    |> Enum.filter(fn {y, x} -> y >= 0 and y < length(grid) and x >= 0 and x < length(Enum.at(grid, y)) end)
    |> Enum.filter(fn {y, x} -> grid |> Enum.at(y) |> Enum.at(x) != 0 end)
    |> Enum.map(fn {y, x} -> 1 + continue_conn(%{i: y, j: x}, %{i: i, j: j}, grid) end)
    |> Enum.max(&>=/2, fn -> 1 end)
  end

  @spec continue_conn(vector2(), vector2(), list(list(integer()))) :: integer()
  defp continue_conn(%{i: i, j: j}, prev, grid) do
    @sides
    |> Enum.map(fn {y, x} -> {i + y, j + x} end)
    |> Enum.filter(fn {y, x} -> y >= 0 and y < length(grid) and x >= 0 and x < length(Enum.at(grid, y)) end)
    |> Enum.filter(fn {y, x} -> grid |> Enum.at(y) |> Enum.at(x) != 0 end)
    |> Enum.filter(fn {y, x} -> y != prev.i and x != prev.j end)
    |> Enum.map(fn {y, x} -> 1 + continue_conn(%{i: y, j: x}, %{i: i, j: j}, grid) end)
    |> Enum.max(&>=/2, fn -> 1 end)
  end

  @doc """
  Check if all in a straight line
  -> straight_line?(list(point())) :: boolean()
  """
  @spec straight_line?(list(point())) :: boolean()
  def straight_line?(arr) do
    {y2, x2} = arr |> Enum.max(fn {y, x}, {i, j} -> y + x >= i + j end)
    {y1, x1} = arr |> Enum.min(fn {y, x}, {i, j} -> y + x <= i + j end)
    length(arr) == arr |> Enum.filter(fn {y, x} -> (((x - x1) * (y2 - y1) / (x2 - x1)) + y1) == y end) |> Enum.count()
  end
end