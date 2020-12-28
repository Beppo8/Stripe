defmodule Teacher.Purchases.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Purchases.Address


  schema "addresses" do
    field :city, :string
    field :country, :string
    field :line, :string
    field :name, :string
    field :state, :string
    field :zip, :string
    #field :customer_id, :id
    belongs_to :customer, Teacher.Purchases.Customer

    timestamps()
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:name, :line, :city, :state, :zip, :country])
    |> validate_required([:name, :line, :city, :state, :zip, :country])
  end
end
