defmodule TeacherWeb.CustomerController do
  use TeacherWeb, :controller
  alias Teacher.Accounts

  def show(conn, %{"id" => id}) do
    customer = Accounts.get_customer(id)
    render conn, "show.html", customer: customer
  end

end
