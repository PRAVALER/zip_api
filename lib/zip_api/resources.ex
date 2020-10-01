defmodule ZipApi.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias ZipApi.Repo

  alias ZipApi.Resources.Zip

  @doc """
  Returns the list of zips.

  ## Examples

      iex> list_zips()
      [%Zip{}, ...]

  """
  def list_zips do
    Repo.all(Zip)
  end

  @doc """
  Gets a single zip.

  Raises `Ecto.NoResultsError` if the Zip does not exist.

  ## Examples

      iex> get_zip!(123)
      %Zip{}

      iex> get_zip!(456)
      ** (Ecto.NoResultsError)

  """
  def get_zip!(zip), do: Repo.get!(Zip, zip)

  @doc """
  Creates a zip.

  ## Examples

      iex> create_zip(%{field: value})
      {:ok, %Zip{}}

      iex> create_zip(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_zip(attrs) do
    %Zip{}
    |> Zip.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a zip.

  ## Examples

      iex> update_zip(zip, %{field: new_value})
      {:ok, %Zip{}}

      iex> update_zip(zip, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_zip(%Zip{} = zip, attrs) do
    zip
    |> Zip.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a zip.

  ## Examples

      iex> delete_zip(zip)
      {:ok, %Zip{}}

      iex> delete_zip(zip)
      {:error, %Ecto.Changeset{}}

  """
  def delete_zip(%Zip{} = zip) do
    Repo.delete(zip)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking zip changes.

  ## Examples

      iex> change_zip(zip)
      %Ecto.Changeset{data: %Zip{}}

  """
  def change_zip(%Zip{} = zip, attrs \\ %{}) do
    Zip.changeset(zip, attrs)
  end
end
