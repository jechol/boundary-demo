defmodule Boundary.Factory do
  use ExMachina.Ecto, repo: Boundary.Repo

  def user_factory do
    %Boundary.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      active: true,
      paid_at: DateTime.utc_now() |> DateTime.add(-10, :day)
    }
  end
end
