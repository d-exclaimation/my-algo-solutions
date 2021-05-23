#
#  linked_list.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 06:05.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule LinkedList do
  @moduledoc """
    LinkedList
  """

  @enforce_keys [:curr, :data]
  defstruct [:curr, :data]

  @typedoc """
  LinkedList Struct Type
  """
  @type t() :: %__MODULE__{}

  @doc """
  Create a new linkedlist
  """
  @spec new([any]) :: t()
  def new(arr) do
    %__MODULE__{
      curr: 0,
      data:
        arr
        |> Enum.with_index(1)
    }
  end

  @doc """
  Detect cycle in a linkedlist
  """
  @spec cycle?(t()) :: boolean()
  def cycle?(%__MODULE__{curr: curr, data: data}) when curr >= 0 and curr < length(data) do
    {_, i} = Enum.at(data, curr)

    case Enum.at(data, i, :none) do
      {_, j} -> do_cycle?(data, i, j)
      :none -> false
    end
  end

  @spec do_cycle?([{any, integer}], integer, integer) :: boolean()
  defp do_cycle?(data, i, j) when i < 0 or i >= length(data) or j < 0 or j >= length(data),
    do: false

  defp do_cycle?(_, i, j) when i == j, do: true

  defp do_cycle?(data, i, j) do
    {_, new_i} = Enum.at(data, i)

    case Enum.at(data, j, :none) do
      {_, k} ->
        {_, new_j} = Enum.at(data, k)
        do_cycle?(data, new_i, new_j)

      :none ->
        false
    end
  end

  @doc """
  Get current item in the linkedlist
  """
  @spec get(t()) :: any
  def get(%__MODULE__{data: data, curr: curr}) do
    case Enum.at(data, curr, :none) do
      {x, _} -> x
      :none -> nil
    end
  end

  @doc """
  Get next in the line
  """
  @spec next(t()) :: t()
  def next(%__MODULE__{curr: curr, data: data}) when curr >= 0 and curr < length(data) do
    {_, i} = Enum.at(data, curr)

    %__MODULE__{
      curr: i,
      data: data
    }
  end

  @doc """
  Push new item
  """
  @spec push(t(), any) :: t()
  def push(%__MODULE__{curr: curr, data: data}, val) do
    %__MODULE__{
      curr: curr,
      data: data ++ [{val, length(data) + 1}]
    }
  end

  @doc """
  Push a new node
  """
  @spec force_push(t(), {any, integer}) :: t()
  def force_push(%__MODULE__{curr: curr, data: data}, new_node) do
    %__MODULE__{
      curr: curr,
      data: data ++ [new_node]
    }
  end
end

defimpl String.Chars, for: LinkedList do
  @doc """
  String represetationg of linkedlist
  """
  @spec to_string(LinkedList.t()) :: String.t()
  def to_string(%LinkedList{curr: curr, data: data}),
    do: do_concat(curr, data, MapSet.new())

  defp do_concat(curr, data, _)
       when curr < 0 or curr >= Kernel.length(data),
       do: "end"

  defp do_concat(curr, data, set) do
    {val, i} = Enum.at(data, curr)

    case MapSet.member?(set, curr) do
      true -> "...cycle to (#{val})"
      false -> "#{val} -> #{do_concat(i, data, MapSet.put(set, curr))}"
    end
  end
end

defimpl Inspect, for: LinkedList do
  @doc """
  """
  @spec inspect(LinkedList.t(), any) :: String.t()
  def inspect(%LinkedList{curr: curr, data: data}, _)
      when curr < 0 or curr >= Kernel.length(data),
      do: "#LinkedList<nil>"

  def inspect(%LinkedList{curr: curr, data: data}, _) do
    """
    #LinkedList<
      #{do_inspect(curr, data, MapSet.new())}
    >
    """
  end

  defp do_inspect(curr, data, _) when curr < 0 or curr >= Kernel.length(data), do: "end"

  defp do_inspect(curr, data, set) do
    {val, i} = Enum.at(data, curr)

    case MapSet.member?(set, curr) do
      true -> "...cycle to (#{val})"
      false -> "#{val} -> #{do_inspect(i, data, MapSet.put(set, curr))}"
    end
  end
end
