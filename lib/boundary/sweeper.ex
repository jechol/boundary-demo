defmodule Sweeper do
  alias Boundary.{Repo, User, Mailer}

  def sweep do
    Repo.all(User)
    |> Enum.filter(fn user ->
      User.Pure.should_send_billing_reminder?(user, DateTime.utc_now())
    end)
    |> Enum.map(fn %User{} = user ->
      Mailer.send_billing_reminder(user)
    end)
  end
end
