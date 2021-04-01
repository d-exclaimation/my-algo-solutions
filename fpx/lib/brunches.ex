#
#  Brunches.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 8:09 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Brunches do
  @moduledoc """
  Find the brunches aka non-unique sequence
  """
  def find_non_uniques(list) do
    find_seq(list, Enum.at(list, 0), 0, 0, [])
  end

  @doc """
  Find the sequence and collectively check the for brunches
  """
  @spec find_seq(list(String.t()), String.t(), integer(), integer(), list(tuple())) :: list(tuple())
  defp find_seq(list, curr, start, index, res) when length(list) == index, do: res ++ [{start, index - 1}]

  @spec find_seq(list(String.t()), String.t(), integer(), integer(), list(tuple())) :: list(tuple())
  defp find_seq(list, curr, start, index, res) do
    looked = Enum.at(list, index)
    if looked != curr do
      find_seq(list, looked, index, index, res ++ [{start, index - 1}])
    else
      find_seq(list, curr, start, index + 1, res)
    end
  end

end
