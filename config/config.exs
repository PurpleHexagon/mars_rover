import Config

config :logger,
       backends: [{LoggerFileBackend, :debug_log}]

config :logger, :debug_log,
       path: "log/app.log",
       level: :debug