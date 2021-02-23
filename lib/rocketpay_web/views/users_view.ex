defmodule RocketpayWeb.UsersView do
  def render("create.json", %{user: user}) do
    %{
      message: "User Created",
      id: user.id
    }
  end
end
