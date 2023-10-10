defmodule IssuesTest do
  use ExUnit.Case
  doctest Issues
  import Issues.Cli



  test "when the username projectname and the number are pased in" do
    assert parse_args(["moses", "elixir 101", "99"]) == {"moses", "elixir 101", 99}
  end

  test "when only the username and the project name are passed " do
    assert parse_args(["moses", "project name"]) == {"moses", "project name", 4}
  end

  test "when there are no legit representation of data :help" do
    assert parse_args([:help]) == :help
  end
  # test ":help returned by -h or --help" do
  #   assert parse_args([ "anything"]) == :help
  #   assert parse_args(["--help", "anything"]) == :help
  # end

  # test "when there are three aliases passed in there" do
  #   assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  # end

  # test "two values passed " do
  #   assert parse_args(["user", "project"]) == {"user", "project", 4}
  # end

  # # test "when there is no argument parsed to it" do
  # #   assert p(_) == :help
  # # end



end
