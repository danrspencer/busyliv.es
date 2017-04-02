#!/usr/bin/env bash

cd application/client
echo "## Installing node dependencies ##"
npm install
echo "## Installing elm dependencies ##"
npm run elm-package -- install -y
cd tests
echo "## Installing elm test dependencies ##"
../node_modules/.bin/elm-package install -y
cd ..
echo "## Running tests ##"
npm test