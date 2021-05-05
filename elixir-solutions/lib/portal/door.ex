#
#  door.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 21:14.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Portal.Door do
  @moduledoc """
   Portal door
  """
  use Agent

  @typedoc """
  Door color
  """
  @type door :: Agent.agent() | atom()

  @doc """
  Start link give a color
  """
  @spec start_link(atom()) :: Agent.on_start()
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  @doc """
  Get data from door
  """
  @spec get(door()) :: Agent.state()
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Push new data from door
  """
  @spec push(door(), any()) :: :ok
  def push(door, value) do
    Agent.update(door, fn list -> [value | list] end)
  end

  @doc """
  Get the first value from top
  """
  @spec pop(door()) :: :error | {:ok, any()}
  def pop(door) do
    Agent.get_and_update(door, fn
      [] -> {:error, []}
      [h | rest] -> {{:ok, h}, rest}
    end)
  end
end
