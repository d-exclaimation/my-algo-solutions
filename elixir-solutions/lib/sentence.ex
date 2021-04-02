#
#  Sentence.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 2:05 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Sentence do
  @moduledoc """
  Sentences, words and strings manipulation
  """

  @doc """
  Last word's length (Before space)
  Take a string
  Return an integer
  """
  @spec last_word_length(String.t) :: integer
  def last_word_length(string) do
    last = String.last(string)
    if last == " " do
      0
    else
      1 + last_word_length(String.slice(string, 0..-2))
    end
  end

  defp row_keyboard() do
    ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
  end

  @doc """
  Word with the same row on the keyboard
    >> O(2n) + O(3nk) time
    >> Time complexity O(n x k) time
  Take a list of string
  Return a list of string
  """
  @spec same_row(list(String.t)) :: list(String.t)
  def same_row(list) when length(list) == 0, do: []
  def same_row(list) do
    list
    # Map into original and checker
    |> Enum.map(fn w -> %{val: w, check: GroupAnagrams.tidy_word(w)} end)
    # filter ones that can be made from a row
    |> Enum.filter(fn w_map ->
      # If there is a row that can make the word
      length(
        # Filter the row where for every char of that word it exists there
        Enum.filter(row_keyboard(), fn row ->
          # Make sure only ones that have all the char in a row succeeded
          length(Enum.filter(w_map.check, fn char -> String.contains?(row, char) end)) == length(w_map.check)
        end)
      ) > 0
    end)
    |> Enum.map(fn w_map -> w_map.val end)


  end

end
