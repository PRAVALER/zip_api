defmodule ZipApiWeb.ZipController do
  use ZipApiWeb, :controller

  alias ZipApi.Resources
  # alias ZipApi.Resources.Zip

  action_fallback(ZipApiWeb.FallbackController)

  # def index(conn, _params) do
  #   zips = Resources.list_zips()
  #   render(conn, "index.json", zips: zips)
  # end

  # def create(conn, %{"zip" => zip_params}) do
  #   with {:ok, %Zip{} = zip} <- Resources.create_zip(zip_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.zip_path(conn, :show, zip))
  #     |> render("show.json", zip: zip)
  #   end
  # end

  def show(conn, %{"zip" => zip_param}) do
    cleaned_zip = String.replace(zip_param, ~r/[^0-9]/, "")

    try do
      zip = Resources.get_zip!(cleaned_zip)
      render(conn, "show.json", zip: zip)
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  # def update(conn, %{"id" => id, "zip" => zip_params}) do
  #   zip = Resources.get_zip!(id)

  #   with {:ok, %Zip{} = zip} <- Resources.update_zip(zip, zip_params) do
  #     render(conn, "show.json", zip: zip)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   zip = Resources.get_zip!(id)

  #   with {:ok, %Zip{}} <- Resources.delete_zip(zip) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
