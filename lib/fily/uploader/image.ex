defmodule Fily.Uploader.Image do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fily.Uploader.Image


  schema "images" do

    timestamps()
  end

  @doc false
  def changeset(%Image{} = image, attrs) do
    image
    |> cast(attrs, [])
    |> validate_required([])
  end
end
