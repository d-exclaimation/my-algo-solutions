#
#  marking_scheme.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 12:01.
#

defmodule MarkingScheme do
  @moduledoc """
  Marking Scheme utilities function
  """

  @type marking :: %{
          grade: atom(),
          gpa: integer(),
          score: non_neg_integer()
        }

  @doc """
  Grade, GPA, and Score based on a score
  """
  @spec mark(non_neg_integer()) :: marking()
  def mark(score) do
    without_score =
      cond do
        90 <= score and score <= 100 ->
          %{
            grade: :a_plus,
            gpa: 9
          }

        85 <= score and score < 90 ->
          %{
            grade: :a,
            gpa: 8
          }

        80 <= score and score < 85 ->
          %{
            grade: :a_minus,
            gpa: 7
          }

        75 <= score and score < 80 ->
          %{
            grade: :b_plus,
            gpa: 6
          }

        70 <= score and score < 75 ->
          %{
            grade: :b,
            gpa: 5
          }

        65 <= score and score < 70 ->
          %{
            grade: :b_minus,
            gpa: 4
          }

        60 <= score and score < 65 ->
          %{
            grade: :c_plus,
            gpa: 3
          }

        55 <= score and score < 60 ->
          %{
            grade: :c,
            gpa: 2
          }

        50 <= score and score < 55 ->
          %{
            grade: :c_minus,
            gpa: 1
          }

        40 <= score and score < 50 ->
          %{
            grade: :d,
            gpa: 0
          }

        true ->
          %{
            grade: :e,
            gpa: -1
          }
      end

    Map.merge(without_score, %{score: score})
  end

  @doc """
  Grade from A+ to E given a score
  """
  @spec grade(non_neg_integer()) :: atom()
  def grade(score) do
    %{grade: grade} = mark(score)
    grade
  end

  @doc """
  GPA from 9 to -1 given a score
  """
  @spec gpa(non_neg_integer()) :: integer()
  def gpa(score) do
    %{gpa: gpa} = mark(score)
    gpa
  end
end
