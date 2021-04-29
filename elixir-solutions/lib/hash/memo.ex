#
#  Memo.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 8:28 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Memo do
  @moduledoc """
  Memoize problem
  """

  @type collection :: list(any())

  @doc """
  Intersection of three
  -> intersections(collection(), collection(), collection()) :: MapSet
  """
  @spec intersections(collection(), collection(), collection()) :: MapSet
  def intersections(arr1, arr2, arr3) do
    out_two = MapSet.intersection(MapSet.new(arr1), MapSet.new(arr2))
    MapSet.intersection(out_two, MapSet.new(arr3))
  end

end
