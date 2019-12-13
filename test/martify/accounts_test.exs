defmodule Martify.AccountsTest do
  use Martify.DataCase

  alias Martify.Accounts

  describe "leads" do
    alias Martify.Accounts.Lead

    @valid_attrs %{email: "some email", name: "some name", phone: "some phone"}
    @update_attrs %{email: "some updated email", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{email: nil, name: nil, phone: nil}

    def lead_fixture(attrs \\ %{}) do
      {:ok, lead} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_lead()

      lead
    end

    test "list_leads/0 returns all leads" do
      lead = lead_fixture()
      assert Accounts.list_leads() == [lead]
    end

    test "get_lead!/1 returns the lead with given id" do
      lead = lead_fixture()
      assert Accounts.get_lead!(lead.id) == lead
    end

    test "create_lead/1 with valid data creates a lead" do
      assert {:ok, %Lead{} = lead} = Accounts.create_lead(@valid_attrs)
      assert lead.email == "some email"
      assert lead.name == "some name"
      assert lead.phone == "some phone"
    end

    test "create_lead/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_lead(@invalid_attrs)
    end

    test "update_lead/2 with valid data updates the lead" do
      lead = lead_fixture()
      assert {:ok, %Lead{} = lead} = Accounts.update_lead(lead, @update_attrs)
      assert lead.email == "some updated email"
      assert lead.name == "some updated name"
      assert lead.phone == "some updated phone"
    end

    test "update_lead/2 with invalid data returns error changeset" do
      lead = lead_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_lead(lead, @invalid_attrs)
      assert lead == Accounts.get_lead!(lead.id)
    end

    test "delete_lead/1 deletes the lead" do
      lead = lead_fixture()
      assert {:ok, %Lead{}} = Accounts.delete_lead(lead)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_lead!(lead.id) end
    end

    test "change_lead/1 returns a lead changeset" do
      lead = lead_fixture()
      assert %Ecto.Changeset{} = Accounts.change_lead(lead)
    end
  end
end
