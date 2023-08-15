defmodule FiiCalculator.FiisTest do
  use FiiCalculator.DataCase

  alias FiiCalculator.Fiis

  describe "user" do
    alias FiiCalculator.Fiis.User

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fiis.create_user()

      user
    end

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert Fiis.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Fiis.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Fiis.create_user(@valid_attrs)
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fiis.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Fiis.update_user(user, @update_attrs)
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Fiis.update_user(user, @invalid_attrs)
      assert user == Fiis.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Fiis.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Fiis.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Fiis.change_user(user)
    end
  end
end
