defmodule NicknameWeb.Router do
  use NicknameWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug :put_secure_browser_headers
    #plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NicknameWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/nickname", NicknameController, only: [:show, :create]
  end

end
