#!/bin/bash

# Check if SSH agent is running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

# Check if the key is already added
ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/github | awk '{print $2}')" || ssh-add ~/.ssh/github

git add .

# Check if there are staged changes
if git diff --cached --quiet; then
  echo "No staged changes. Please stage some changes before running this script."
  exit 0
fi

# Run lint check if available
if npm run | grep -q 'lint'; then
  if ! npm run lint; then
    echo "Lint check failed. Please fix the issues before committing."
    exit 1
  fi
else
  echo "Lint script not found. Skipping lint check."
fi

# Get the diff and trim it if it's too long
diff_message=$(git diff --cached | head -c 50000)

# Generate a commit message using the trimmed diff of staged changes
commit_message=$(llm "Generate a one-line commit message summarizing the following changes:

$diff_message
")

git commit -a -m "$commit_message"
git push