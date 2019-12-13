defmodule MartifyWeb.PageController do
  use MartifyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
