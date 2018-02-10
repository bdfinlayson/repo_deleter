defmodule GraphQl do
  @url "https://api.github.com/graphql"

  def post(query) do
    case HTTPoison.post(@url, query, ["Authorization": "bearer #{auth_key()}"]) do
      {:ok, response} -> Poison.decode!(response.body)
      _ -> "There was an error with your request"
    end
  end

  defp auth_key do
    System.get_env("GITHUB_KEY")
  end
end
