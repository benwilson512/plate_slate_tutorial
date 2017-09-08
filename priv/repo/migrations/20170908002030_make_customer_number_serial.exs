defmodule PlateSlate.Repo.Migrations.MakeCustomerNumberSerial do
  use Ecto.Migration

  def up do
    alter table(:orders) do
      remove :customer_number
    end
    alter table(:orders) do
      add :customer_number, :bigserial
    end
  end
end
