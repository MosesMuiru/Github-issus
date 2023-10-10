defmodule Issues.Cli do
  @default_count 4 #when there is no count passed in as arity this will be used

  @moduledoc """

  """
  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  argv - can be any cli command -h ,--help that returns help
  otherwise it is a github username,project, or else the number of entrie to format
  """

  @doc """
  the code before refoctor
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[ help: true], _, _} -> :help
      {_,[ user, project, count ], _} -> { user, project, String.to_integer(count)}
      {_, [ user, project ], _} -> { user, project, @default_count}
      _-> :help
    end
  end
  """

  @doc """
after refactor
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [ help: :boolean], aliases: [ h: :help ])
    |> elem(1)
    |> args_to_internal_representation()

  end

  def args_to_internal_representation([user, project, count]) do
    { user, project, String.to_integer(count) }
  end

  def  args_to_internal_representation([user, project]) do
    {user, project, @default_count}
  end

  def args_to_internal_representation(_) do
    :help
  end

  @doc """
  one handles where the user asks for help and the other where user,project name and count is returned
  """

  def process({user , project, _count}) do

    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_descending_order()

  end
  # sortitng
  def sort_into_descending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 ->
      i1["created at"] >= i2["created at"]
    end
      )
  end

  def decode_response({:ok, body}) ,do: body
  def decode_response({:error, error}) do
    IO.puts "error fetching from github: #{error["message"]}"
    System.halt(2)
  end

  def process(:help) do
    IO.puts """
      usage: issues <user><project> [count | #{@default_count}]
    """

    System.halt(0)
  end
end
