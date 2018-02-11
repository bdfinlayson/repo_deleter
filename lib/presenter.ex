defmodule Presenter do
  @spacing "\n\t"

  def perform(data) when is_list(data) do
    data |> format |> IO.puts
  end

  def perform(message) when is_binary(message) do
    message |> format |> IO.puts
  end

  def perform(_) do
    IO.puts "There was an error"
  end

  defp format(data) when is_list(data) do
    data
    |> Enum.sort
    |> List.insert_at(0, "")
    |> Enum.join(@spacing)
  end

  defp format(message) when is_binary(message) do
    @spacing <> message
  end
end
