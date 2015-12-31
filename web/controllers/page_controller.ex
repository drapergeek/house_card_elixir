defmodule HouseCardWeb.PageController do
  use HouseCardWeb.Web, :controller

  def index(conn, params) do
    case Map.fetch(params, "origin") do
      {:ok, origin} ->
        {:ok, trip} = HouseCard.lookup_trip(origin, "Washington, DC")
        render conn, "index.html", trip: trip
      :error ->
        render conn, "index.html", trip: :error
    end
  end
end
