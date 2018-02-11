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

    if(options[:delete]) do
      {:ok, response} = options[:delete] |> Rest.delete
      Presenter.deletion_message(response, options[:delete])
    end

    if (options[:deleteAll] && options[:confirm]) do
      RepoList.get_data(100)
      |> Enum.map(& &1["name"])
      |> Enum.each(fn(repo) ->
        IO.puts "Do you want to delete this repo?: #{repo}"
        input = IO.gets "yes or no? "
        if(String.match?(input, ~r/yes|(y\n)/)) do
          {:ok, response} = Rest.delete(repo)
          Presenter.deletion_message(response, repo)
        else
          IO.puts "Ok, skipping repo #{repo}"
        end
      end)
    end

    if options[:totalCount] do
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
        totalCount: :boolean,
        delete: :string
      ]
    )
    options
  end
end
