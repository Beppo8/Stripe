defmodule Teacher.Plugs.SetAuth  do
  import Plug.Conn

  alias Teacher.Accounts

  def init(_args) do
  end

  def call(conn, _args) do
    customer_id = get_session(conn, :current_customer_id)
    if customer = customer_id && Accounts.get_customer(customer_id) do
      assign(conn, :current_customer, customer)
    else
      conn
    end
  end
end
