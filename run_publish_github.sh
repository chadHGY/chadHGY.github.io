#!/bin/bash
set -e

# Default to sibling directory if DEPLOY_DIR is not set
DEPLOY_DIR="${DEPLOY_DIR:-../chadHGY.github.io}"
DEPLOY_BRANCH="${DEPLOY_BRANCH:-master}"
COMMIT_INFO="$(git log -1 --pretty=%B) [auto deploy]"

echo "Deploying..."
echo "Deploy directory: $DEPLOY_DIR"
echo "Deploy branch: $DEPLOY_BRANCH"
echo "Commit info: $COMMIT_INFO"

# Validate deploy directory
if [ ! -d "$DEPLOY_DIR" ]; then
    echo "Error: Deploy directory '$DEPLOY_DIR' does not exist."
    echo "Please clone the public repo to '$DEPLOY_DIR' or set the DEPLOY_DIR environment variable."
    exit 1
fi

# Check if deploy directory is a git repo
if [ ! -d "$DEPLOY_DIR/.git" ]; then
    echo "Error: '$DEPLOY_DIR' is not a git repository."
    exit 1
fi

# init
bundle config set --local path ~/.bundle

# build
echo "Building site..."
bundle exec jekyll build --destination "$DEPLOY_DIR"

# commit & push
cd "$DEPLOY_DIR"
echo "Pushing changes to $DEPLOY_BRANCH..."
git add -fA
git commit --allow-empty -m "$COMMIT_INFO"
git push -f -q origin "$DEPLOY_BRANCH"

# return
echo "Deployed successfully!"
cd - > /dev/null
exit 0
