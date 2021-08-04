#
#  fpx.ex
#  fpx
#
#  Created by d-exclaimation on 8:02 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule FPX do
  @moduledoc """
  Module for `FPX` Application.
  """
  use Application

  @doc """
  Start of the application, set up all the supervisors and processes
  """
  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    main()

    # All children process to be supervised
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Portal.DoorSupervisor}
    ]

    opts = [strategy: :one_for_one, name: FPX.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  main function for custom stuff
  """
  @spec main() :: :ok
  def main() do
    ProjectNetwork.reduction_on_crashing(
      [
        %{activity: "A", n_time: 5, c_time: 4, n_cost: 400, c_cost: 750},
        %{activity: "B", n_time: 8, c_time: 7, n_cost: 1800, c_cost: 2100},
        %{activity: "E", n_time: 8, c_time: 7, n_cost: 1700, c_cost: 1950},
        %{activity: "H", n_time: 4, c_time: 3, n_cost: 400, c_cost: 600},
        %{activity: "I", n_time: 6, c_time: 5, n_cost: 900, c_cost: 1300}
      ],
      3
    )
    |> IO.inspect()

    :ok
  end
end
