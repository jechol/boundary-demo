defmodule Boundary.User.PureTest do
  use Boundary.DataCase, async: false

  alias Boundary.User
  alias Boundary.User.Pure

  describe "should_send_billing_reminder?" do
    test "when user is active and paid_at is less than 30 days ago" do
      refute Pure.should_send_billing_reminder?(
               %User{
                 active: true,
                 paid_at: ~U[2021-01-01T00:00:00+00]
               },
               ~U[2021-01-20T00:00:00+00]
             )
    end

    test "when user is active and paid_at is more than 30 days ago" do
      assert Pure.should_send_billing_reminder?(
               %User{
                 active: true,
                 paid_at: ~U[2021-01-01T00:00:00+00]
               },
               ~U[2021-02-01T00:00:00+00]
             )
    end

    test "when paid_at is more than 30 days ago but user is  inactive" do
      refute Pure.should_send_billing_reminder?(
               %User{
                 active: false,
                 paid_at: ~U[2021-01-01T00:00:00+00]
               },
               ~U[2021-02-01T00:00:00+00]
             )
    end
  end
end
