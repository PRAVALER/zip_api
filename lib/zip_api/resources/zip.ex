defmodule ZipApi.Resources.Zip do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:zip, :string, []}

  schema "zips" do
    field(:address, :string)
    field(:city, :string)
    field(:district, :string)
    field(:state, :string)
    field(:state_name, :string)

    timestamps()
  end

  @doc false
  def changeset(zip, attrs) do
    zip
    |> cast(attrs, [:zip, :address, :district, :city, :state, :state_name])
    |> validate_required([:zip, :address, :district, :city, :state, :state_name])
  end
end
