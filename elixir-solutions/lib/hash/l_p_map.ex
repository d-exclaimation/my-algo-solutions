#
#  LPMap.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 3:06 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule LPMap do
  alias __MODULE__
  @moduledoc """
  Linear Probing Hash Map
  """
  @enforce_keys [:mapper]
  defstruct [:mapper]

  @type key_value :: {any(), any()}

  @doc """
  Instantiate a new Linear Probing Hash Map
  """
  @spec new(integer()) :: %LPMap{}
  def new(size) do
    %LPMap{
      mapper: 1..size |> Enum.map(fn _ -> {:empty_slot, nil} end),
    }
  end

  @doc """
  Insert into map
  """
  @spec set(%LPMap{}, any(), any()) :: %LPMap{}
  def set(%LPMap{mapper: mapper}, key, element) do
    hash = rem(:erlang.phash2(key), mapper |> Enum.count())
    %LPMap{
      mapper: do_set(mapper, key, element, hash),
    }
  end

  @spec do_set(list(key_value()), any(), any(), integer()) :: %LPMap{}
  defp do_set(mapper, key, element, hash) do
    case find_element(mapper, key, hash) do
      # Insert
      {:new, index} -> false
        0..(length(mapper) - 1)
        |> Enum.map(fn i -> if i == index, do: {key, element}, else: Enum.at(mapper, i) end)
      # Update
      {:duplicate, index} ->
        0..(length(mapper) - 1)
        |> Enum.map(fn i -> if i == index, do: {key, element}, else: Enum.at(mapper, i) end)
      :full_capacity -> raise "Full Capacity"
    end
  end

  @doc """
  Insert into map
  """
  @spec get(%LPMap{}, any()) :: any()
  def get(%LPMap{mapper: mapper}, key) do
    hash = rem(:erlang.phash2(key), mapper |> Enum.count())
    do_get(mapper, key, hash)
  end

  @spec do_get(list(key_value()), any(), integer()) :: any()
  defp do_get(mapper, key, hash) do
    case find_element(mapper, key, hash) do
      {:duplicate, index} ->
        {_, val} = Enum.at(mapper, index)
        val
      _ -> nil
    end
  end



  @doc """
  Check if contains a key
  """
  @spec has?(%LPMap{}, any()) :: boolean()
  def has?(%LPMap{mapper: mapper}, element) do
    hash = rem(:erlang.phash2(element), mapper |> Enum.count())
    case find_element(mapper, element, hash) do
      {:new, _} -> false
      {:duplicate, _} -> true
      :full_capacity -> false
    end
  end

  @spec find_element(list(key_value()), any(), integer()) :: any()
  defp find_element(mapper, element, start) do
    {key, _} = Enum.at(mapper, start)
    case key do
      :empty_slot -> {:new, start}
      ^element -> {:duplicate, start}
      _ -> find_element(mapper, element, start, rem(start + 1, mapper |> Enum.count()))
    end
  end
  @spec find_element(list(any()), any(), integer(), integer()) :: any()
  defp find_element(_, _, start, curr) when start == curr, do: :full_capacity
  defp find_element(mapper, element, start, curr) do
    {key, _} = Enum.at(mapper, curr)
    case key do
      :empty_slot -> {:new, curr}
      ^element -> {:duplicate, curr}
      _ -> find_element(mapper, element, start, rem(curr + 1, mapper |> Enum.count()))
    end
  end

  @doc """
  To String Representation
  """
  @spec to_string(%LPMap{}) :: String.t()
  def to_string(%LPMap{mapper: mapper}) do
    0..(length(mapper) - 1)
    |> Enum.map(fn i ->
        {key, val} = Enum.at(mapper, i)
        "#{i + 1} :: #{key} -> #{val}"
      end)
    |> Enum.join("\n")
  end
end
