defmodule TeacherWeb.PurchaseController do
  use TeacherWeb, :controller

  alias Teacher.Repo
  alias Teacher.Records
  alias Teacher.Purchases.Customer

  def create(conn, params) do
    album = Records.get_album!(params["album_id"])
  end

  # defp customer_changeset(attrs) do
  #   customer_attrs = %{
  #     "email" => attrs["stripeEmail"],
  #     "stripe_customer_id" => #fetch stripe id
  #   }
  #   Customer.changeset(%Customer{}, customer_attrs)
  # end

end
