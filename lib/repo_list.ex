defmodule RepoList do
  def perform(number) when is_integer(number) do
    if(number > 0 && number <= 100) do
      get_data(number)
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

  defp get_data(number) when is_integer(number) do
    number
    |> respositories_query
    |> post
    |> get_in(["data", "viewer", "repositories", "nodes"])
    |> process_result
  end

  defp get_data(command) when is_atom(command) do
    case command do
      :total_count ->
        total_count_query
        |> post
        |> get_in(["data", "viewer", "repositories", "totalCount"])
    end
  end

  defp respositories_query(number) do
    "repositories(first:#{number}) { nodes { name }}"
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
    data |> Enum.map(& &1["name"])
  end
end
