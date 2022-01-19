#
#  async.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 02:06.
#

defmodule Async do
  @moduledoc """
    Async / await pattern
  """

  @doc """
  """
  @spec test1() :: :ok
  def test1() do
    task0 =
      Task.async(fn ->
        Process.sleep(3 * 1000)
        IO.puts("3 seconds")
        3
      end)

    task1 =
      Task.async(fn ->
        Process.sleep(1 * 1000)
        IO.puts("1 second")
        1
      end)

    Task.await(task1)
    Task.await(task0)

    :ok
  end
end
