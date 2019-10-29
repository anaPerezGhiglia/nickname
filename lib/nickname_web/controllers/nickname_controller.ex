defmodule NicknameWeb.NicknameController do
  use NicknameWeb, :controller
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def create(conn, %{"url" => url, "nickname" => nickname} = params) do
    Agent.update(__MODULE__, fn map -> Map.put_new(map, nickname, {url, 0}) end)
    json(conn, params)
  end

  def show(conn, %{"id" => nickname}) do
    res = Agent.get(__MODULE__, fn map -> Map.fetch(map, nickname) end)
    case res do
      {:ok, tup} -> # key found so nickname has been defined
        update_times(nickname, tup)
        {url, _} = tup
        redirect(conn, external: url) 
      :error -> 
        json(conn, %{"error" => "not found"})
    end
  end

  def stats(conn, %{"id" => nickname}) do
    res = Agent.get(__MODULE__, fn map -> Map.fetch(map, nickname) end)
    case res do
      {:ok, {url, times_visitied}} -> 
        json(conn, %{"nickname" => url, "times" => times_visitied})
      :error -> 
        json(conn, %{"error" => "not found"})
    end
  end 

  def update_times(nickname, tup) do
    update_visits = fn {url, visits} -> {url, visits + 1} end
    updated = update_visits.(tup)

    Agent.update(__MODULE__, fn map -> Map.put(map, nickname, updated) end)
    nil
  end

end