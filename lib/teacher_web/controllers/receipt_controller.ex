defmodule TeacherWeb.ReceiptController do
  use TeacherWeb, :controller

  alias Teacher.Purchases
  alias Teacher.Purchases.Receipt

  def index(conn, _params) do
    customer = conn.assigns[:current_customer]
    sold_albums = Purchases.list_albums!(customer)
    render(conn, "index.html", sold_albums: sold_albums)
  end

  def show(conn, %{"id" => id}) do
    receipt = Purchases.get_receipt!(id)
    render(conn, "show.html", receipt: receipt)
  end

end
