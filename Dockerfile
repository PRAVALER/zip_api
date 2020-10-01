FROM bitwalker/alpine-elixir-phoenix:1.10.3

# Set mix env and ports
ENV MIX_ENV=prod \
    PORT=$PORT

# Cache elixir deps
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

WORKDIR /

COPY . .

RUN echo "Environment: $ENVIRONMENT"
RUN echo "copying secret" && cp prod.secret.exs config/prod.secret.exs

# Run frontend build, compile, and digest assets
# RUN cd assets/ && npm run deploy
# RUN mix do compile, phx.digest

CMD ["mix", "phx.server"]
