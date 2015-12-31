defmodule HouseCardWeb.PageController do
  use HouseCardWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
