#
#  project_network.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 00:31.
#

defmodule ProjectNetwork do
  @moduledoc """
    Crash Project Management
  """

  @type node_info :: %{
          activity: String.t(),
          n_time: integer(),
          c_time: integer(),
          n_cost: number(),
          c_cost: number()
        }

  @type crash_info :: %{
          activity: String.t(),
          time_reduction: integer(),
          cost_added: number()
        }

  @doc """
  Finding the best choice for reducing the time
  """
  @spec reduction_on_crashing([node_info()], integer()) :: [crash_info()]
  def reduction_on_crashing(infos, time_needed) do
    infos
    |> Enum.flat_map(fn %{activity: name, n_time: nt, c_time: ct, n_cost: nc, c_cost: cc} ->
      for _ <- 1..(nt - ct), do: %{activity: name, cost: cc - nc}
    end)
    |> Enum.sort(fn lhs, rhs -> lhs.cost <= rhs.cost end)
    |> Enum.take(time_needed)
    |> Enum.reduce(Map.new(), fn %{activity: name, cost: cost}, acc ->
      %{time_reduction: prev_time, cost_added: prev_cost} =
        Map.get(acc, name, %{
          activity: name,
          time_reduction: 0,
          cost_added: 0
        })

      Map.put(acc, name, %{
        activity: name,
        time_reduction: prev_time + 1,
        cost_added: prev_cost + cost
      })
    end)
    |> Map.values()
  end
end
