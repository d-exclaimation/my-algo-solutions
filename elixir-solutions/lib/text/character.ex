#
#  Character.ex
#  text
#
#  Created by d-exclaimation on 9:12 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Character do
  @moduledoc """
  Character module
  """

  @doc """
  Common character for all words
  """
  @spec common_characters(list(String.t())) :: MapSet.t()
  def common_characters(arr) do
    do_common_characters(
      arr
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&MapSet.new/1)
    )
  end

  @spec do_common_characters(list(MapSet.t())) :: MapSet.t()
  defp do_common_characters(arr_set) do
    arr_set
    |> Enum.reduce(fn x, acc -> MapSet.intersection(x, acc) end)
  end

  @doc """
  Find any letter in letters that are strictly larger than target
  """
  @spec next_letter(charlist, char) :: char
  def next_letter(letters, target) do
    case do_next_letter(letters, target) do
      {:ok, val} -> val
      :error -> Enum.min(letters)
    end
  end

  @spec do_next_letter(charlist, char) :: {:ok, char} | :error
  defp do_next_letter([], _target), do: :error

  defp do_next_letter([head | rest], target) do
    cond do
      head > target -> {:ok, head}
      true -> do_next_letter(rest, target)
    end
  end
end
