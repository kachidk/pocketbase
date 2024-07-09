#!/bin/sh

# Default version
version=${1:-0.22.16}

# Determine the operating system and architecture
os=$(uname | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)

# Map architecture name to expected format
case $arch in
x86_64)
  arch="amd64"
  ;;
aarch64)
  arch="arm64"
  ;;
*)
  echo "Unsupported architecture: $arch"
  exit 1
  ;;
esac

# Construct the URL
url="https://github.com/pocketbase/pocketbase/releases/download/v${version}/pocketbase_${version}_${os}_${arch}.zip"

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download and unzip the PocketBase binary
wget -O "$temp_dir/pocketbase.zip" "$url"
if [ $? -ne 0 ]; then
  echo "Failed to download PocketBase. Please check the version number and try again."
  rm -rf "$temp_dir"
  exit 1
fi

unzip "$temp_dir/pocketbase.zip" -d "$temp_dir"
if [ $? -ne 0 ]; then
  echo "Failed to unzip the PocketBase archive."
  rm -rf "$temp_dir"
  exit 1
fi

# Move the binary to the current directory
mv "$temp_dir/pocketbase" ./
if [ $? -ne 0 ]; then
  echo "Failed to move the PocketBase binary."
  rm -rf "$temp_dir"
  exit 1
fi

# Clean up
rm -rf "$temp_dir"

echo "PocketBase binary has been saved to the current directory."

# Make the PocketBase binary executable
chmod +x pocketbase

echo "Installation completed successfully."
