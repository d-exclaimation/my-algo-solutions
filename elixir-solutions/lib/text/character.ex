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
  import MapMerge

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

  @doc """
  String compression
  """
  @spec compressed([String.t()]) :: [String.t()]
  def compressed([]), do: []

  def compressed([head | tail]) do
    do_compressed(tail, head, 1)
  end

  @spec do_compressed([String.t()], String.t(), integer) :: [String.t()]
  defp do_compressed([], prev, 1), do: [prev]
  defp do_compressed([], prev, count), do: [prev, "#{count}"]

  defp do_compressed([head | tail], prev, count) do
    case head do
      ^prev ->
        do_compressed(tail, prev, count + 1)

      _ ->
        if count == 1 do
          [prev | do_compressed(tail, head, 1)]
        else
          [prev, "#{count}" | do_compressed(tail, head, 1)]
        end
    end
  end

  @doc """
  Check if permutation can be palindrome
  """
  @spec palindromable?(String.t()) :: boolean()
  def palindromable?(str) do
    unmatched =
      str
      |> String.to_charlist()
      |> Enum.reduce(Map.new(), fn x, acc ->
        acc
        |> Map.put(x, Map.get(acc, x, 0) + 1)
      end)
      |> Map.to_list()
      |> Enum.filter(fn {_, val} -> rem(val, 2) != 0 end)
      |> Enum.count()

    unmatched == rem(String.length(str), 2)
  end

  @doc """
  Find the maximum amount of formation of target can be done with source
  """
  @spec form_count(String.t(), String.t()) :: integer
  def form_count(source, target) do
    target_set = MapSet.new(String.to_charlist(target))

    source
    |> String.to_charlist()
    |> Enum.filter(&MapSet.member?(target_set, &1))
    |> Enum.frequencies()
    |> Enum.map(fn {_, count} -> count end)
    |> Enum.min()
  end

  @doc """
  Map Character left and right
  """
  @spec map([String.Chars.t()], [String.Chars.t()]) :: %{String.Chars.t() => String.Chars.t()}
  def map([], []), do: %{}

  def map([lhs | lt], [rhs | rt]) do
    %{lhs => rhs} &&& map(lt, rt)
  end

  @doc """
  """
  @spec mappable?(String.t(), String.t()) :: boolean
  def mappable?(keys, values) do
    keys_arr = String.graphemes(keys)
    values_arr = String.graphemes(values)

    {sign, _} =
      Enum.zip(
        keys_arr,
        values_arr
      )
      |> Enum.reduce({:ok, %{}}, fn {a, b}, acc ->
        case acc do
          {:error, res} ->
            {:error, res}

          {:ok, res} ->
            case Map.get(res, a, b) do
              ^b -> {:ok, res &&& %{a => b}}
              _ -> {:error, res}
            end
        end
      end)

    sign == :ok
  end

  @doc """
  """
  @spec lowercase(String.t()) :: String.t()
  def lowercase(word) do
    word
    |> String.to_charlist()
    |> Enum.map(fn c -> if c <= 90, do: c + 32, else: c end)
    |> to_string()
  end

  @doc """
  Smallest Lexicographical characters
  """
  @spec smallest_lexicographical(String.t()) :: [String.Chars.t()]
  def smallest_lexicographical(s) do
    res =
      s
      |> String.to_charlist()
      |> Enum.sort()
      |> Enum.at(0, nil)

    s
    |> String.to_charlist()
    |> Enum.filter(fn x -> x == res end)
  end

  @doc """
  Smallest count of letter in words that have a smaller count of its smallest lex char
  """
  @spec smallest_count_letter([String.t()], [String.t()]) :: [integer()]
  def smallest_count_letter(queries, words) do
    queries
    |> Enum.map(fn query ->
      curr =
        query
        |> smallest_lexicographical()
        |> Enum.count()

      words
      |> Enum.count(fn word -> curr < Enum.count(smallest_lexicographical(word)) end)
    end)
  end
end
