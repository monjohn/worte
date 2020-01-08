defmodule WorteWeb.PageController do
  use WorteWeb, :controller

  alias Phoenix.LiveView

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
