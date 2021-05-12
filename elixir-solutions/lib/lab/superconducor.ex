#
#  superconducor.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 14:45.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Superconducor do
  @moduledoc """
    SuperConductor lab
  """
  import MapMerge

  @table [
    %{exponent: 60, row: [7.6, 7.53, 7.46, 7.40, 7.33, 7.26, 7.19, 7.12, 7.05, 6.99]},
    %{exponent: 70, row: [6.92, 6.85, 6.78, 6.71, 6.64, 6.56, 6.49, 6.42, 6.37, 6.33]},
    %{exponent: 80, row: [6.29, 6.25, 6.21, 6.17, 6.13, 6.09, 6.05, 6.01, 5.97, 5.93]},
    %{exponent: 90, row: [5.90, 5.86, 5.83, 5.79, 5.75, 5.72, 5.68, 5.64, 5.60, 5.56]},
    %{exponent: 100, row: [5.52, 5.48, 5.44, 5.41, 5.37, 5.34, 5.30, 5.27, 5.23, 5.20]},
    %{exponent: 110, row: [5.16, 5.13, 5.09, 5.06, 5.02, 4.99, 4.95, 4.91, 4.88, 4.84]},
    %{exponent: 120, row: [4.81, 4.77, 4.74, 4.70, 4.67, 4.63, 4.60, 4.56, 4.53, 4.49]},
    %{exponent: 130, row: [4.46, 4.42, 4.39, 4.35, 4.32, 4.28, 4.25, 4.21, 4.18, 4.14]},
    %{exponent: 140, row: [4.11, 4.07, 4.04, 4.00, 3.97, 3.93, 3.90, 3.86, 3.83, 3.79]},
    %{exponent: 150, row: [3.76, 3.73, 3.69, 3.66, 3.63, 3.60, 3.56, 3.53, 3.50, 3.47]},
    %{exponent: 160, row: [3.43, 3.40, 3.37, 3.34, 3.30, 3.27, 3.24, 3.21, 3.18, 3.15]},
    %{exponent: 170, row: [3.12, 3.09, 3.06, 3.03, 3.00, 2.97, 2.94, 2.91, 2.88, 2.85]},
    %{exponent: 180, row: [2.82, 2.79, 2.76, 2.73, 2.70, 2.67, 2.64, 2.61, 2.58, 2.53]},
    %{exponent: 190, row: [2.52, 2.49, 2.46, 2.43, 2.40, 2.37, 2.34, 2.31, 2.29, 2.26]},
    %{exponent: 200, row: [2.23, 2.20, 2.17, 2.14, 2.11, 2.08, 2.05, 2.02, 1.99, 1.96]},
    %{exponent: 210, row: [1.93, 1.90, 1.87, 1.84, 1.81, 1.78, 1.75, 1.72, 1.69, 1.66]},
    %{exponent: 220, row: [1.64, 1.61, 1.59, 1.56, 1.54, 1.51, 1.49, 1.46, 1.44, 1.41]},
    %{exponent: 230, row: [1.39, 1.36, 1.34, 1.31, 1.29, 1.26, 1.24, 1.21, 1.19, 1.16]},
    %{exponent: 240, row: [1.14, 1.11, 1.09, 1.07, 1.04, 1.02, 0.99, 0.97, 0.94, 0.92]},
    %{exponent: 250, row: [0.89, 0.87, 0.84, 0.82, 0.79, 0.77, 0.74, 0.72, 0.69, 0.67]},
    %{exponent: 260, row: [0.65, 0.62, 0.60, 0.58, 0.55, 0.53, 0.50, 0.48, 0.45, 0.42]},
    %{exponent: 270, row: [0.40, 0.38, 0.36, 0.34, 0.32, 0.30, 0.28, 0.26, 0.24, 0.22]},
    %{exponent: 280, row: [0.20, 0.18, 0.16, 0.14, 0.12, 0.10, 0.08, 0.06, 0.04, 0.02]},
    %{exponent: 290, row: [0.00, -0.02, -0.04, -0.06, -0.08, -0.10, -0.12, -0.14, -0.16, -0.18]}
  ]

  @doc """
  Part one
  """
  @spec part_one() :: :ok
  def part_one() do
    IO.puts("LN2 Voltage|Temperature")
    IO.puts("-|-")
    [tln] = find_temperature([6.42])
    IO.puts("#{6.42}|#{tln}")

    data = [
      6.20,
      6.17,
      6.22,
      6.15,
      6.18
    ]

    res = find_temperature(data)
    IO.puts("Drop voltage|Temperature")
    IO.puts("-|-")

    0..(length(data) - 1)
    |> Enum.each(fn x ->
      v = Enum.at(data, x)
      t = Enum.at(res, x)

      IO.puts(
        "#{if(is_integer(v), do: v, else: Float.round(v, 2))}|#{
          if(is_integer(t), do: t, else: Float.round(t, 2))
        }"
      )
    end)

    temp = Enum.sum(res) / Enum.count(res)
    uncertain = (Enum.max(res) - Enum.min(res)) / 2

    IO.puts("""
    \n
    #{Float.round(temp, 3)} ± #{Float.round(uncertain, 3)}
    """)
  end

  @doc """
  Part two
  """
  @spec part_two() :: :ok
  def part_two() do
    data = [
      {6.39, 0.18},
      {6.40, 0.22},
      {6.39, 0.39},
      {6.35, 0.66},
      {6.33, 1.31},
      {6.31, 2.30},
      {6.28, 3.10},
      {6.24, 3.59},
      {6.19, 3.78},
      {6.17, 3.90},
      {6.12, 4.00},
      {6.08, 4.10},
      {6.00, 4.22},
      {5.91, 4.27},
      {5.88, 4.33},
      {5.84, 4.40},
      {5.77, 4.42},
      {5.52, 4.44},
      {5.40, 4.65},
      {5.30, 4.80},
      {5.13, 4.96}
    ]

    table_voltage(data)
    :ok
  end

  @doc """
  """
  @spec part_three() :: :ok
  def part_three() do
    data = [
      {6.17, 9.69},
      {5.82, 10.08},
      {5.48, 10.40},
      {5.01, 10.73},
      {4.43, 10.93},
      {3.99, 11.17},
      {3.53, 11.52},
      {3.15, 11.67},
      {2.66, 12.16},
      {2.30, 12.30},
      {2.17, 12.46},
      {2.02, 12.53},
      {1.89, 12.67},
      {1.76, 12.80},
      {1.60, 12.87},
      {1.34, 13.03},
      {0.99, 13.14},
      {0.94, 13.23},
      {0.53, 13.31}
    ]

    table_voltage(data)
    :ok
  end

  @doc """
  """
  @spec table_voltage([{float, float}]) :: [any]
  def table_voltage(data) do
    {vtemps, volts} = {Enum.map(data, fn {v_t, _} -> v_t end), Enum.map(data, fn {_, v} -> v end)}

    temps = find_temperature(vtemps)
    resistances = Enum.map(volts, &find_resistance(&1, 1.48))

    IO.puts(
      "Voltage on temp probe (mV) | Voltage on voltage probe (mV) | Temperature K | Resistance Ω"
    )

    IO.puts("-|-|-|-")

    for i <- 0..(length(data) - 1) do
      {vt, v, t, r} =
        {Enum.at(vtemps, i), Enum.at(volts, i), Enum.at(temps, i), Enum.at(resistances, i)}

      IO.puts("#{rounded(vt)},#{rounded(v)},#{rounded(t)},#{rounded(r)}")
    end
  end

  @doc """
  Find temperature
  """
  @spec find_temperature([float]) :: [float]
  def find_temperature([]), do: []

  def find_temperature([head | tail]) do
    # Upgrade table into having index on low and high
    new_table =
      @table
      |> Enum.map(&upgrade_table/1)

    # We try to find best fit row,
    case find_row(head, new_table) do
      # if returned an error or, we have insufficient, raise a warning
      :error ->
        raise "Nooo"

      {:prev, curr} ->
        raise "#{curr}"

      # Using the return table row, we try to look for the best index, to determined the singular value
      res ->
        case find_in_row(0, res.row, head) do
          :error ->
            raise "Something is wrong"

          {:ok, val} ->
            [res.exponent + val | find_temperature(tail)]

          {:boundary, idx} ->
            [res.exponent + idx | find_temperature(tail)]
        end
    end
  end

  @spec find_row(float, [%{high: float, low: float, row: [float], exponent: float}]) ::
          {:prev, %{high: float, low: float, row: [float], exponent: float}}
          | :error
          | %{high: float, low: float, row: [float], exponent: float}
  defp find_row(_, []), do: :error

  defp find_row(curr, [%{high: high, low: low} = head | tail]) do
    cond do
      # Sign we have just passed the row (potentially a in between row)
      curr > high ->
        {:prev, head}

      # We have reach it, so we savely try
      curr < low ->
        # if returned value of next is a prev warning, we pattern match and create a bootstrap row
        case find_row(curr, tail) do
          {:prev, next} ->
            %{
              high: head.high,
              low: next.low,
              row: head.row ++ next.row,
              exponent: head.exponent
            }

          # Otherwise, we can just use the current row
          val ->
            val
        end

      true ->
        head
    end
  end

  @spec find_in_row(integer, [%{val: float, single: integer}], float) ::
          :error | {:ok, number} | {:boundary, number}
  defp find_in_row(idx, row, _) when length(row) == idx, do: :error

  defp find_in_row(idx, row, value) do
    # We get the current looked at
    curr = Enum.at(row, idx)

    cond do
      # Perfect match, return index untouch
      round(curr * 100) == round(value * 100) ->
        {:ok, idx}

      # Unperfect mix with previous, we find the correct proportion
      round(curr * 100) < round(value * 100) ->
        diff = value - curr
        first? = idx == 0

        # If this is the first item, we set a case with pattern matching and return curr.singular
        range = if(not first?, do: Enum.at(row, idx - 1) - curr, else: diff)
        {if(not first?, do: :ok, else: :boundary), idx - diff / range}

      true ->
        find_in_row(idx + 1, row, value)
    end
  end

  @spec upgrade_table(%{exponent: integer, row: [float]}) :: %{
          exponent: integer,
          row: list(float),
          high: float,
          low: float
        }
  def upgrade_table(%{exponent: ex, row: row}) do
    %{
      exponent: ex,
      row: row
    } &&&
      %{
        high: Enum.max(row),
        low: Enum.min(row)
      }
  end

  @spec find_resistance(number, number) :: number
  defp find_resistance(v, i), do: v / i

  @spec rounded(integer | float) :: integer | float
  defp rounded(x) when is_integer(x), do: x
  defp rounded(x) when is_float(x), do: Float.round(x, 2)
end
