defmodule PlateSlate.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :price, :decimal
      add :quantity, :integer
      add :order_id, references(:orders, on_delete: :nothing)
      add :menu_item_id, references(:items, on_delete: :nothing)

      timestamps()
    end

    create index(:order_items, [:order_id])
    create index(:order_items, [:menu_item_id])
  end
end
