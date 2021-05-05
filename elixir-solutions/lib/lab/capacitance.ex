#
#  capacitance.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 14:43.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Capacitance do
  @moduledoc """
    Capacitance lab, not dsa lol
  """
  import MapMerge, only: [&&&: 2]

  defmacro return(x), do: x

  @typedoc """
  Commerial Capicitor Values
  """
  @type commerical_cap :: %{
          capacitor: String.t(),
          stated: number(),
          measured: number(),
          tolerance: float(),
          reality: float()
        }

  @doc """
  """
  @spec part_one() :: :ok
  def part_one() do
    IO.puts("Capacitor|Stated Value|Measured Value|Tolerance|Measured Tolerance|Is within?|")
    IO.puts("-|-|-|-|-|-|")

    [
      %{capacitor: "Large_green", stated: 680, measured: 667, tolerance: 1 / 100},
      %{capacitor: "Small_green", stated: 22, measured: 23.2, tolerance: 5 / 100},
      %{capacitor: "Blue", stated: 680, measured: 590, tolerance: 10 / 100},
      %{capacitor: "Yellow", stated: 100, measured: 103.6, tolerance: 2 / 100},
      %{capacitor: "Purple/white", stated: 220, measured: 217, tolerance: 1 / 100}
    ]
    |> Enum.map(&do_commercial_cap/1)
    |> Enum.map(&print_commercial_cap/1)
    |> Enum.join("\n")
    |> IO.puts()
  end

  @spec do_commercial_cap(%{
          capacitor: String.t(),
          stated: number(),
          measured: number(),
          tolerance: float()
        }) :: commerical_cap()
  defp do_commercial_cap(data) do
    return(
      data &&&
        %{
          reality: abs(data.stated - data.measured) / data.stated
        }
    )
  end

  @spec print_commercial_cap(commerical_cap()) :: String.t()
  defp print_commercial_cap(%{
         capacitor: name,
         stated: stated,
         measured: measured,
         tolerance: tolerance,
         reality: reality
       }) do
    return(
      "#{name}|#{stated}|#{measured}|#{tolerance * 100}|#{Float.round(reality * 100, 2)}|#{
        reality <= tolerance
      }|"
    )
  end

  @type variance_area :: %{
          pos: :full | :"3/4" | :"1/2" | :"1/4" | :"1/8",
          h: number(),
          u_h: number(),
          p_h: number(),
          w: number(),
          u_w: number(),
          p_w: number(),
          c: number()
        }

  @type second_area :: %{
          pos: :full | :"3/4" | :"1/2" | :"1/4" | :"1/8",
          area: number(),
          u_area: number(),
          p_area: number(),
          c: number(),
          u_c: number()
        }

  @doc """
  Variance in capacitance affected by area
  """
  @spec part_two() :: :ok
  def part_two() do
    res =
      [
        %{pos: :full, w: 230, h: 300, c: 7.6},
        %{pos: :full, w: 230, h: 300, c: 7.16},
        %{pos: :"3/4", w: 230, h: 235, c: 6.21},
        %{pos: :"3/4", w: 230, h: 250, c: 6.27},
        %{pos: :"1/2", w: 230, h: 160, c: 5.15},
        %{pos: :"1/2", w: 230, h: 165, c: 4.45},
        %{pos: :"1/4", w: 230, h: 110, c: 3.37},
        %{pos: :"1/4", w: 230, h: 95, c: 2.98},
        %{pos: :"1/8", w: 230, h: 75, c: 2.46},
        %{pos: :"1/8", w: 230, h: 60, c: 2.06}
      ]
      |> Enum.map(&to_variance_area/1)

    # Mark First table
    IO.puts("# Capacitance width and height")

    IO.puts(
      "Position | Height (m) | δheight (m) | %δheight | Width (m) | δwidth (m) | %δwidth | Capacitance (nF)"
    )

    IO.puts("-| -| -| -| -| -| -| -|")

    res
    |> Enum.map(&print_variance_area1/1)
    |> Enum.join("\n")
    |> IO.puts()

    # Mark Second table
    IO.puts("# Capacitance area")
    IO.puts("Position | Area (m2) | δArea (m2)| %δArea  | Capacitanceave (nF) | ± (nF)")
    IO.puts("-| -| -| -| -| -|")

    res
    |> Enum.map(&to_second_area/1)
    |> Enum.map(&print_second/1)
    |> Enum.join("\n")
    |> IO.puts()
  end

  @spec to_variance_area(%{pos: atom(), w: number(), h: number(), c: number()}) :: variance_area()
  defp to_variance_area(data) do
    return(
      data &&&
        %{
          u_h: 2,
          p_h: 2 / data.h,
          u_w: 2,
          p_w: 2 / data.w
        }
    )
  end

  @spec print_variance_area1(variance_area()) :: String.t()
  defp print_variance_area1(data) do
    return(
      "#{data.pos} A4|#{Float.round(data.h * 0.001, 3)}|#{Float.round(data.u_h * 0.001, 3)}|#{
        Float.round(data.p_h * 100, 2)
      } %|#{Float.round(data.w * 0.001, 3)}|#{Float.round(data.u_w * 0.001, 3)}|#{
        Float.round(data.p_w * 100, 2)
      }|#{data.c}"
    )
  end

  @spec to_second_area(variance_area()) :: second_area()
  defp to_second_area(data) do
    init = %{
      pos: data.pos,
      area: data.h * data.w,
      c: data.c,
      u_c: 0.01
    }

    return(
      init &&&
        %{
          u_area: init.area * (data.p_h + data.p_w),
          p_area: data.p_h + data.p_w
        }
    )
  end

  @spec print_second(second_area()) :: String.t()
  defp print_second(data) do
    return(
      "#{data.pos} A4|#{Float.round(data.area * 0.000001, 4)}|#{
        Float.round(data.u_area * 0.000001, 4)
      }|#{Float.round(data.p_area * 100, 2)}|#{data.c}|#{data.u_c}"
    )
  end

  @type variance_thick :: %{
          num: integer(),
          d: number(),
          over_d: number(),
          c1: number(),
          c2: number(),
          c_ave: number(),
          u_c: number()
        }

  @doc """
  Part 3: Variance in capacitance with depth and thickness
  """
  @spec part_three() :: :ok
  def part_three() do
    # Mark Second table
    IO.puts("# Capacitance thickness")

    IO.puts(
      "# of pages | Plate Separation d (m) | 1/d (m-1) | Measurement 1 | Measurement 2 | C_ave (nF) | ± C_ave (nF"
    )

    IO.puts("-| -| -| -| -| -| -|")

    [
      # of sheets C1 C2
      %{num: 2, c1: 5.37, c2: 5.17},
      %{num: 4, c1: 3.08, c2: 3.04},
      %{num: 8, c1: 1.65, c2: 1.66},
      %{num: 16, c1: 0.88, c2: 0.88},
      %{num: 24, c1: 0.59, c2: 0.59}
    ]
    |> Enum.map(&to_variance_thick/1)
    |> Enum.map(&print_think/1)
    |> Enum.join("\n")
    |> IO.puts()
  end

  @spec to_variance_thick(map()) :: variance_thick()
  defp to_variance_thick(data) do
    return(
      data &&&
        %{
          d: data.num * 110 * :math.pow(10, -6),
          over_d: :math.pow(10, 6) / (110 * data.num),
          c_ave: (data.c1 + data.c2) / 2,
          u_c: abs(data.c1 - data.c2) / 2
        }
    )
  end

  @spec print_think(variance_thick()) :: String.t()
  defp print_think(data) do
    return(
      "#{data.num}|#{Float.round(data.d, 6)}|#{Float.round(data.over_d, 2)}|#{data.c1}|#{data.c2}|#{
        Float.round(data.c_ave, 2)
      }|#{Float.round(data.u_c, 3)}"
    )
  end
end
