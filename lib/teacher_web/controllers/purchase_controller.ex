defmodule TeacherWeb.PurchaseController do
  use TeacherWeb, :controller

  alias Teacher.Repo
  alias Teacher.Records
  alias Teacher.Purchases.Customer
  alias Teacher.Purchases

  def receipt(conn, params) do
    customer = params["customer_id"]
      |> Purchases.get_customer!()
      |> Repo.preload(:album)
    album = customer.album
    render(conn, "receipt.html", customer: customer, album: album)
  end

  def create(conn, params) do
    album = Records.get_album!(params["album_id"])

    customer = params
      |> customer_changeset()
      |> Ecto.Changeset.put_assoc(:album, album)
      |> Ecto.Changeset.put_assoc(:ship_address, addr_changeset(params))
      |> Repo.insert!()

    case Purchases.charge_customer(customer, album.price) do
      {:ok, _charge} ->
        redirect(conn, to: Route.purchase_path(conn, :receipt, customer_id: customer.id))
      {:error, _msg} ->
        conn
        |> put_flash(:error, "We couldn´t charge your card")
        |> redirect(to: album_path(conn, :index))
    end
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
