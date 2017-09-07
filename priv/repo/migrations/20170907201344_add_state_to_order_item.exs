defmodule PlateSlate.Repo.Migrations.AddStateToOrderItem do
  use Ecto.Migration

  def change do
    alter table(:order_items) do
      add :state, :string
    end
  end
end
