defmodule ZipApiWeb.ZipView do
  use ZipApiWeb, :view
  alias ZipApiWeb.ZipView

  def render("show.json", %{zip: zip}) do
    render_one(zip, ZipView, "zip.json")
  end

  def render("zip.json", %{zip: zip}) do
    %{
      zip: zip.zip,
      address: zip.address,
      district: zip.district,
      city: zip.city,
      state: zip.state,
      state_name: zip.state_name
    }
  end
end
