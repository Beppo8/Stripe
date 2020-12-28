defmodule Teacher.Purchases.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Purchases.Customer


  schema "customers" do
    field :email, :string
    field :stripe_customer_id, :string
    belongs_to :album, Teacher.Records.Album
    has_one :ship_address, Teacher.Purchases.Address

    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:email, :stripe_customer_id])
    |> validate_required([:email, :stripe_customer_id])
  end
end
