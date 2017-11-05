defmodule Fily.Uploader do
  @moduledoc """
  The Uploader context.
  """

  import Ecto.Query, warn: false
  alias Fily.Repo

  alias Fily.Uploader.Image

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Repo.all(Image)
  end

  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(imageParams) do
    if upload = imageParams["photo"] do
      # FIXME: Obtener una llave única con la cual se pueda guardar la imagen.
      # Esto se debe a que sí se trata de una nueva imagen, aún no contiene un
      # id. Por ello es que se requiere obtener el ID del modelo al que se puede
      # relacionar O generar un UUID el cual, por definición, siempre será
      # único, sin importar las circunstancias. Por el momento se simulará un uuid.
      uuid = "98fbdb67-bcde-48ea-9225-cb4412e5d95c"
      extension = Path.extname(upload.filename)
      pathbase = Path.absname("media")
      filepath = Path.join([pathbase, "/#{uuid}-img#{extension}"])
      IO.puts(filepath)
      File.cp!(upload.path, filepath)
      newParams = Map.put(imageParams, "url", filepath)
    else
      newParams = imageParams
    end

    image = %Image{}
    |> Image.changeset(newParams)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{source: %Image{}}

  """
  def change_image(%Image{} = image) do
    Image.changeset(image, %{})
  end
end
