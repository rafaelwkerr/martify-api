defmodule MartifyWeb.LeadControllerTest do
  use MartifyWeb.ConnCase

  alias Martify.Accounts
  alias Martify.Accounts.Lead

  @create_attrs %{
    email: "some email",
    name: "some name",
    phone: "some phone"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name",
    phone: "some updated phone"
  }
  @invalid_attrs %{email: nil, name: nil, phone: nil}

  def fixture(:lead) do
    {:ok, lead} = Accounts.create_lead(@create_attrs)
    lead
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all leads", %{conn: conn} do
      conn = get(conn, Routes.lead_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create lead" do
    test "renders lead when data is valid", %{conn: conn} do
      conn = post(conn, Routes.lead_path(conn, :create), lead: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.lead_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "name" => "some name",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.lead_path(conn, :create), lead: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update lead" do
    setup [:create_lead]

    test "renders lead when data is valid", %{conn: conn, lead: %Lead{id: id} = lead} do
      conn = put(conn, Routes.lead_path(conn, :update, lead), lead: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.lead_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "name" => "some updated name",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, lead: lead} do
      conn = put(conn, Routes.lead_path(conn, :update, lead), lead: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete lead" do
    setup [:create_lead]

    test "deletes chosen lead", %{conn: conn, lead: lead} do
      conn = delete(conn, Routes.lead_path(conn, :delete, lead))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.lead_path(conn, :show, lead))
      end
    end
  end

  defp create_lead(_) do
    lead = fixture(:lead)
    {:ok, lead: lead}
  end
end
