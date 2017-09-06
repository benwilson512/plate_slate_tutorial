defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.MenuTypes
  import_types __MODULE__.OrderingTypes
  import_types Absinthe.Type.Custom

  alias PlateSlateWeb.Resolvers

  query do
    field :menu_items, list_of(:menu_item) do
      arg :filter, :menu_items_filter
      arg :order, :sort_order, default_value: :asc
      resolve &Resolvers.Menu.menu_items/3
    end
  end

  mutation do
    field :place_order, :order do

    end
  end

  enum :sort_order do
    value :asc
    value :desc
  end

  # scalar :decimal do
  #   parse fn
  #     %{value: value}, _ ->
  #       Decimal.parse(value)
  #     _, _ ->
  #       :error
  #   end
  #   serialize &to_string/1
  # end
end
