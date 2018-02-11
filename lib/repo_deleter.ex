defmodule RepoDeleter do
  def main(args) do
    args |> parse_options |> process
  end

  def process(options) do
    if(options[:list]) do
      options[:list]
      |> String.to_integer
      |> RepoList.perform
    end

    if options[:totalcount] do
      RepoList.perform(:total_count)
    end
  end

  defp parse_options([]) do
    IO.puts "No arguments given"
  end

  defp parse_options(args) do
    {options, _, _} = OptionParser.parse(
      args,
      switches: [
        list: :string,
        totalcount: :boolean
      ]
    )
    options
  end
end
