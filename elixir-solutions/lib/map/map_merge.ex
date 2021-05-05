#
#  map_merge.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 17:32.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule MapMerge do
  @moduledoc """
  Map Merging
  """

  @doc """
  Merge map
  """
  @spec map() &&& map() :: map()
  def a &&& b when is_map(a) and is_map(b) do
    Map.merge(a, b)
  end
end
