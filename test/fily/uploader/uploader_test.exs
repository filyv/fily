defmodule Fily.UploaderTest do
  use Fily.DataCase

  alias Fily.Uploader

  describe "images" do
    alias Fily.Uploader.Image

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Uploader.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Uploader.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Uploader.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Uploader.create_image(@valid_attrs)
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Uploader.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, image} = Uploader.update_image(image, @update_attrs)
      assert %Image{} = image
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Uploader.update_image(image, @invalid_attrs)
      assert image == Uploader.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Uploader.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Uploader.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Uploader.change_image(image)
    end
  end
end
