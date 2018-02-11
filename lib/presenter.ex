defmodule Presenter do
  @spacing "\n\t"

  def perform(data) when is_list(data) do
    data |> TableRex.quick_render! |> IO.puts
  end

  def perform(message) when is_binary(message) do
    message |> format |> IO.puts
  end

  def perform(number) when is_integer(number) do
    number |> Integer.to_string |> format |> IO.puts
  end

  def perform(_) do
    IO.puts "There was an error"
  end

  def deletion_message(response, repo) do
    if(response.status_code == 204) do
      IO.puts("\n")
      IO.puts("Repository #{repo} successfully destroyed!")
      IO.puts("You now have this many respositories remaining:")
      RepoList.perform(:total_count)
    else
      IO.puts("\n")
      IO.puts("Unable to destroy repo for the following reason:")
      IO.puts response.body
    end
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
