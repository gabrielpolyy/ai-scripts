# AI-Scripts

A set of simple shell scripts that use AI to make git workflows easier. These tools help with code reviews and writing commit messages automatically.

## What's Included

- AI code reviews
- Smart commit messages written by AI
- Automatic SSH key handling for GitHub
- Code lint checks before commits

## The Scripts

### cr.sh (Code Review)
This script looks at your code changes and gives you helpful feedback:
- Works with different AI models (comes set to gpt-4o)
- Handles big changes by trimming them down if needed
- Shows feedback organized by file
- Points out stuff that actually matters

### push.sh
Makes pushing code way easier by:
- Setting up SSH automatically
- Checking your code for basic errors
- Writing commit messages for you based on your changes
- Pushing to GitHub in one go

## How to Use

### Code Reviews

## Installation

1. Ensure your SSH key is in the `.ssh` folder and named `github`. If not, please modify the script accordingly.

2. Create bin directory in your home folder if it doesn't exist:
   ```bash
   mkdir -p ~/bin
   ```

3. Add symbolic links to the scripts:
   ```bash
   ln -s /path/to/ai-scripts/cr.sh ~/bin/cr
   ln -s /path/to/ai-scripts/push.sh ~/bin/push
   ```

4. Add ~/bin to PATH:

   For bash:
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
   ```

   For zsh:
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
   ```

5. Reload your shell configuration:
   ```bash
   source ~/.bashrc  # for bash
   # or
   source ~/.zshrc   # for zsh
   ```

