defmodule Worte.Worterbuch do
  @moduledoc """
  Documentation for Worterbuch.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Worterbuch.hello()
      :world

  """
  def find_defined_words(word) do
    Worte.Store.find("^#{word} {")
    |> Enum.map(fn match ->
      String.split(match, "{", trim: true) |> List.first()
    end) || []
  end

  def find_definition(word) do
    Worte.Store.find("^#{word} ")
    |> Enum.map(&split_match/1)
  end

  def find(word) do
    run(word)
  end

  def run(word) do
    Worte.Store.find(word)
    |> format_matches
  end

  def format_matches(matches) do
    Enum.map(matches, &format_match/1)
    # |> Enum.join("\n")
  end

  def split_match(match) do
    [ger, eng] = String.split(match, "\s::\s", trim: true)
    ger_items = String.split(ger, "\s|\s", trim: true)
    eng_items = String.split(eng, "\s|\s", trim: true)

    Enum.zip(ger_items, eng_items)
  end

  def format_match(match) do
    [ger, eng] = String.split(match, "\s::\s", trim: true)
    ger_items = String.split(ger, "\s|\s", trim: true)
    eng_items = String.split(eng, "\s|\s", trim: true)

    [head | rest_of_them] = Enum.zip(ger_items, eng_items)

    rest_lines = Enum.map(rest_of_them, fn pair -> "  " <> format_pair(pair) end)

    [format_pair(head) | rest_lines]
    # |> Enum.join("\n")
  end

  def format_pair({g, e}), do: "#{g} – #{e}"
end
