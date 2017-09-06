defmodule PlateSlate.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :description, :string
      add :price, :decimal
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:items, [:category_id])
  end
end
