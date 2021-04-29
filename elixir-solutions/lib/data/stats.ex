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
  """
  def filter_bootstrap(gen, sample) when is_list(gen) and is_list(sample) do
    gen
    |> Enum.filter(fn boot -> Stats.bootstrap?(boot, sample) end)
  end

  @doc """
  Valid a bootstrap to the sample
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
  """
  def possible_init(inits, {low, up}) do
    inits
    |> Enum.filter(fn x -> (x - low) == (up - x) end)
  end

  @doc """

  """
  @spec remaining_todo() :: :ok
  def remaining_todo() do
    todos = """
    Home Page Stats Label	✅	✅	✅
    Latest / New Home Page Preview	✅	✅	✅
    Social Links	✅	✅	✅
    Hero Heading	✅	✅	✅
    Background mini-projects	✅	✅	✅
    Repo Cards	✅	✅	✅
    NavBar	✅	✅	✅
    Bio Cards	❌	❌	❌
    Music Player	❌	❌	❌
    Music Playlist	❌	❌	❌
    Uniform Buttons	❌	❌	❌
    Music Disk	❌	❌	❌
    Post Preview	✅	✅	✅
    Loading Screen	✌️	✌️	✌️
    Select Menu	❔	❔	❔
    Post Body Markdown	❔	❌	❌
    Uniform Compact Forms	❌	❌	❌
    Uniform Large Forms	❌	❌	❌
    Password / Login Page	✅	✌️	✌️
    Uprave Button	❌	❌	❌
    Grid-Based Feed	❌	❌	❌
    Editor Form	✌️	✌️	❌
    Markdown Preview	✅	✌️	✌️
    Form Modal	❌	❌	❌
    Alert and Toast	✅	✌️	✌️
    """
    each = todos
    |> String.split("\n")
    |> Enum.map(fn str -> String.split(str, "\t") end)
    |> Enum.filter(fn str_arr -> Enum.member?(str_arr, "❌") or Enum.member?(str_arr, "❔") end)
    IO.puts("You have #{each |> Enum.count()} more unique component(s) to build")
    result = each
    |> Enum.map(fn str_arr -> str_arr |> Enum.filter(fn x -> x == "❌" or x == "❔" end) |> Enum.count end)
    |> Enum.sum()
    IO.puts("You have #{result} more work(s) to finish")
  end
end
