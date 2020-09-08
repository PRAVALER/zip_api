FROM bitwalker/alpine-elixir-phoenix:latest

# Set mix env and ports
ENV MIX_ENV=prod \
    PORT=$PORT

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/
RUN cd assets && \
    npm install

ADD . .

RUN echo "Environment: $ENVIRONMENT"
RUN cat prod.secret.exs
RUN echo "copying secret" && cp prod.secret.exs config/prod.secret.exs

# Run frontend build, compile, and digest assets
RUN cd assets/ && \
    npm run deploy && \
    cd - && \
    mix do compile, phx.digest

CMD ["mix", "phx.server"]
