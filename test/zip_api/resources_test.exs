defmodule ZipApi.ResourcesTest do
  use ZipApi.DataCase

  alias ZipApi.Resources

  describe "zips" do
    alias ZipApi.Resources.Zip

    @valid_attrs %{
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
    @invalid_attrs %{
      address: nil,
      city: nil,
      district: nil,
      state: nil,
      state_name: nil,
      zip: nil
    }

    def zip_fixture(attrs \\ %{}) do
      {:ok, zip} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_zip()

      zip
    end

    test "list_zips/0 returns all zips" do
      zip = zip_fixture()
      assert Resources.list_zips() == [zip]
    end

    test "get_zip!/1 returns the zip with given id" do
      zip = zip_fixture()
      assert Resources.get_zip!(zip.zip) == zip
    end

    test "create_zip/1 with valid data creates a zip" do
      assert {:ok, %Zip{} = zip} = Resources.create_zip(@valid_attrs)
      assert zip.address == "some address"
      assert zip.city == "some city"
      assert zip.district == "some district"
      assert zip.state == "some state"
      assert zip.state_name == "some state_name"
      assert zip.zip == "some zip"
    end

    test "create_zip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_zip(@invalid_attrs)
    end

    test "update_zip/2 with valid data updates the zip" do
      zip = zip_fixture()
      assert {:ok, %Zip{} = zip} = Resources.update_zip(zip, @update_attrs)
      assert zip.address == "some updated address"
      assert zip.city == "some updated city"
      assert zip.district == "some updated district"
      assert zip.state == "some updated state"
      assert zip.state_name == "some updated state_name"
      assert zip.zip == "some updated zip"
    end

    test "update_zip/2 with invalid data returns error changeset" do
      zip = zip_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_zip(zip, @invalid_attrs)
      assert zip == Resources.get_zip!(zip.zip)
    end

    test "delete_zip/1 deletes the zip" do
      zip = zip_fixture()
      assert {:ok, %Zip{}} = Resources.delete_zip(zip)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_zip!(zip.zip) end
    end

    test "change_zip/1 returns a zip changeset" do
      zip = zip_fixture()
      assert %Ecto.Changeset{} = Resources.change_zip(zip)
    end
  end
end
