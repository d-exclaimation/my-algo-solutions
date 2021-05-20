#
#  portal.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 21:29.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Portal do
  @moduledoc """
    Portal Struct
    Two Portal Doors and transfer data as list
  """
  @enforce_keys []
  defstruct [:left, :right]

  @typedoc """
  Portal Struct Type
  """
  @type t :: %__MODULE__{}

  @doc """
  Shoot a new portal door, supervised a new Portal.Door
  given a color
  """
  @spec shoot(atom()) :: Agent.on_start()
  def shoot(color) do
    DynamicSupervisor.start_child(Portal.DoorSupervisor, {Portal.Door, color})
  end

  @doc """
  Starts transfering `data` from `left` to `right`
  """
  @spec transfer(Portal.Door.door(), Portal.Door.door(), [any()]) :: t()
  def transfer(left, right, init_values) do
    Enum.each(init_values, fn x ->
      Portal.Door.push(left, x)
    end)

    %Portal{left: left, right: right}
  end

  @doc """
  Pushes data to the right in the given `portal`
  """
  @spec push_right(t()) :: t()
  def push_right(portal) do
    portal.left |> Portal.Door.push(portal.right)

    portal
  end

  @doc """
  Pushes data to the left in the given `portal`
  """
  @spec push_left(t()) :: t()
  def push_left(portal) do
    portal.right |> Portal.Door.push(portal.left)

    portal
  end
end

defimpl Inspect, for: Portal do
  @doc """
  Inspection for Portal
  """
  @spec inspect(%Portal{}, any()) :: String.t()
  def inspect(%Portal{left: l, right: r}, _) do
    ld = inspect(l)
    rd = inspect(r)
    lhs = inspect(Enum.reverse(Portal.Door.get(l)))
    rhs = inspect(Portal.Door.get(r))
    m = max(String.length(ld), String.length(lhs))

    """
    #Portal<
      #{String.pad_leading(ld, m)} <=> #{rd}
      #{String.pad_leading(lhs, m)} <=> #{rhs}
    >
    """
  end
end
