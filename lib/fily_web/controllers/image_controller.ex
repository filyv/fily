defmodule FilyWeb.ImageController do
  use FilyWeb, :controller

  alias Fily.Uploader
  alias Fily.Uploader.Image

  def index(conn, _params) do
    images = Uploader.list_images()
    render(conn, "index.html", images: images)
  end

  def new(conn, _params) do
    changeset = Uploader.change_image(%Image{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}) do
    IO.inspect image_params

    case Uploader.create_image(image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: image_path(conn, :show, image))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

  end

  def show(conn, %{"id" => id}) do
    image = Uploader.get_image!(id)
    render(conn, "show.html", image: image)
  end

  def edit(conn, %{"id" => id}) do
    image = Uploader.get_image!(id)
    changeset = Uploader.change_image(image)
    render(conn, "edit.html", image: image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do

    IO.inspect image_params
    image = Uploader.get_image!(id)

    case Uploader.update_image(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: image_path(conn, :show, image))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Uploader.get_image!(id)
    {:ok, _image} = Uploader.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: image_path(conn, :index))
  end
end
