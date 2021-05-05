#
#  file_name.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 13:18.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule FileName do
  @moduledoc """
    File Name and File extensions related
  """
  @doc """
  Find the shortest summary / final result of path given a relative one
  """
  @spec shortest_path(String.t()) :: String.t()
  def shortest_path(file_path) do
    do_shortest_path(String.split(file_path, "/"), [])
    |> Enum.reverse()
    |> Enum.join("/")
  end

  @spec do_shortest_path(list(String.t()), list(String.t())) :: list(String.t())
  defp do_shortest_path([], res), do: res

  defp do_shortest_path([next | remains], path) do
    if length(path) == 0 do
      case next do
        ".." -> raise "Cannot backed up"
        "." -> do_shortest_path(remains, path)
        _ -> do_shortest_path(remains, [next | path])
      end
    else
      [curr | prev] = path

      case next do
        ".." -> do_shortest_path(remains, prev)
        "." -> do_shortest_path(remains, [curr | prev])
        _ -> do_shortest_path(remains, [next, curr | prev])
      end
    end
  end
end
