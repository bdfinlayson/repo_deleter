defmodule RepoList do
  def perform(number) do
    get_data(number)
    |> Presenter.perform
  end

  defp get_data(number) do
    %{query: "query { viewer { repositories(first:#{number}) { nodes { name }}}}"}
    |> Poison.encode!()
    |> GraphQl.post
    |> get_in(["data", "viewer", "repositories", "nodes"])
    |> Enum.map(& &1["name"])
  end
end
