#!/usr/bin/env bash

cd application/client

echo ""
echo "##################################"
echo "## Installing Yarn ##"
echo "##################################"
npm install yarn -g

echo ""
echo "##################################"
echo "## Installing Node dependencies ##"
echo "##################################"
yarn install

echo ""
echo "#################################"
echo "## Installing Elm dependencies ##"
echo "#################################"
npm run elm-package -- install -y

echo ""
echo "######################################"
echo "## Installing Elm test dependencies ##"
echo "######################################"
(cd tests && ../node_modules/.bin/elm-package install -y)

echo ""
echo "###################"
echo "## Running tests ##"
echo "###################"
npm test

echo ""
echo "#######################"
echo "## Running Elm build ##"
echo "#######################"
npm build