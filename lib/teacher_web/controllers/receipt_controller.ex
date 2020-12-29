defmodule TeacherWeb.ReceiptController do
  use TeacherWeb, :controller

  alias Teacher.Purchases
  alias Teacher.Purchases.Receipt

  def index(conn, _params) do
    receipts = Purchases.list_receipts()
    render(conn, "index.html", receipts: receipts)
  end

  def show(conn, %{"id" => id}) do
    receipt = Purchases.get_receipt!(id)
    render(conn, "show.html", receipt: receipt)
  end

end
