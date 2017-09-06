defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import Ecto.Query
  alias PlateSlate.{Menu, Repo}

  query do
    field :menu_items, list_of(:menu_item) do
      arg :matching, :string

      resolve fn
        _, %{matching: term}, _ ->
          items =
            Menu.Item
            |> where([i], ilike(i.name, ^"%#{term}%"))
            |> Repo.all
          {:ok, items}

        _, _, _ ->
          items =
            Menu.Item
            |> Repo.all
          {:ok, items}
      end
    end
  end

  @desc """
  Tasty thing to eat!
  """
  object :menu_item do
    field :id, :id
    @desc "The name of the item"
    field :name, :string
    field :description, :string
    field :price, :float
  end
end
