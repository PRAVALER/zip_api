defmodule ZipApi.Repo do
  use Ecto.Repo,
    otp_app: :zip_api,
    adapter: Ecto.Adapters.MyXQL
end
