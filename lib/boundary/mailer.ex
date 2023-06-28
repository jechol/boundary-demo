defmodule Boundary.Mailer do
  alias Boundary.User

  def send_billing_reminder(%User{} = user) do
    # ...
    {:ok, :sent}
  end
end
