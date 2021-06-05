#
#  map_split.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 22:04.
#

defmodule MapSplit do
  @moduledoc """
    Split map into pieces
  """

  @type original_map :: %{
          name: String.t(),
          arr1: [%{name: String.t()}],
          arr2: [%{name: String.t()}]
        }
  @type reduced_map :: %{
          name: String.t(),
          arr1: %{name: String.t()} | nil,
          arr2: %{name: String.t()} | nil
        }

  @doc """
  """
  @spec split_reduce([original_map()]) :: [reduced_map()]
  def split_reduce(data) do
    data
    |> Enum.flat_map(&do_split_reduce/1)
  end

  @spec do_split_reduce(original_map()) :: [reduced_map()]
  defp do_split_reduce(%{name: label, arr1: arr1, arr2: arr2}) do
    cond do
      arr1 == [] && arr2 == [] ->
        []

      arr1 == [] ->
        [second_head | second_tail] = arr2

        [
          %{name: label, arr1: nil, arr2: second_head}
          | do_split_reduce(%{name: label, arr1: [], arr2: second_tail})
        ]

      arr2 == [] ->
        [first_head | first_tail] = arr1

        [
          %{name: label, arr1: first_head, arr2: nil}
          | do_split_reduce(%{name: label, arr1: first_tail, arr2: []})
        ]

      true ->
        [first_head | first_tail] = arr1
        [second_head | second_tail] = arr2

        [
          %{name: label, arr1: first_head, arr2: second_head}
          | do_split_reduce(%{name: label, arr1: first_tail, arr2: second_tail})
        ]
    end
  end
end
