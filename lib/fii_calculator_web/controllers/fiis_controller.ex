defmodule FiiCalculatorWeb.FiisController do
  use FiiCalculatorWeb, :controller
  alias FiiCalculator.Calculator

  def index(conn, params) do
    if params != %{} do
      fii_infos = Calculator.get_fiis(params)
      render(conn, "index.html", fii_infos: fii_infos)
    end

    render(conn, "index.html", fii_infos: nil)
  end

  def invest_amount(conn, params) do
    if params != %{} do
      fii_infos = Calculator.get_fii_by_invested_amounts(params)
      render(conn, "invest_amount.html", fii_infos: fii_infos)
    end

    render(conn, "invest_amount.html", fii_infos: nil)
  end
end
