defmodule RepoDeleter do
  @moduledoc """
  Documentation for RepoDeleter.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RepoDeleter.hello
      :world

  """
  def main(args) do
    args |> parse_options |> perform
  end

  defp parse_options([]) do
    IO.puts "No arguments given"
  end

  defp parse_options(args) do
    {options, _, _} = OptionParser.parse(
      args,
      switches: [
        password: :string,
        email: :string
      ]
    )
    options
  end

  defp perform(options) do
    IO.puts "Email is #{options[:email]} and Password is #{options[:password]}"
  end
end
