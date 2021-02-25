defmodule RocketpayWeb.AccountsView do


  def render("update.json", %{account: account}) do
    %{
      message: "Balance changed successfully",
      new_balance: account.balance
    }
  end
end
