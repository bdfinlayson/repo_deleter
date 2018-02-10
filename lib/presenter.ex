defmodule Presenter do
  def perform(data = [_ | _]) do
    data
    |> Enum.sort
    |> List.insert_at(0, "")
    |> Enum.join("\n\t")
    |> IO.puts
  end

  def perform([]) do
    IO.puts "No data found"
  end
end
