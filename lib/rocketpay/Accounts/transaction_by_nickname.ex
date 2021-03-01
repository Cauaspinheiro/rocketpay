defmodule Rocketpay.Accounts.TransactionByNickname do
  alias Rocketpay.{Repo, User}

  def call(%{"nickname" => nickname, "from" => from, "value" => value}) do
    {:ok, %User{account: %{id: to_account_id}} } = get_user_by_nickname(nickname)

    Rocketpay.transaction(%{"to" => to_account_id, "from" => from, "value" => value})
  end

  defp get_user_by_nickname(nickname) do
    case preload_user_account(nickname) do
       nil -> {:error, "User not found"}
       user -> {:ok, user}
    end
  end

  defp preload_user_account(nickname) do
    Repo.get_by(User, nickname: nickname)
    |> Repo.preload(:account)
  end


end
