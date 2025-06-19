#!/bin/bash
set -e

# This script creates a new GitHub release by incrementing the patch version
# and updates the vmajor tag to point to the latest release.

# Check if git is clean
if [ -n "$(git status --porcelain)" ]; then
  echo "Error: Working directory is not clean. Please commit all changes before releasing."
  exit 1
fi

# Fetch all tags
git fetch --tags

# Get latest version tag (format: v1.2.3)
LATEST_TAG=$(git tag -l "v*.*.*" | sort -V | tail -n 1)

if [ -z "$LATEST_TAG" ]; then
  echo "No version tags found. Creating initial version v0.1.0"
  LATEST_TAG="v0.0.0"
fi

echo "Current version: $LATEST_TAG"

# Extract version components
if [[ $LATEST_TAG =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
  MAJOR="${BASH_REMATCH[1]}"
  MINOR="${BASH_REMATCH[2]}"
  PATCH="${BASH_REMATCH[3]}"
else
  echo "Error: Unable to parse version from $LATEST_TAG"
  exit 1
fi

# Increment patch version
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="v$MAJOR.$MINOR.$NEW_PATCH"
VMAJOR_TAG="v$MAJOR"

echo "Creating new release: $NEW_VERSION"

# Create a new tag
git tag -a "$NEW_VERSION" -m "Release $NEW_VERSION"

# Update the vmajor tag (force update if it already exists)
git tag -fa "$VMAJOR_TAG" -m "Update $VMAJOR_TAG to point to $NEW_VERSION"

# Push the new tags to remote
echo "Pushing tags to remote..."
git push origin "$NEW_VERSION" "$VMAJOR_TAG" --force

# Create GitHub release
echo "Creating GitHub release..."
gh release create "$NEW_VERSION" \
  --title "Release $NEW_VERSION" \
  --notes "## What's Changed
* Updates and improvements
* See the [full changelog](https://github.com/$GITHUB_REPOSITORY/compare/${LATEST_TAG}...${NEW_VERSION})" \
  --latest

echo "✅ Release $NEW_VERSION created successfully!"
echo "🏷️ Major version tag $VMAJOR_TAG updated to point to $NEW_VERSION"
