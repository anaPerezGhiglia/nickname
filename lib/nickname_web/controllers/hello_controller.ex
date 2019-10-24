defmodule NicknameWeb.HelloController do
  use NicknameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"subject" => someone} = params) do
    IO.inspect params
    render(conn, "show.html", messenger: someone)
  end

end