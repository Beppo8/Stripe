defmodule Teacher.Purchases.Receipt do
  defstruct [:id, :created_at, :amout, :email, :last_four, :card_type,
             :exp_month, :exp_year, :album_id]

  def build(attrs) do
    struct(__MOUDULE__,attrs)
  end


  def map_attrs(attrs) do
    %{
      id: attrs[:id],
      created_at: attrs[:created],
      amount: attrs[:amount],
      email: attrs[:receipt_email],
      last_four: get_in(attrs, [:source, "last4"]),
      card_type: get_in(attrs, [:source, "brand"]),
      exp_month: get_in(attrs, [:source, "exp_month"]),
      exp_year: get_in(attrs, [:source, "exp_year"]),
      album_id: get_in(attrs, [:metadata, "album_id"])
    }
  end
end
