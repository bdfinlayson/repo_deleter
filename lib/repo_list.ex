defmodule RepoList do
  def perform(number) do
    if(number > 0 && number <= 100) do
      get_data(number)
      |> Presenter.perform
    else
      Presenter.perform("Can only show between 1 to 100 repos at a time")
    end
  end

  defp get_data(number) do
    %{query: "query { viewer { repositories(first:#{number}) { nodes { name }}}}"}
    |> Poison.encode!()
    |> GraphQl.post
    |> get_in(["data", "viewer", "repositories", "nodes"])
    |> process_result
  end

  defp process_result(data = [_|_]) do
    data |> Enum.map(& &1["name"])
  end
end
