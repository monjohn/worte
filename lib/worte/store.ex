defmodule Worte.Store do
  use Agent

  def start_link(_opts) do
    dict = load_dictionary()
    Agent.start_link(fn -> dict end, name: __MODULE__)
  end

  def ensure_dictionary_loaded do
    if Process.whereis(__MODULE__) == nil do
      start_link([])
    end
  end

  def find(""), do: []

  def find(word) do
    ensure_dictionary_loaded()
    {:ok, re} = Regex.compile(word)

    Agent.get(__MODULE__, fn dict ->
      Enum.filter(dict, fn line ->
        Regex.match?(re, line)
      end)
    end)
  end

  def load_dictionary do
    "assets/data/de-en.txt"
    |> File.read!()
    |> String.split("\n")
  end
end
