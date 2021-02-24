defmodule RocketpayWeb.UsersView do
  def render("create.json", %{user: user}) do
    %{
      message: "User Created",
      user: %{
        id: user.id,
        balance: user.account.balance
      }
    }
  end
end
