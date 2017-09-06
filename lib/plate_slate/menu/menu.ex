defmodule PlateSlate.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false
  alias PlateSlate.Repo

  alias PlateSlate.Menu.Item

  def list_items(%{matching: term}) do
    items =
      Item
      |> where([i], ilike(i.name, ^"%#{term}%"))
      |> Repo.all
    {:ok, items}
  end
  def list_items(_) do
    items =
      Item
      |> Repo.all
    {:ok, items}
  end

end
