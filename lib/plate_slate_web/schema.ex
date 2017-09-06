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

    field :orders, list_of(:order) do
      resolve fn _, _, _ ->
        {:ok, PlateSlate.Repo.all(PlateSlate.Ordering.Order)}
      end
    end
  end

  mutation do
    field :place_order, :order do
      arg :items, non_null(list_of(non_null(:place_order_input)))
      arg :customer_number, non_null(:integer)
      resolve &Resolvers.Ordering.place_order/3
    end
  end

  subscription do
    field :order_placed, :order do
      config fn _, _ ->
        {:ok, topic: "*"}
      end
      resolve fn parent, _, _ ->
        parent |> IO.inspect
        {:ok, parent}
      end
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
