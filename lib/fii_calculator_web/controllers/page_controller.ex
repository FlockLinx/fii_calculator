defmodule FiiCalculatorWeb.PageController do
  use FiiCalculatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
