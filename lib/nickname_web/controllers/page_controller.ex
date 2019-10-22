defmodule NicknameWeb.PageController do
  use NicknameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
