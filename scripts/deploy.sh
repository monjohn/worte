#! /usr/bin/env bash
exec bash

cd ~/worte 
git pull

mix --version

mix deps.get --only prod
MIX_ENV=prod mix compile

npm run deploy --prefix ./assets
# mix do ecto.create, ecto.migrate

# MIX_ENV=prod mix ecto.migrate
# cd assets && npm install && npm run deploy & cd ..
mix phx.digest
mix compile
MIX_ENV=prod mix release

PORT=4001 MIX_ENV=prod elixir --erl "-detached" -S mix phx.server
