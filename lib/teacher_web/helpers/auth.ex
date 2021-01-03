defmodule TeacherWeb.Helpers.Auth do

  def signed_in?(conn) do
    conn.assigns[:current_customer]
  end

end
