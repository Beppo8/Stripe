defmodule TeacherWeb.SessionController do
  use TeacherWeb, :controller

  alias Teacher.Accounts

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => auth_params}) do
    customer = Accounts.customer_by_username(auth_params["username"])
    case Comeonin.Bcrypt.check_pass(customer, auth_params["password"]) do
      {:ok, customer} ->
        conn
        |> put_session(:current_customer_id, customer.id)
        |> put_flash(:info, "Signed in successfully")
        |> redirect(to: album_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "There was a problem with your username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_customer_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: album_path(conn, :index))
  end

end
