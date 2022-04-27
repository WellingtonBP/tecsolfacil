FROM elixir:alpine

RUN apk update && apk add --no-cache build-base

WORKDIR /app

ARG MIX_ENV=dev

RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./
COPY apps/api/mix.exs ./apps/api
COPY config config


RUN mix do deps.get, deps.compile

COPY . ./
RUN mix compile

EXPOSE 4000

CMD mix setup && mix phx.server
