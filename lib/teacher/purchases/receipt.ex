defmodule Teacher.Purchases.Receipt do
  defstruct [:id, :created_at, :amout, :email, :last_four, :card_type,
             :exp_month, :exp_year, :album]

  def build(attrs) do
    struct(__MOUDULE__,attrs)
  end


  def map_attrs(attrs) do
    album = attrs
            |> get_in([:metadata, "album_id"])
            |> get_album()
    %{
      id: attrs[:id],
      created_at: attrs[:created],
      amount: attrs[:amount],
      email: attrs[:receipt_email],
      last_four: get_in(attrs, [:source, "last4"]),
      card_type: get_in(attrs, [:source, "brand"]),
      exp_month: get_in(attrs, [:source, "exp_month"]),
      exp_year: get_in(attrs, [:source, "exp_year"]),
      album: album
    }
  end

  defp get_album(album_id) do
    Teacher.Records.get_album!(album_id)
  end

end
