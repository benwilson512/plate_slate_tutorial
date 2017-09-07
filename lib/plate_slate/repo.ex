defmodule PlateSlate.Repo do
  use Ecto.Repo, otp_app: :plate_slate

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def random(query) do
    import Ecto.Query
    query
    |> order_by([m], fragment("RANDOM()"))
    |> limit(1)
    |> one
  end
end
