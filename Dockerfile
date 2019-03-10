FROM ubuntu:18.10 AS base
RUN apt-get update -q && apt-get install -y unzip build-essential git wget libssl-dev libreadline-dev libncurses5-dev zlib1g-dev m4 curl autoconf

FROM base AS builder
SHELL ["/bin/bash", "-c"]
RUN git clone --depth 1 https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.7.0 && \
    echo '. $HOME/.asdf/asdf.sh' >> $HOME/.bashrc && \
    echo '. $HOME/.asdf/asdf.sh' >> $HOME/.profile
ENV PATH="${PATH}:/root/.asdf/shims:/root/.asdf/bin"
WORKDIR /app
COPY .tool-versions .
RUN asdf plugin-add elixir && asdf plugin-add erlang
RUN asdf install

FROM builder as deps
ENV MIX_ENV=prod
COPY mix.* ./
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix do deps.get --only prod, deps.compile

FROM deps AS releaser
COPY . ./
RUN mix compile
EXPOSE 4001