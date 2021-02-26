defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      name =  Faker.Person.PtBr.first_name()
      password =  Faker.String.base64()
      nickname =  Faker.Internet.user_name()
      email =  Faker.Internet.email()
      birth_date =  Faker.Date.date_of_birth(18..99)

      params = %{
        name: name,
        password: password,
        nickname: nickname,
        email: email,
        birth_date: birth_date
      }

      conn = put_req_header(conn, "authorization", "Basic YWRtaW46YWRtaW4xMjM0NTY=")

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", setup do
      %{conn: conn, account_id: account_id} = setup

      value = "#{Faker.random_between(0, 100)}.#{Faker.random_between(10, 99)}"

      params = %{"value" => value}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
        "message" => "Balance changed successfully",
        "new_balance" => ^value
        } = response
    end

    test "when there are invalid params, returns an error", setup do
      %{conn: conn, account_id: account_id} = setup

      value = Faker.String.naughty()

      params = %{"value" => value}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert %{"message" => "invalid value"} == response
    end
  end
end
