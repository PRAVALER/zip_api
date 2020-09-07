defmodule ZipApiWeb.ZipControllerTest do
  use ZipApiWeb.ConnCase

  alias ZipApi.Resources

  @create_attrs %{
    address: "some address",
    city: "some city",
    district: "some district",
    state: "some state",
    state_name: "some state_name",
    zip: "12345876"
  }

  def fixture(:zip) do
    {:ok, zip} = Resources.create_zip(@create_attrs)
    zip
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show" do
    setup [:create_zip]

    test "show zip", %{conn: conn} do
      conn = get(conn, Routes.zip_path(conn, :show, "12345876"))

      assert %{
               "address" => "some address",
               "city" => "some city",
               "district" => "some district",
               "state" => "some state",
               "state_name" => "some state_name",
               "zip" => "12345876"
             } = json_response(conn, 200)
    end

    test "show zip when there is dash on code", %{conn: conn} do
      conn = get(conn, Routes.zip_path(conn, :show, "12345-876"))

      assert "12345876" = json_response(conn, 200)["zip"]
    end
  end

  defp create_zip(_) do
    zip = fixture(:zip)
    %{zip: zip}
  end
end
