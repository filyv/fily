defmodule Fily.Uploader.Image do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fily.Uploader.Image


  schema "images" do
    field :url, :string
    timestamps()
  end

  @doc false
  def changeset(%Image{} = image, attrs) do
    image
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
