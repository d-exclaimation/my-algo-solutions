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
  """
  @spec last_word_length(String.t()) :: integer
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
  """
  @spec same_row(list(String.t())) :: list(String.t())
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
          length(Enum.filter(w_map.check, fn char -> String.contains?(row, char) end)) ==
            length(w_map.check)
        end)
      ) > 0
    end)
    |> Enum.map(fn w_map -> w_map.val end)
  end

  @doc """
  Find the first occurring char sentence
  """
  def first_recurring(word) do
    _first_occurring(String.graphemes(word), MapSet.new())
  end

  defp _first_occurring(list, _mapper) when length(list) == 0, do: nil

  defp _first_occurring([first | rest], mapper) do
    if MapSet.member?(mapper, first),
      do: first,
      else: _first_occurring(rest, MapSet.put(mapper, first))
  end

  @doc """
  Longest palindrome substring
  """
  def longest_palindrome_substring(str) do
    cond do
      String.length(str) <= 1 -> str
      true -> _longest_palindrome_substring(str |> String.graphemes(), String.length(str))
    end
  end

  defp _longest_palindrome_substring(_, len) when len <= 0, do: nil

  defp _longest_palindrome_substring(str_arr, len) do
    try do
      _palindrome_substring(str_arr, len, len - 1)
    catch
      _ -> _longest_palindrome_substring(str_arr, len - 1)
    end
  end

  defp _palindrome_substring(str_arr, _len, idx) when idx >= length(str_arr), do: throw(:error)

  defp _palindrome_substring(str_arr, len, idx) do
    curr = str_arr |> Enum.slice((idx - len + 1)..idx) |> Enum.join()
    rev = curr |> String.reverse()

    cond do
      curr == rev -> curr
      true -> _palindrome_substring(str_arr, len, idx + 1)
    end
  end

  @doc """
  Longest substring given a rule
  """
  def longest_substring(str, rule) do
    cond do
      String.length(str) <= 1 -> str
      true -> _longest_substring(str |> String.graphemes(), String.length(str), rule)
    end
  end

  defp _longest_substring(_, len, _rule) when len <= 0, do: nil

  defp _longest_substring(str_arr, len, rule) do
    try do
      _substring(str_arr, len, len - 1, rule)
    catch
      _ -> _longest_substring(str_arr, len - 1, rule)
    end
  end

  defp _substring(str_arr, _len, idx, _rule) when idx >= length(str_arr), do: throw(:error)

  defp _substring(str_arr, len, idx, rule) do
    curr = str_arr |> Enum.slice((idx - len + 1)..idx) |> Enum.join()

    cond do
      rule.(curr) -> curr
      true -> _substring(str_arr, len, idx + 1, rule)
    end
  end

  @doc """
  Count the depth of nested brackets
  """
  def depth_parentheses(str) do
    str
    |> String.to_charlist()
    |> Enum.map(fn
      ?( -> 1
      ?) -> -1
      _ -> 0
    end)
    |> Enum.scan(&+/2)
    |> Enum.max()
  end

  @doc """
  """
  @spec rearrange(String.t(), list(integer())) :: String.t()
  def rearrange(str, arrangement) do
    0..length(arrangement)
    |> Enum.map(fn i -> {Enum.at(arrangement, i), String.at(str, i)} end)
    |> Enum.sort(fn {l, _}, {r, _} -> l <= r end)
    |> Enum.map(fn {_, g} -> g end)
    |> Enum.join()
  end

  @doc """
  """
  @spec longest_updated_substring(String.t(), integer()) :: integer()
  def longest_updated_substring(str, k) do
    res =
      str
      |> longest_substring(fn
        sub ->
          char = String.first(sub)

          sub
          |> String.graphemes()
          |> Enum.all?(fn x -> x == char end)
      end)
      |> String.length()

    res + k
  end
end
