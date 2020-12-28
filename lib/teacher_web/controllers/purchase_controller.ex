defmodule TeacherWeb.PurchaseController do
  use TeacherWeb, :controller

  alias Teacher.Repo
  alias Teacher.Records
  alias Teacher.Purchases.Customer
  alias Teacher.Purchases

  def create(conn, params) do
    album = Records.get_album!(params["album_id"])

    customer = params
      |> customer_changeset()
      |> Ecto.Changeset.put_assoc(:album, album)
      |> Ecto.Changeset.put_assoc(:ship_address, addr_changeset(params))
      |> Repo.insert!()
  end

  defp addr_changeset(attrs) do
    address_attrs = %{
      city: attrs["stripeShippingAddressCity"],
      country: attrs["stripeShippingAddressCountry"],
      line: attrs["stripeShippingAddressLine1"],
      name: attrs["stripeShippingName"],
      state: attrs["stripeShippingAddressState"],
      zip: attrs["stripeShippingAddressZip"]
    }

    Address.changeset(%Address{}, address_attrs)
  end

  defp customer_changeset(attrs) do
    customer_attrs = %{
      "email" => attrs["stripeEmail"],
      "stripe_customer_id" => Purchases.create_stripe_customer(attrs["stripeEmail"],
                                                               attrs["stripeToken"])
    }
    Customer.changeset(%Customer{}, customer_attrs)
  end

end
