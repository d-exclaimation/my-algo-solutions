#
#  heap.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 12:15.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Heap do
  @moduledoc """
    Heap data structure
  """

  @enforce_keys [:data, :resolve]
  defstruct [:data, :resolve, :type]

  @typedoc """
  Heap Struct Type
  """
  @type t() :: %__MODULE__{}

  @doc """
  Instantiate
  """
  @spec new((any, any -> boolean), String.t()) :: Heap.t()
  def new(resolve, type \\ "") do
    %__MODULE__{
      data: [],
      resolve: resolve,
      type: type
    }
  end

  @doc """
  Put item in heap
  """
  @spec put(t(), any) :: t()
  def put(%__MODULE__{data: data, resolve: resolve, type: type}, val) do
    %__MODULE__{
      data: sift_up(data ++ [val], resolve, length(data)),
      resolve: resolve,
      type: type
    }
  end

  @doc """
  Peek the most top item
  """
  @spec peek(t()) :: any | none
  def peek(%__MODULE__{data: []}), do: nil

  def peek(%__MODULE__{data: [head | _]}) do
    head
  end

  @spec sift_up([any], (any, any -> boolean), integer) :: [any]
  defp sift_up(data, _resolve, idx) when idx <= 0, do: data

  defp sift_up(data, resolve, idx) do
    pdx = div(idx + 1, 2) - 1
    parent = Enum.at(data, pdx)
    child = Enum.at(data, idx)

    if resolve.(child, parent) do
      sift_up(swap(data, pdx, idx), resolve, pdx)
    else
      data
    end
  end

  @doc """
  Pop the most top item
  """
  @spec pop(t()) :: {:ok, any, t()} | {:error, t()}
  def pop(%__MODULE__{data: []} = heap), do: {:error, heap}

  def pop(%__MODULE__{data: [head | tail], resolve: resolve, type: type}) do
    {
      :ok,
      head,
      %__MODULE__{
        data: sift_down([Enum.at(tail, -1) | Enum.slice(tail, 0..-2)], resolve, 0),
        resolve: resolve,
        type: type
      }
    }
  end

  @spec sift_down([any], (any, any -> boolean), integer) :: [any]
  defp sift_down(data, _resolve, idx) when (idx + 1) * 2 > length(data), do: data

  defp sift_down(data, resolve, idx) do
    left = (idx + 1) * 2 - 1
    right = (idx + 1) * 2
    sdx = if(resolve.(Enum.at(data, right), Enum.at(data, left)), do: right, else: left)
    curr = Enum.at(data, idx)
    smallest = Enum.at(data, sdx)

    if resolve.(smallest, curr) do
      sift_down(swap(data, sdx, idx), resolve, sdx)
    else
      data
    end
  end

  defp swap(data, i, j) do
    0..(length(data) - 1)
    |> Enum.map(fn
      ^i -> j
      ^j -> i
      x -> x
    end)
    |> Enum.map(&Enum.at(data, &1))
  end
end

defimpl Inspect, for: Heap do
  @doc """
  Inspect a heap
  """
  @spec inspect(Heap.t(), any) :: String.t()
  def inspect(%Heap{data: [], resolve: resolve, type: type}, _) do
    "#Heap< of #{if(type == "", do: inspect(resolve), else: type)} >"
  end

  def inspect(%Heap{data: [head | tail], resolve: resolve, type: type}, _) do
    """
    #Heap<
      of #{if(type == "", do: inspect(resolve), else: type)}
      (#{head}) -> (#{inspect(tail)})
    >
    """
  end
end
