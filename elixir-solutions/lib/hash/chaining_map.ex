#
#  ChainingMap.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 2:29 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule ChainingMap do
  alias __MODULE__
  @moduledoc """
  Chaining Hash Map
  (Act like a set atm)
  """
  @enforce_keys [:mapper]
  defstruct [:mapper]

  @type key_value :: {any(), any()}

  @doc """
  Instantiate a new ChainingMap
  -> new(integer()) :: %ChainingMap{}
  """
  @spec new(integer()) :: %ChainingMap{}
  def new(size) do
    %ChainingMap{
      mapper: (1..size) |> Enum.map(fn _ -> [] end)
    }
  end

  @doc """
  Insert into Chaining Map by making a new one
  -> set(any()) :: %ChainingMap{}
  """
  @spec set(%ChainingMap{}, any(), any()) :: %ChainingMap{}
  def set(%ChainingMap{mapper: mapper}, key, val) do
    hash = rem(:erlang.phash2(key), mapper |> Enum.count())
    new_mapper = do_set(mapper, key, val, hash)
    %ChainingMap{
      mapper: new_mapper
    }
  end

  @spec do_set(list(key_value()), any(), any(), integer()) :: %LPMap{}
  defp do_set(mapper, key, val, hash) do
    case find_element(mapper, key, hash) do
      # Append
      :new ->
        0..(length(mapper) - 1)
        |> Enum.map(fn i ->
          if i == hash, do: [{key, val} | Enum.at(mapper, i)], else: Enum.at(mapper, i)
        end)
      # Update
      {:duplicate, idx} ->
        0..(length(mapper) - 1) |>
          Enum.map(fn i ->
            if i == hash,
               do: 0..(length(Enum.at(mapper, i)) - 1)
                              |> Enum.map(fn j -> if j == idx, do: {key, val}, else: Enum.at(Enum.at(mapper, i), j) end),
               else: Enum.at(mapper, i)
          end)
    end
  end

  @doc """

  """
  @spec get(%ChainingMap{}, any()) :: any()
  def get(%ChainingMap{mapper: mapper}, key) do
    hash = rem(:erlang.phash2(key), mapper |> Enum.count())
    case find_element(mapper, key, hash) do
      :new -> nil
      {:duplicate, idx} ->
        {_, val} = Enum.at(mapper, hash) |> Enum.fetch!(idx)
        val
    end
  end

  @doc """
  Check if Chaining Hash Map contains an element
  """
  @spec has?(%ChainingMap{}, any()) :: boolean()
  def has?(%ChainingMap{mapper: mapper}, element) do
    hash = rem(:erlang.phash2(element), mapper |> Enum.count())
    case find_element(mapper, element, hash) do
      :new -> false
      _ -> true
    end
  end

  @spec find_element(list(key_value()), any(), integer()) :: any()
  defp find_element(mapper, key, idx) do
    res = mapper
    |> Enum.at(idx)
    |> Enum.find_index(fn {exist, _} -> exist == key end)
    if res == nil, do: :new, else: {:duplicate, res}
  end

  @doc """
  To String representation
  """
  @spec to_string(%ChainingMap{}) :: String.t()
  def to_string(%ChainingMap{mapper: mapper}) do
    0..(length(mapper) - 1)
    |> Enum.map(fn i -> "#{i + 1} :: " <> Enum.join(Enum.at(mapper, i) |> Enum.map(fn {key, val} -> "#{key}: (#{val})" end), ", ") end)
    |> Enum.join("\n")
  end
end
