defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
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

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{
        name: ^name,
        nickname: ^nickname,
        birth_date: ^birth_date,
        email: ^email,
        id: ^user_id
      } = user
    end

    test "when there are invalid params, returns an error" do
      nickname = Faker.Lorem.Shakespeare.hamlet()
      email = Faker.Internet.email()
      birth_date = Faker.Date.date_of_birth(14)

      params = %{
        nickname: nickname,
        email: email,
        birth_date: birth_date
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        name: ["can't be blank"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
