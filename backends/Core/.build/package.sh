#!/bin/bash

# Define variables
SOLUTION_FILE="T-Tauri-Core.sln"
PACKAGE_FOLDER="../.nupkgs"
PUBLISH_FOLDER="../.publish"
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
echo "Publishing the projects..."

# Ensure the solution file exists
if [ ! -f "$SOLUTION_FILE" ]; then
    echo "Solution file $SOLUTION_FILE not found."
    exit 1
fi

# Clean up the publish folder
echo "Cleaning up publish folder..."
rm -rf $PUBLISH_FOLDER

# Clean up the package folder
echo "Cleaning up package files..."
rm -rf $PACKAGE_FOLDER

# Get all project paths from the solution file
PROJECT_PATHS=$(dotnet sln list | grep -E \.csproj$)

# Loop through each project path
for PROJECT_PATH in $PROJECT_PATHS; do
    PROJECT_FILE=$(echo $PROJECT_PATH | awk -F '\' '{print $2}')
    PROJECT_NAME=$(echo $PROJECT_FILE | awk -F '.' '{print $1}')
    
    # Publish the project
    echo "Publishing project $PROJECT_NAME into $PUBLISH_FOLDER/$PROJECT_NAME..."
    dotnet publish $PROJECT_PATH -c "Release" -o $PUBLISH_FOLDER/$PROJECT_NAME -r win-x64 --self-contained true   

    # Package the published files into a nuget package
    echo "Packaging project $PROJECT_NAME into $PACKAGE_FOLDER/$PROJECT_NAME..."
    dotnet pack $PROJECT_PATH -c "Release" -o $PACKAGE_FOLDER/$PROJECT_NAME -v m
done

echo "All projects publised."    

echo "Build and packaging completed successfully."