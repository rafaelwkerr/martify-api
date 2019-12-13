defmodule MartifyWeb.LeadView do
  use MartifyWeb, :view
  alias MartifyWeb.LeadView

  def render("index.json", %{leads: leads}) do
    %{data: render_many(leads, LeadView, "lead.json")}
  end

  def render("show.json", %{lead: lead}) do
    %{data: render_one(lead, LeadView, "lead.json")}
  end

  def render("lead.json", %{lead: lead}) do
    %{id: lead.id,
      name: lead.name,
      phone: lead.phone,
      email: lead.email}
  end
end
