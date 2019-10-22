FROM elixir:1.9.2

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y inotify-tools && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mix local.hex --force
RUN mix local.rebar --force