#!/bin/bash

# Define variables
SOLUTION_NAME="../T-Tauri-Core.sln"
OUTPUT_DIR="output"
PACKAGE_FOLDER="../../.nupkgs"

# Clean previous builds
echo "Cleaning previous build artifacts..."
dotnet clean
rm -rf **/bin **/obj

# Restore NuGet packages
echo "Restoring NuGet packages..."
dotnet restore

# Build the solution
echo "Building the solution..."
dotnet build

# Publish the project
echo "Publishing the project..."
dotnet publish -c Release -o $OUTPUT_DIR

# Navigate to output directory
cd $OUTPUT_DIR || exit

# Clean up the package folder
rm -rf $PACKAGE_FOLDER

# Package the published files into nuget package
echo "Packaging files into $PACKAGE_FOLDER..."
dotnet pack $SOLUTION_NAME -c "Release" -o $PACKAGE_FOLDER -v m

# Clean up
echo "Cleaning up temporary files..."
cd ..
rm -rf $OUTPUT_DIR

echo "Build and packaging completed successfully."