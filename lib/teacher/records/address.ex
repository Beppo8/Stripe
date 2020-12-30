defmodule Teacher.Records.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Records.Address

  schema "addresses" do
    field :city, :string
    field :country, :string
    field :line, :string
    field :name, :string
    field :state, :string
    field :zip, :string
    belongs_to :album, Teacher.Records.Album

    timestamps()
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:name, :line, :city, :state, :zip, :country])
    |> validate_required([:name, :line, :city, :state, :zip, :country])
  end

  def map_attrs(attrs) do
    %{
      city: attrs["stripeShippingAddressCity"],
      country: attrs["stripeShippingAddressCountry"],
      line: attrs["stripeShippingAddressLine1"],
      name: attrs["stripeShippingName"],
      state: attrs["stripeShippingAddressState"],
      zip: attrs["stripeShippingAddressZip"]
    }
  end
end
