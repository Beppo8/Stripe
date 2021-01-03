defmodule TeacherWeb.ReceiptView do
  use TeacherWeb, :view

  def format_date!(timestamp) do
    timestamp
    |> DateTime.from_unix!()
    |> DateTime.to_date()
    |> Date.to_string()
  end

end
