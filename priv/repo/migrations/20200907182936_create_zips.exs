defmodule ZipApi.Repo.Migrations.CreateZips do
  use Ecto.Migration

  def change do
    create table(:zips, primary_key: false) do
      add(:zip, :string, primary_key: true)
      add(:address, :string)
      add(:district, :string)
      add(:city, :string)
      add(:state, :string)
      add(:state_name, :string)

      timestamps()
    end
  end
end
