defmodule FiiCalculator.Calculator do
  @moduledoc """
  Documentation for `Fiicalc`.
  """

  @base_url "https://mfinance.com.br/api/v1/fiis"

  def get_fiis(fii_name, invested_amount \\ nil, invested_quote \\ nil) do
    search_term = get_in(fii_name, ["query"]) |> String.trim()

    result = Map.merge(get_dividends(search_term), get_info(search_term))
    last_dividend = result[:value]
    last_price = result[:lastPrice]

    result
    |> Map.merge(to_1k_values(last_dividend, last_price))
    |> Map.put(
      :amount_to_invest,
      invested_amount_calcs(invested_amount, last_dividend, last_price)
    )
    |> Map.put(:quote_quantiy, invested_quote_calcs(invested_quote, last_dividend))
  end

    def get_fii_by_invested_amounts(%{
        "invested_amount" => "",
        "invested_quote" => "",
        "query" => fii_name
      }) do
    search_term = fii_name |> String.trim()

    result = Map.merge(get_dividends(search_term), get_info(search_term))
    last_dividend = result[:value]
    last_price = result[:lastPrice]

    result
    |> Map.merge(to_1k_values(last_dividend, last_price))
  end

  def get_fii_by_invested_amounts(%{
        "invested_amount" => invested_amount,
        "invested_quote" => "",
        "query" => fii_name
      }) do
    search_term = fii_name |> String.trim()

    result = Map.merge(get_dividends(search_term), get_info(search_term))
    last_dividend = result[:value]
    last_price = result[:lastPrice]

    result
    |> Map.merge(to_1k_values(last_dividend, last_price))
    |> Map.put(
      :amount_to_invest,
      invested_amount_calcs(invested_amount, last_dividend, last_price)
    )
  end

  def get_fii_by_invested_amounts(%{
        "invested_amount" => "",
        "invested_quote" => invested_quote,
        "query" => fii_name
      }) do
    search_term = fii_name |> String.trim()

    result = Map.merge(get_dividends(search_term), get_info(search_term))
    last_dividend = result[:value]
    last_price = result[:lastPrice]

    result
    |> Map.merge(to_1k_values(last_dividend, last_price))
    |> Map.put(:quote_quantiy, invested_quote_calcs(invested_quote, last_dividend))
  end

  def get_fii_by_invested_amounts(%{
        "invested_amount" => invested_amount,
        "invested_quote" => invested_quote,
        "query" => fii_name
      }) do
    search_term = fii_name |> String.trim()

    result = Map.merge(get_dividends(search_term), get_info(search_term))
    last_dividend = result[:value]
    last_price = result[:lastPrice]

    result
    |> Map.merge(to_1k_values(last_dividend, last_price))
    |> Map.put(
      :amount_to_invest,
      invested_amount_calcs(invested_amount, last_dividend, last_price)
    )
    |> Map.put(:quote_quantiy, invested_quote_calcs(invested_quote, last_dividend))
  end

  def invested_amount_calcs(nil, _, _), do: nil
  def invested_amount_calcs("", _, _), do: nil

  def invested_amount_calcs(invested_amount, last_dividend, last_price) do
    quote_quantity = String.to_integer(invested_amount) / last_price
    dividend_amount = quote_quantity * last_dividend

    %{quote_quantity: Float.ceil(quote_quantity), dividend_amount: money_parse(dividend_amount)}
  end

  def invested_quote_calcs(nil, _), do: nil
  def invested_quote_calcs("", _), do: nil

  def invested_quote_calcs(invested_quote, last_dividend) do
    dividend_amount_by_quote_quantity = String.to_integer(invested_quote) * last_dividend

    %{dividend_amount_by_quote_quantity: dividend_amount_by_quote_quantity}
  end

  def to_1k_values(last_dividend, last_price) do
    quote_needed_to_1k = 1000 / last_dividend
    insveted_amount_to_1k = quote_needed_to_1k * last_price

    %{
      quote_needed_to_1k: floor_round(quote_needed_to_1k),
      insveted_amount_to_1k: money_parse(insveted_amount_to_1k)
    }
  end

  def get_dividends(fii_name) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.get(@base_url <> "/dividends/#{fii_name}")

    Jason.decode!(body, keys: :atoms) |> Map.get(:dividends) |> List.last()
  end

  def get_info(fii_name) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.get(@base_url <> "?symbols=#{fii_name}")

    Jason.decode!(body, keys: :atoms) |> Map.get(:fiis) |> List.first()
  end

  def floor_round(value), do: value |> :erlang.float_to_binary([{:decimals, 2}])

  def money_parse(value) do
    new_value = Regex.replace(~r/[.,]/, to_string(floor_round(value)), "")

    Money.to_string(Money.new(String.to_integer(new_value), :BRL),
      separator: ".",
      delimiter: ",",
      symbol: true
    )
  end
end
