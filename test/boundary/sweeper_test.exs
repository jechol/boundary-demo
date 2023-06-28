defmodule Boundary.SweeperTest do
  use Boundary.DataCase, async: false

  alias Boundary.Factory
  alias Boundary.Mailer

  import Mock

  describe "sweep" do
    test "when user is active and paid_at is less than 30 days ago" do
      # setup
      Factory.insert(:user,
        active: true,
        paid_at: DateTime.utc_now() |> DateTime.add(-10, :day)
      )

      sent = make_ref()

      with_mock Mailer,
        send_billing_reminder: fn _user -> send(self(), sent) end do
        Sweeper.sweep()

        refute_receive ^sent
      end
    end

    test "when user is active and paid_at is more than 30 days ago" do
      # setup
      Factory.insert(:user,
        active: true,
        paid_at: DateTime.utc_now() |> DateTime.add(-31, :day)
      )

      sent = make_ref()

      with_mock Mailer,
        send_billing_reminder: fn _user -> send(self(), sent) end do
        Sweeper.sweep()

        assert_receive ^sent
      end
    end
  end
end
