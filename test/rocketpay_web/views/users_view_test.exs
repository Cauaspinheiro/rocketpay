defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.User

  test "renders create.json" do
    name = Faker.Person.PtBr.first_name()
    password = Faker.String.base64()
    nickname = Faker.Internet.user_name()
    email = Faker.Internet.email()
    birth_date = Faker.Date.date_of_birth(18..99)

    params = %{
      name: name,
      password: password,
      nickname: nickname,
      email: email,
      birth_date: birth_date
    }

    {:ok, %User{id: user_id} = user} = Rocketpay.create_user(params)

    response = render(RocketpayWeb.UsersView, "create.json", user: user)

    expected_response = %{
      message: "User Created",
      user: %{
        balance: Decimal.new("0.00"),
        id: user_id
      }
    }

    assert expected_response == response
  end
end
