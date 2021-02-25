defmodule RocketpayWeb.AccountsView do

  def render("operation.json", %{account: account}) do
    %{
      message: "Balance changed successfully",
      new_balance: account.balance
    }
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      message: "Transaction done successfully",
      transaction: %{
        from_account_balance: transaction.from_account.balance,
        to_account_balance: transaction.to_account.balance,
      }
    }
  end
end
