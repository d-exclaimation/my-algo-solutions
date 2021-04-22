#
#  Stats.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 4:32 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Stats do
  @moduledoc """
  Statistic module
  """

  @doc """
  Validate bootstraps to the sample
  -> gen: list(list(any))
  -> sample: list(any)
  :: list(list(any))
  """
  def filter_bootstrap(gen, sample) when is_list(gen) and is_list(sample) do
    gen
    |> Enum.filter(fn boot -> Stats.bootstrap?(boot, sample) end)
  end

  @doc """
  Valid a bootstrap to the sample
  -> boot && sample: list(any)
  :: boolean
  """
  def bootstrap?(boot, sample) when is_list(boot) and is_list(sample) do
    boot
    |> Enum.map(fn x ->
      if Enum.find(sample, fn y -> y == x end), do: 1, else: 0
    end)
    |> Enum.sum()
    == length(boot)
  end

  @doc """
  Filter all possible initial sample (mean / proportion)
  -> inits: list(integer)
  :: list(integer)
  """
  def possible_init(inits, {low, up}) do
    inits
    |> Enum.filter(fn x -> (x - low) == (up - x) end)
  end
end
