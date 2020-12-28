defmodule Teacher.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Accounts.Customer

  schema "customers" do
    field :email, :string
    field :stripe_customer_id, :string
    field :encrypted_password, :string
    has_many :albums, Teacher.Records.Album

    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:email, :stripe_customer_id, :encrypted_password])
    |> unique_constraint(:email)
    |> validate_required([:email, :encrypted_password])
    |> update_change(:encrypted_password, &Bcrypt.hash_pwd_salt/1)
  end
end
