#
#  AbsoluteZero.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 2:48 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule AbsoluteZero do
  @moduledoc """
    This is not dsa again lol
  """

  @type graph_data ::
          %{
            m: float(),
            b: float()
          }
  @type average_data ::
          %{
            reg: float(),
            uncertain: float()
          }

  defmacro return(x), do: x

  @doc """
  Lab 4 Data and logic
  """
  def only_part() do
    # Data given in the graph with liquid nitrogen
    with_liquid_n = [
      %{m: 0.326, b: 93.240},
      %{m: 0.259, b: 74.819},
      %{m: 0.169, b: 51.266}
    ]

    res_with = pairs_apply(with_liquid_n, &gradient_temperature/2)
    res_with |> Enum.each(fn {from, res} -> IO.puts("T(#{from}) -> #{res}") end)

    # Data given in the graph without liquid nitrogen
    without_liquid_n = [
      %{m: 0.334, b: 93.141},
      %{m: 0.288, b: 73.791},
      %{m: 0.188, b: 50.551}
    ]

    res_without = pairs_apply(without_liquid_n, &gradient_temperature/2)
    res_without |> Enum.each(fn {from, res} -> IO.puts("T(#{from}) -> #{res}") end)

    # average of both
    %{reg: with_avg, uncertain: with_avr} =
      res_with |> Enum.map(fn {_, res} -> res end) |> average_temperature()

    %{reg: without_avg, uncertain: without_avr} =
      res_without |> Enum.map(fn {_, res} -> res end) |> average_temperature()

    IO.puts(
      "With liquid nitrogen avg T = #{with_avg} | #{with_avr}, and without avg T = #{without_avg} | #{
        without_avr
      }"
    )
  end

  @doc """
  Do something on three values as pairs of two
  """
  def pairs_apply(arr, something) do
    0..(length(arr) - 1)
    |> Enum.map(fn x -> x end)
    |> MyMath.generate_subset()
    |> Enum.filter(fn x -> is_list(x) and length(x) == 2 end)
    |> Enum.map(fn pair ->
      first = Enum.at(pair, 0)
      second = Enum.at(pair, 1)

      return(
        {"#{first + 1}, #{second + 1}", something.(Enum.at(arr, first), Enum.at(arr, second))}
      )
    end)
  end

  @doc """
  Get gradient temperature from two equation
  """
  @spec gradient_temperature(graph_data(), graph_data()) :: float()
  def gradient_temperature(%{m: m1, b: b1}, %{m: m2, b: b2}), do: (b2 - b1) / (m1 - m2)

  @doc """
  Find average temperature with two ways
  """
  @spec average_temperature(list(float())) :: average_data()
  def average_temperature(all) when length(all) >= 3 do
    [t1, t2, t3 | _] = all

    return(%{
      reg: (t1 + t2 + t3) / 3,
      uncertain: (Enum.max(all) - Enum.min(all)) / 2
    })
  end
end
