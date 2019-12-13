defmodule MartifyWeb.LeadController do
  use MartifyWeb, :controller

  alias Martify.Accounts
  alias Martify.Accounts.Lead

  action_fallback MartifyWeb.FallbackController

  def index(conn, _params) do
    leads = Accounts.list_leads()
    render(conn, "index.json", leads: leads)
  end

  def create(conn, lead_params) do
    with {:ok, %Lead{} = lead} <- Accounts.create_lead(lead_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.lead_path(conn, :show, lead))
      |> render("show.json", lead: lead)
    end
  end

  def show(conn, %{"id" => id}) do
    lead = Accounts.get_lead!(id)
    render(conn, "show.json", lead: lead)
  end

  def update(conn, %{"id" => id, "lead" => lead_params}) do
    lead = Accounts.get_lead!(id)

    with {:ok, %Lead{} = lead} <- Accounts.update_lead(lead, lead_params) do
      render(conn, "show.json", lead: lead)
    end
  end

  def delete(conn, %{"id" => id}) do
    lead = Accounts.get_lead!(id)

    with {:ok, %Lead{}} <- Accounts.delete_lead(lead) do
      send_resp(conn, :no_content, "")
    end
  end
end
