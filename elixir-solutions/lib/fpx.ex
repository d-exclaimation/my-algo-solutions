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
    res =
      Heap.new(&</2, "Min")
      |> Heap.put(4)
      |> Heap.put(2)
      |> Heap.put(5)
      |> Heap.put(1)

    {:ok, min, new_res} =
      res
      |> Heap.pop()

    IO.puts(min)

    res =
      new_res
      |> Heap.put(1)
      |> Heap.put(6)

    IO.inspect(res)

    :ok
  end
end
