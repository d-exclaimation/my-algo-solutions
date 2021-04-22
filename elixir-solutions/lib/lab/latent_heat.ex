#
#  LatentHeat.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 2:57 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule LatentHeat do
  @moduledoc """
  This is not DSA question, I want to calculate data from a lab I have lol
  Probably should use like python or something else like Go / Rust for the raw speed
  However, I want to challenge myself to learn Elixir and Functional Programming, thus here we are
  """
  defmacro end_with(val), do: val

  @doc """
  Given the data, calculate the specific heat of the metal
  -> data: %{m_cal: float, m_pb: float, t_init: float, t_final: float, m_total: float}
  """
  def part_one() do
    data = %{
      m_cal: {196.85, 0.05},
      m_pb: {227.57, 0.05},
      t_init: {20.5, 0.1},
      t_final: {23.7, 0.1},
      m_total: {582.95, 0.5},
    }
    result = specific_heat(data)
    uncertain = uncertain_s_h(data, result)
    IO.puts("Given the data specific heat for pb is (#{result.c_pd} + #{uncertain}) J / g C")
  end

  # Specific heat
  defp specific_heat(%{
    m_cal: {m_cal, _},
    m_pb: {m_pb, _},
    t_init: {t_init, _},
    t_final: {t_final, _},
    m_total: {m_total, _},
  }) do
    m_w = m_total - m_cal - m_pb
    c_w = 4.18_6
    end_with %{
      m_w: m_w,
      # (mass_water * c_water * diff(temp)) / (mass_lead * diff(temp_lead))
      c_pd: (m_w * c_w * abs(t_init - t_final)) / (m_pb * abs(100 - t_final))
    }
  end
  defp uncertain_s_h(%{
    m_cal: {_, u_m_cal},
    m_pb: {m_pb, u_m_pb},
    t_init: {t_init, u_t_init},
    t_final: {t_final, u_t_final},
    m_total: {_, u_m_total},
  }, %{m_w: m_w, c_pd: c_pd}) do
    # %δ(mass_water) = (δ(mass_tot) + δ(mass_lead) + δ(mass_cal)) / mass_water
    p_m_w = (u_m_total + u_m_pb + u_m_cal) / m_w
    # %δ(temp_water) = (δ(temp_init) + δ(temp_final)) / temp_water
    p_t_w = (u_t_init + u_t_final) / abs(t_init - t_final)
    # %δ(mass_lead) = δ(mass_lead) / mass_lead
    p_m_pb = u_m_pb / m_pb
    # %δ(temp_lead) = δ(temp_final) / temp_lead
    p_t_pb = (u_t_final) / abs(100 - t_final)

    # δ(c_lead) = (%δ(mass_lead) + %δ(mass_water) + %δ(temp_lead) + %&(temp_water)) * c_lead
    end_with c_pd * (p_m_pb + p_m_w + p_t_pb + p_t_w)
  end


  @doc """
  Given the data, calculate the latent fusion heat of the system
  -> data: %{m_cal: float, m_cw: float, t_room: float, t_init: float, t_final: float, m_final: float}
  """
  def part_two() do
    data = %{
      m_cal: {196.85, 0.05},
      m_cw: {407.13, 0.05},
      t_init: {31.7, 0.1},
      t_final: {10.1, 0.1},
      m_final: {461.32, 0.05},
    }
    res = latent_fusion(data)
    uncertain = uncertain_fusion(data, res)
    IO.puts("Given the data latent fusion of water is (#{res.l_fus} + #{uncertain}) J / g")
  end

  defp latent_fusion(%{
    m_cal: {m_cal, _},
    m_cw: {m_cw, _},
    t_init: {t_init, _},
    t_final: {t_final, _},
    m_final: {m_final, _},
  }) do
    # mass_water = mass_system - mass_cal
    m_w = m_cw - m_cal
    # mass_ice = mass_final - mass_system
    m_ice = m_final - m_cw
    c_w = 4.186
    # q_without = mass_water * c_water * diff(temp_water)
    eq_before = m_w * c_w * abs(t_init - t_final)
    # q_after = mass_ice * c_water * diff(temp_after)
    eq_final = m_ice * c_w * abs(t_final - 0)
    end_with %{
      m_w: m_w,
      m_ice: m_ice,
      eq_before: eq_before,
      eq_final: eq_final,
      # latent_fus = (q_without - q_after) / mass_ice
      l_fus: (eq_before - eq_final) / m_ice
    }
  end
  defp uncertain_fusion(%{
    m_cal: {_, u_m_cal},
    m_cw: {_, u_m_cw},
    t_init: {t_init, u_t_init},
    t_final: {t_final, u_t_final},
    m_final: {_, u_m_final},
  }, %{
    m_w: mw,
    m_ice: m_ice,
    eq_before: eq_before,
    eq_final: eq_final,
    l_fus: l_fus
  }) do
    # (((%δ * og) + (%δ * og) / og) + (%δ)) * og
    # %δ(mass_water) = (δ(mass_system) + δ(mass_cal)) / mass_water
    p_mw = (u_m_cw + u_m_cal) / mw
    # %δ(mass_ice) = (δ(mass_final) + δ(mass_system)) / mass_ice
    p_m_ice = (u_m_final + u_m_cw) / m_ice
    # %δ(temp_water) = (δ(temp_init) + δ(temp_final)) / diff(temp_water)
    p_tw = (u_t_init + u_t_final) / abs(t_init - t_final)
    # %δ(temp_ice) = δ(temp_final) / temp_final
    p_t_ice = u_t_final / t_final
    # δ(q_before) = (%δ(mass_water) + %δ(temp_water)) / q_before
    u_before = (p_mw * p_tw) * eq_before
    # δ(q_after) = (%δ(mass_ice) + %δ(temp_ice)) / q_after
    u_after = (p_m_ice * p_t_ice) / eq_final
    # %δ(q_changes) = (δ(q_before) + δ(q_after)) / (q_before - q_after)
    p_eq = (u_before + u_after) / (eq_before - eq_final)
    # δ(latent_fus) = latent_fus * (%δ(q_change) + %δ(mass_ice))
    end_with l_fus * (p_m_ice + p_eq)
  end

  @doc """
  Given the data, calculate the latent vapor heat of the system
  -> data: %{m_cal: float, m_cw: float, t_room: float, t_init: float, t_final: float, m_final: float}
  """
  def part_three() do
    data = %{
      m_cal: {196.85, 0.05},
      m_cw: {461.32, 0.05},
      t_init: {11.7, 0.1},
      t_final: {36.3, 0.1},
      m_final: {474.35, 0.05},
    }
    res = latent_vapor(data)
    uncertain = uncertain_vapor(data, res)
    IO.puts("Given the data latent vapor of water is (#{res.l_vap} + #{uncertain}) J / g")
  end

  defp latent_vapor(%{
    m_cal: {m_cal, _},
    m_cw: {m_cw, _},
    t_init: {t_init, _},
    t_final: {t_final, _},
    m_final: {m_final, _},
  }) do
    # mass_water = mass_system - mass_cal
    m_w = m_cw - m_cal
    # mass_steam = mass_final - mass_system
    m_steam = m_final - m_cw
    c_w = 4.186
    # q_without = mass_water * c_water * diff(temp_water)
    eq_before = m_w * c_w * abs(t_init - t_final)
    # q_after = mass_steam * c_water * diff(temp_after)
    eq_final = m_steam * c_w * abs(t_final - 100)
    end_with %{
      m_w: m_w,
      m_steam: m_steam,
      eq_before: eq_before,
      eq_final: eq_final,
      # latent_fus = (q_without - q_after) / mass_steam
      l_vap: (eq_before - eq_final) / m_steam
    }
  end
  defp uncertain_vapor(%{
    m_cal: {_, u_m_cal},
    m_cw: {_, u_m_cw},
    t_init: {t_init, u_t_init},
    t_final: {t_final, u_t_final},
    m_final: {_, u_m_final},
  }, %{
    m_w: mw,
    m_steam: m_steam,
    eq_before: eq_before,
    eq_final: eq_final,
    l_vap: l_vap
  }) do
    # (((%δ * og) + (%δ * og) / og) + (%δ)) * og
    # %δ(mass_water) = (δ(mass_system) + δ(mass_cal)) / mass_water
    p_mw = (u_m_cw + u_m_cal) / mw
    # %δ(mass_steam) = (δ(mass_final) + δ(mass_system)) / mass_steam
    p_m_steam = (u_m_final + u_m_cw) / m_steam
    # %δ(temp_water) = (δ(temp_init) + δ(temp_final)) / diff(temp_water)
    p_tw = (u_t_init + u_t_final) / abs(t_init - t_final)
    # %δ(temp_steam) = δ(temp_final) / temp_final
    p_t_ice = u_t_final / t_final
    # δ(q_before) = (%δ(mass_water) + %δ(temp_water)) / q_before
    u_before = (p_mw * p_tw) * eq_before
    # δ(q_after) = (%δ(mass_steam) + %δ(temp_steam)) / q_after
    u_after = (p_m_steam * p_t_ice) / eq_final
    # %δ(q_changes) = (δ(q_before) + δ(q_after)) / (q_before - q_after)
    p_eq = (u_before + u_after) / (eq_before - eq_final)
    # δ(latent_fus) = latent_fus * (%δ(q_change) + %δ(mass_ice))
    end_with l_vap * (p_m_steam + p_eq)
  end
end
