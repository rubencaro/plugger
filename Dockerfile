FROM elixir:1.8.1-alpine AS builder
# FROM elixir:1.8.1 AS builder
ENV MIX_ENV=prod
WORKDIR /app
COPY mix.* /app/
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix do deps.get --only prod, deps.compile

FROM builder AS releaser
COPY . /app/
RUN mix compile
EXPOSE 4001