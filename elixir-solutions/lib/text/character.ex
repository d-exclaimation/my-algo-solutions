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

end
