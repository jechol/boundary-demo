defmodule Boundary.Mailer do
  alias Boundary.User
  require Logger

  def send_billing_reminder(%User{} = user) do
    # ...
    Logger.debug("Sending billing reminder to #{user.email}")
    {:ok, :sent}
  end
end
