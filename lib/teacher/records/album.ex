defmodule Teacher.Records.Album do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Records.Album


  schema "albums" do
    field :artist, :string
    field :summary, :string
    field :title, :string
    field :year, :string
    field :price, :integer
    has_many :customers, Teacher.Purchases.Customer

    timestamps()
  end

  @doc false
  def changeset(%Album{} = album, attrs) do
    album
    |> cast(attrs, [:title, :summary, :year, :genre, :price])
    |> validate_required([:title, :summary, :year, :genre, :price])
  end
end
