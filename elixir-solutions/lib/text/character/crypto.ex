#
#  crypto.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 17:31.
#

defmodule Character.Crypto do
  @moduledoc """
   Character cryptography
  """

  @doc """
  From integer to string
  """
  @spec int_from_string(String.t()) :: [non_neg_integer()]
  def int_from_string(str) do
    str
    |> String.downcase()
    |> String.graphemes()
    |> Enum.map(fn g ->
      <<no::utf8>> = g
      no
    end)
    |> Enum.map(&(&1 - 97))
    |> Enum.map(&div(&1, 1))
  end

  @doc """
  Vigenere cipher
  """
  @spec vigenere(String.t(), String.t()) :: String.t()
  def vigenere(plaintext, key) do
    plainnums =
      plaintext
      |> int_from_string()

    key_nums =
      key
      |> extend_key(String.length(plaintext))
      |> int_from_string()

    do_vigenere(plainnums, key_nums)
  end

  @spec do_vigenere([non_neg_integer()], [non_neg_integer()]) :: String.t()
  defp do_vigenere([], []), do: ""

  defp do_vigenere([p1 | p_remains], [k1 | k_remains]) do
    x = rem(p1 + k1, 26) + 97
    char = <<x::utf8>>
    char <> do_vigenere(p_remains, k_remains)
  end

  @spec extend_key(String.t(), non_neg_integer()) :: String.t()
  defp extend_key(key, len) do
    if String.length(key) > len do
      key |> String.slice(0, len)
    else
      extend_key(key <> key, len)
    end
  end

  @doc """
  Vigenere decipher
  """
  @spec de_vigenere(String.t(), String.t()) :: String.t()
  def de_vigenere(plaintext, key) do
    plainnums =
      plaintext
      |> int_from_string()

    key_nums =
      key
      |> extend_key(String.length(plaintext))
      |> int_from_string()

    do_de_vigenere(plainnums, key_nums)
  end

  @spec do_de_vigenere([non_neg_integer()], [non_neg_integer()]) :: String.t()
  defp do_de_vigenere([], []), do: ""

  defp do_de_vigenere([p1 | p_remains], [k1 | k_remains]) do
    x = p1 - k1 + if(p1 < k1, do: 26, else: 0) + 97
    char = <<x::utf8>>
    char <> do_de_vigenere(p_remains, k_remains)
  end
end
