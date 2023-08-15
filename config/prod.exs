import Config


# Do not print debug messages in production
config :logger, level: :info

secret_key_base =
  System.get_env("SECRET_KEY_BASE") || "/uziYSjPodnvnDgxxtB+Ct2Ss2s90ybydII8BLTkbxKMPuJtwXZZq2Q4t6tyW2gd"

config :fii_calculator, FiiCalculatorWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base
