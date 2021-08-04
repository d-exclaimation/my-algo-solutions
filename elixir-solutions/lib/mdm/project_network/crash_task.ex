#
#  task.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 01:14.
#

defmodule ProjectNetwork.CrashTask do
  @moduledoc """

  """
  use TypedStruct

  typedstruct do
    @typedoc "A Task info that can be crashed"
    field(:label, String.t(), enforce: true)
    field(:n_time, integer(), default: 0)
    field(:c_time, integer(), default: 0)
    field(:n_cost, number(), enforce: true)
    field(:c_cost, number(), default: 0)
  end

  @type constructor :: %{
          label: String.t(),
          n_time: integer(),
          c_time: integer() | none(),
          n_cost: number(),
          c_cost: number() | none()
        }

  @doc """
  Creates a new Crashable Task
  """
  @spec new(constructor()) :: t()
  def new(%{label: label, n_time: nt, n_cost: nc} = const) do
    %__MODULE__{
      label: label,
      n_time: nt,
      c_time: Map.get(const, :c_time, nt),
      n_cost: nc,
      c_cost: Map.get(const, :c_cost, nc)
    }
  end
end
