#!/bin/bash

#This .sh will run everything related to the piix-app-frontend app

MODULE="piix-app-frontend"
echo "********************************************************************************"
echo "Running build for $MODULE"
echo "********************************************************************************"
echo ""

echo "Running test for $MODULE app"
fvm flutter test

echo ""
echo "********************************************************************************"
echo "Finished build for $MODULE"
echo "********************************************************************************"