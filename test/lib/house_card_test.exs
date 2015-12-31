defmodule HouseCardTest do
  use ExUnit.Case

  test "it returns a struct with the duration" do
    origin = "New York, NY"
    destination = "Washington, DC"

    {:ok, information} = HouseCard.lookup_trip(origin, destination)
    assert information.duration == "3 hours 52 mins"
  end

  test "it returns an error if the address cannot lookup properly" do
    origin = "NOT REAL"
    destination = "NO WAY JOSE"

    assert {:error, _} = HouseCard.lookup_trip(origin, destination)
  end

  test "it creates a url with the start and end locations" do
    origin = "New York, NY"
    destination = "Washington, DC"

    result = HouseCard.google_url(origin, destination)

    assert String.contains?(result, "NY")
    assert String.contains?(result, "DC")
  end
end
