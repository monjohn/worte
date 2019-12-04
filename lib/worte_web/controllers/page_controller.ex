defmodule WorteWeb.PageController do
  use WorteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
