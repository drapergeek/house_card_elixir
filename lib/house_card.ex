defmodule HouseCard do
  import URI

  def lookup_trip(origin, destination) do
    HTTPoison.start
    google_url(origin, destination)
    |> HTTPoison.get!
    |> Map.fetch!(:body)
    |> Poison.decode!
    |> build_trip
  end

  def build_trip(decoded_json) do
    case first_duration(decoded_json) do
      {:ok, duration} -> {:ok, %Trip{duration: duration}}
      {:error, error} -> {:error, error}
    end
  end

  defp first_duration(response) do
    try do
      duration = response["routes"]
      |> List.first
      |> Map.fetch!("legs")
      |> List.first
      |> Map.fetch!("duration")
      |> Map.fetch!("text")
      {:ok, duration}
    rescue
      _ -> {:error, "Cannot find first leg containing duration"}
    end
  end

  def google_url(origin, destination) do
    "http://maps.googleapis.com/maps/api/directions/json?origin=#{encode(origin)}&destination=#{encode(destination)}"
  end
end
