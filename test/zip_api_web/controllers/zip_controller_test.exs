defmodule ZipApiWeb.ZipControllerTest do
  use ZipApiWeb.ConnCase

  alias ZipApi.Resources
  alias ZipApi.Resources.Zip

  @create_attrs %{
    address: "some address",
    city: "some city",
    district: "some district",
    state: "some state",
    state_name: "some state_name",
    zip: "some zip"
  }
  @update_attrs %{
    address: "some updated address",
    city: "some updated city",
    district: "some updated district",
    state: "some updated state",
    state_name: "some updated state_name",
    zip: "some updated zip"
  }
  @invalid_attrs %{address: nil, city: nil, district: nil, state: nil, state_name: nil, zip: nil}

  def fixture(:zip) do
    {:ok, zip} = Resources.create_zip(@create_attrs)
    zip
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all zips", %{conn: conn} do
      conn = get(conn, Routes.zip_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create zip" do
    test "renders zip when data is valid", %{conn: conn} do
      conn = post(conn, Routes.zip_path(conn, :create), zip: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.zip_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "city" => "some city",
               "district" => "some district",
               "state" => "some state",
               "state_name" => "some state_name",
               "zip" => "some zip"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.zip_path(conn, :create), zip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update zip" do
    setup [:create_zip]

    test "renders zip when data is valid", %{conn: conn, zip: %Zip{id: id} = zip} do
      conn = put(conn, Routes.zip_path(conn, :update, zip), zip: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.zip_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "city" => "some updated city",
               "district" => "some updated district",
               "state" => "some updated state",
               "state_name" => "some updated state_name",
               "zip" => "some updated zip"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, zip: zip} do
      conn = put(conn, Routes.zip_path(conn, :update, zip), zip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete zip" do
    setup [:create_zip]

    test "deletes chosen zip", %{conn: conn, zip: zip} do
      conn = delete(conn, Routes.zip_path(conn, :delete, zip))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.zip_path(conn, :show, zip))
      end
    end
  end

  defp create_zip(_) do
    zip = fixture(:zip)
    %{zip: zip}
  end
end
