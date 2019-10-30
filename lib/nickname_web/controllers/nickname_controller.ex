defmodule NicknameWeb.NicknameController do
  use NicknameWeb, :controller
  use Agent
  alias Nickname.{Repo, Nicknames}
  import Ecto.Query

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def create(conn, %{"url" => url, "nickname" => nickname} = params) do
    Repo.insert(%Nicknames{url: url, nickname: nickname, times: 0})
    json(conn, params)
  end

  defp get_binding(nickname) do
    Repo.one(from n in Nicknames, where: n.nickname == ^nickname)
  end

  def show(conn, %{"id" => foo}) do
    binding = get_binding(foo)
    case binding do
      nil -> 
        json(conn, %{"error" => "not found"})
      _ -> 
        update_times(binding)
        redirect(conn, external: binding.url) 
    end
  end

  def stats(conn, %{"id" => nickname}) do
    binding = get_binding(nickname)
    case binding do
      nil -> 
        json(conn, %{"error" => "not found"})
      _ -> 
        json(conn, %{"nickname" => binding.url, "times" => binding.times})
    end
  end 

  def update_times(nickname) do
    nickname 
    |> Nicknames.changeset(%{times: nickname.times + 1})
    |> Repo.update
    nil
  end

end