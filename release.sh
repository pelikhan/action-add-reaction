#!/bin/sh
# Exit script if any command fails
set -e

# make sure there's no other changes
git pull --tags

# Step 0: ensure we're in sync
if [ "$(git status --porcelain)" ]; then
  echo "❌ Pending changes detected. Commit or stash them first."
  exit 1
fi

# Step 1: Bump patch version using npm
# Assign the first CLI argument to version
NEW_VERSION="$1"

# Ensure a version was provided
if [ -z "$NEW_VERSION" ]; then
  echo "❌ No version specified. Usage: ./release.sh <version>"
  exit 1
fi

# Validate that the version follows semver format (x.y.z)
if ! echo "$NEW_VERSION" | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' > /dev/null; then
  echo "❌ Invalid version format. Expected: v?x.y.z"
  exit 1
fi

# Strip leading 'v' if present
NEW_VERSION=$(echo "$NEW_VERSION" | sed 's/^v//')

# Tag the version
git tag -a "v$NEW_VERSION" -m "Release v$NEW_VERSION"
NEW_VERSION=
echo "version: $NEW_VERSION"

# Step 2: Push commit and tag
git push origin HEAD --tags

# Step 3: Create GitHub release
gh release create "$NEW_VERSION" --title "$NEW_VERSION" --notes "Patch release $NEW_VERSION"

# Step 4: update major tag if any
MAJOR=$(echo "$NEW_VERSION" | cut -d. -f1)
echo "major: $MAJOR"
git tag -f $MAJOR $NEW_VERSION
git push origin $MAJOR --force

echo "✅ GitHub release $NEW_VERSION created successfully."
