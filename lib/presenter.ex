defmodule Presenter do
  @spacing "\n\t"

  def perform(data) when is_list(data) do
    data |> TableRex.quick_render! |> IO.puts
  end

  def perform(message) when is_binary(message) do
    message |> TableRex.quick_render! |> IO.puts
  end

  def perform(number) when is_integer(number) do
    number |> Integer.to_string |> format |> IO.puts
  end

  def perform(_) do
    IO.puts "There was an error"
  end

  defp format(data) when is_list(data) do
    data
    |> Enum.sort
    |> Enum.to_list
  end

  defp format(message) when is_binary(message) do
    @spacing <> message
  end
end
