defmodule Boundary.User.PureTest do
  use Boundary.DataCase, async: false

  alias Boundary.User
  alias Boundary.User.Pure

  test "should_send_billing_reminder?" do
    user = %User{
      active: true,
      paid_at: ~U[2021-01-01T00:00:00+00]
    }

    now = ~U[2021-02-10T00:00:00+00]

    assert Pure.should_send_billing_reminder?(user, now)

    refute Pure.should_send_billing_reminder?(%User{user | active: false}, now)

    refute Pure.should_send_billing_reminder?(
             %User{user | paid_at: ~U[2021-01-10T00:00:00+00]},
             now
           )
  end
end
