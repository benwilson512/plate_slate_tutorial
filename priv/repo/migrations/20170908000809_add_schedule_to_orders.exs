defmodule PlateSlate.Repo.Migrations.AddScheduleToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :schedule, :string
    end
  end
end
