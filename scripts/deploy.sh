#! /usr/bin/env bash
mix deps.get
mix deps.compile # get updated dependencies & compile them
# mix do ecto.create, ecto.migrate
cd assets && npm install && npm run deploy & cd ..
mix phx.digest
mix compile
MIX_ENV=prod mix release
