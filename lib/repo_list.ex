defmodule RepoList do
  @fields ["id", "name", "updatedAt"]

  def perform(number) when is_integer(number) do
    if(number > 0 && number <= 100) do
      get_data(number)
      |> process_result
      |> Presenter.perform
    else
      Presenter.perform("Can only show between 1 to 100 repos at a time")
    end
  end

  def perform(command) when is_atom(command) do
    case command do
      :total_count ->
        get_data(command)
        |> Presenter.perform
      _ -> Presenter.perform("Command #{command} not recognized")
    end
  end

  def get_data(number) when is_integer(number) do
    number
    |> respositories_query
    |> post
    |> get_in(["data", "viewer", "repositories", "nodes"])
  end

  def get_data(command) when is_atom(command) do
    case command do
      :total_count ->
        total_count_query
        |> post
        |> get_in(["data", "viewer", "repositories"])
        |> Map.to_list
        |> Enum.map(fn(tuple) ->
          Tuple.to_list(tuple)
        end)
    end
  end

  defp respositories_query(number) do
    "repositories(first:#{number}) { nodes { #{Enum.join(@fields, " ")} }}"
    |> base_query
  end

  defp total_count_query do
    "repositories { totalCount }"
    |> base_query
  end

  defp base_query(sub_query) do
    %{query: "query { viewer { #{sub_query} }}"}
  end

  defp post(query) do
    query
    |> Poison.encode!()
    |> GraphQl.post
  end

  defp process_result(data) when is_list(data) do
    data
    |> Enum.map(fn(repo_info) ->
      {:ok, date, 0} = DateTime.from_iso8601(repo_info["updatedAt"])
      Map.values(repo_info)
      |> List.replace_at(2, "#{date.year}-#{date.month}-#{date.day}")
    end)
    |> List.insert_at(0, @fields)
  end
end
