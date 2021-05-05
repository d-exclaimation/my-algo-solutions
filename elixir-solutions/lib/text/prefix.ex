#
#  Prefix.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:12 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Prefix do
  @moduledoc """
  Prefix related functions
  """

  @doc """
  Longest common prefix
  """
  @spec longest_prefix(list(String.t())) :: String.t()
  def longest_prefix(arr) do
    init = Enum.at(arr, 0) |> String.first()

    common =
      arr
      |> Enum.filter(fn x -> x != "" and String.first(x) == init end)
      |> Enum.map(fn x -> String.slice(x, 1..-1) end)

    cond do
      length(common) == length(arr) -> init <> longest_prefix(common)
      true -> ""
    end
  end
end
