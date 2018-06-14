#!/bin/bash

INSTALLATION_DIRECTORY=$HOME/bin

mkdir $INSTALLATION_DIRECTORY

curl https://services.gradle.org/distributions/gradle-4.3-all.zip -Lo $INSTALLATION_DIRECTORY/gradle-4.3-all.zip

unzip $INSTALLATION_DIRECTORY/gradle-4.3-all.zip -d $INSTALLATION_DIRECTORY

echo "export PATH=\"$INSTALLATION_DIRECTORY/gradle-4.3/bin:\$PATH\"" >> ~/.zshrc
source ~/.zshrc
