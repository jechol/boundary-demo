defmodule Sweeper do
  alias Boundary.{Repo, User, Mailer}

  def sweep do
    Repo.all(User)
    |> Enum.filter(fn %User{} = user ->
      one_month_ago = DateTime.utc_now() |> DateTime.add(-30, :day)

      user.active && DateTime.compare(user.paid_at, one_month_ago) == :lt
    end)
    |> Enum.map(fn %User{} = user ->
      Mailer.send_billing_reminder(user)
    end)
  end
end
