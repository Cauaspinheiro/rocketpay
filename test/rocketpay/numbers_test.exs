defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "when file exists, return the sum of all numbers" do
      expected_response = {:ok, %{result: 50}}

      response = Numbers.sum_from_file("numbers")

      assert response == expected_response
    end

    test "when file not exists, return :error" do
      expected_response = {:error, "Invalid File"}

      response = Numbers.sum_from_file("foobar")

      assert response == expected_response
    end
  end
end
