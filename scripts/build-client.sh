#!/usr/bin/env bash

cd application/client

echo "## Installing node dependencies ##"
npm install

echo "## Installing elm dependencies ##"
npm run elm-package -- install -y

echo "## Installing elm test dependencies ##"
(cd tests && ../node_modules/.bin/elm-package install -y)

echo "## Running tests ##"
npm test