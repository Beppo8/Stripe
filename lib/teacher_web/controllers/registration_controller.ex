defmodule TeacherWeb.RegistrationController do
  use TeacherWeb, :controller

  alias Teacher.Accounts
  alias Teacher.Accounts.Customer

  def new(conn, _params) do
    changeset = Accounts.change_customer(%Customer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"customer" => customer_params}) do
    case Accounts.create_customer(customer_params) do
      {:ok, customer} ->
        conn
        |> put_session(:current_customer_id, customer.id)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: album_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
