#
#  GroupAnagrams.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 8:48 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule GroupAnagrams do
  @moduledoc """
  Group word by their anagrams
  """

  def group_anagrams(list) do
    list
    |> Enum.map(fn word -> Enum.filter(list, fn some -> anagrams?(word, some) end) end)
    |> Enum.map(fn row -> Enum.sort(row) end)
    |> Enum.uniq()
  end

  defp anagrams?(word1, word2) when is_binary(word1) and is_binary(word2) do
    sort_char(word1) == sort_char(word2)
  end

  defp sort_char(word) when is_binary(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end

  def tidy_word(word) when is_binary(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.uniq()
  end

end
