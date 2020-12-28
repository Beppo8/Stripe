defmodule Teacher.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :email, :string
      add :stripe_customer_id, :string
      add :album_id, references(:albums, on_delete: :nothing)

      timestamps()
    end

    create index(:customers, [:album_id])
  end
end
