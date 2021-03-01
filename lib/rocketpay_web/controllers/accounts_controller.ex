defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("operation.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("operation.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %Transactions.Response{} = transaction} <- Rocketpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end

  def transaction_by_nickname(conn, params) do
    with {:ok, %Transactions.Response{} = transaction} <- Rocketpay.transaction_by_nickname(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
