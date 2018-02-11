defmodule Rest do
  def delete(repo_name) do
    HTTPoison.delete(build_url(repo_name), ["Authorization": "bearer #{auth_key()}"])
  end

  defp auth_key do
    GraphQl.auth_key()
  end

  defp build_url(repo) do
    "https://api.github.com/repos/" <> System.get_env("GITHUB_USERNAME") <> "/" <> repo
  end
end
