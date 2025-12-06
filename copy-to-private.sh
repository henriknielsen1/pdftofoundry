#!/bin/bash

# Helper script to copy this repository to a private GitHub repository
# Usage: ./copy-to-private.sh <your-username> <new-repo-name>

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if correct number of arguments provided
if [ "$#" -ne 2 ]; then
    print_error "Usage: $0 <your-github-username> <new-repo-name>"
    echo "Example: $0 johndoe pdftofoundry-private"
    exit 1
fi

GITHUB_USERNAME=$1
NEW_REPO_NAME=$2
NEW_REPO_URL="https://github.com/${GITHUB_USERNAME}/${NEW_REPO_NAME}.git"

print_info "This script will help you copy this repository to a private GitHub repository."
echo ""
print_warning "Prerequisites:"
echo "  1. You must have already created the private repository on GitHub"
echo "  2. Repository URL: ${NEW_REPO_URL}"
echo "  3. Make sure the repository is empty (no README, .gitignore, or license)"
echo ""

# Confirm before proceeding
read -p "Have you created the empty private repository on GitHub? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Please create the repository first at: https://github.com/new"
    print_warning "Make sure to:"
    echo "  - Set visibility to 'Private'"
    echo "  - Do NOT initialize with README, .gitignore, or license"
    exit 1
fi

print_info "Checking if we're in a git repository..."
if [ ! -d .git ]; then
    print_error "Not in a git repository. Please run this script from the repository root."
    exit 1
fi

print_info "Checking current git status..."
git status

print_info "Adding new private repository as remote 'private'..."
if git remote | grep -q "^private$"; then
    print_warning "Remote 'private' already exists. Removing it first..."
    git remote remove private
fi
git remote add private "${NEW_REPO_URL}"

print_info "Verifying the remote repository is accessible..."
if ! git ls-remote "${NEW_REPO_URL}" &> /dev/null; then
    print_error "Cannot access the repository at ${NEW_REPO_URL}"
    print_error "Please verify:"
    echo "  1. The repository exists and is empty"
    echo "  2. You have access to the repository"
    echo "  3. Your GitHub credentials are configured correctly"
    git remote remove private
    exit 1
fi
print_info "✓ Repository is accessible"

print_info "Fetching all branches and tags..."
git fetch --all

print_info "Pushing all branches to the new private repository..."
if git push private --all; then
    print_info "✓ Successfully pushed all branches"
else
    print_error "Failed to push branches. Please check your credentials and repository URL."
    exit 1
fi

print_info "Pushing all tags to the new private repository..."
if git push private --tags; then
    print_info "✓ Successfully pushed all tags"
else
    print_warning "Failed to push tags (this may be okay if there are no tags)"
fi

echo ""
print_info "========================================="
print_info "✓ Repository successfully copied!"
print_info "========================================="
echo ""
echo "Your private repository is now available at:"
echo "  https://github.com/${GITHUB_USERNAME}/${NEW_REPO_NAME}"
echo ""
print_info "Next steps (optional):"
echo ""
echo "1. To make the private repository your default remote:"
echo "   git remote rename origin old-origin"
echo "   git remote rename private origin"
echo ""
echo "2. To keep your private copy updated with this repository:"
echo "   git remote add upstream https://github.com/henriknielsen1/pdftofoundry.git"
echo "   git fetch upstream"
echo "   git merge upstream/main  # or the appropriate branch"
echo "   git push origin main"
echo ""
echo "3. To verify the copy:"
echo "   git clone ${NEW_REPO_URL}"
echo "   cd ${NEW_REPO_NAME}"
echo "   git log --oneline -10"
echo ""
print_info "For more detailed instructions, see COPYING_TO_PRIVATE_REPO.md"
