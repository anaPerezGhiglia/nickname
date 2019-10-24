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
      {:ok, tup} -> 
        update_and_return(conn, nickname, tup) 
      :error -> 
        json(conn, %{"error" => "not found"})
    end
  end

  def update_and_return(conn, nickname, tup) do
    update_visitis = fn {url, visits} -> {url, visits + 1} end
    {url, times_visitied} = updated = update_visitis.(tup)

    Agent.update(__MODULE__, fn map -> Map.put(map, nickname, updated) end)
    json(conn, %{"nickname" => url, "times" => times_visitied})
  end

end