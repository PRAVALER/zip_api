FROM bitwalker/alpine-elixir-phoenix:1.10.3

# Set mix env and ports
ENV MIX_ENV=prod \
    PORT=4000

# Cache elixir deps

WORKDIR /

COPY . .

RUN echo "Environment: $ENVIRONMENT"
RUN echo "copying secret" && cp prod.secret.exs config/prod.secret.exs
RUN mix do deps.get, deps.compile

# Run frontend build, compile, and digest assets
# RUN cd assets/ && npm run deploy
# RUN mix do compile, phx.digest

CMD ["mix", "phx.server"]