# How to Copy This Fork to a Private GitHub Repository

This guide provides step-by-step instructions for copying this forked repository to a private GitHub repository.

## Prerequisites

- Git installed on your local machine
- GitHub account with permissions to create private repositories
- GitHub CLI (`gh`) installed (optional, but recommended)

## Method 1: Using GitHub CLI (Recommended)

The GitHub CLI provides the easiest way to create and push to a new private repository.

### Steps:

1. **Clone this repository locally (if not already done):**
   ```bash
   git clone https://github.com/henriknielsen1/pdftofoundry.git
   cd pdftofoundry
   ```

2. **Create a new private repository on GitHub:**
   ```bash
   gh repo create your-username/pdftofoundry-private --private --source=. --remote=private
   ```
   
   Replace `your-username` with your GitHub username and `pdftofoundry-private` with your desired repository name.

3. **Push all branches to the new private repository:**
   ```bash
   git push private --all
   git push private --tags
   ```

4. **Set the new private repository as the default remote (optional):**
   ```bash
   git remote rename origin old-origin
   git remote rename private origin
   ```

## Method 2: Using Git Commands

If you prefer not to use the GitHub CLI, you can create the repository manually through the GitHub web interface and then push to it.

### Steps:

1. **Clone this repository locally (if not already done):**
   ```bash
   git clone https://github.com/henriknielsen1/pdftofoundry.git
   cd pdftofoundry
   ```

2. **Create a new private repository on GitHub:**
   - Go to https://github.com/new
   - Enter a repository name (e.g., `pdftofoundry-private`)
   - Select "Private" visibility
   - **Do not** initialize with README, .gitignore, or license
   - Click "Create repository"

3. **Add the new private repository as a remote:**
   ```bash
   git remote add private https://github.com/your-username/pdftofoundry-private.git
   ```
   
   Replace `your-username` with your GitHub username and `pdftofoundry-private` with your repository name.

4. **Push all branches and tags to the new private repository:**
   ```bash
   git push private --all
   git push private --tags
   ```

5. **Set the new private repository as the default remote (optional):**
   ```bash
   git remote rename origin old-origin
   git remote rename private origin
   ```

## Method 3: Import via GitHub Web Interface

GitHub provides an import feature that can copy repositories, including all history.

### Steps:

1. **Go to GitHub's import page:**
   - Navigate to https://github.com/new/import

2. **Enter the repository URL:**
   - In "Your old repository's clone URL", enter: `https://github.com/henriknielsen1/pdftofoundry`

3. **Configure the new repository:**
   - Choose your GitHub account as the owner
   - Enter a name for the new repository
   - Select "Private" visibility
   - Click "Begin import"

4. **Wait for the import to complete:**
   - GitHub will email you when the import is finished
   - This may take several minutes depending on the repository size

5. **Clone your new private repository:**
   ```bash
   git clone https://github.com/your-username/pdftofoundry-private.git
   ```

## Method 4: Mirror Repository (Advanced)

For a complete mirror including all refs, branches, and tags:

1. **Create a bare clone of the repository:**
   ```bash
   git clone --bare https://github.com/henriknielsen1/pdftofoundry.git
   cd pdftofoundry.git
   ```

2. **Create the new private repository on GitHub** (via web interface or CLI)

3. **Mirror-push to the new repository:**
   ```bash
   git push --mirror https://github.com/your-username/pdftofoundry-private.git
   ```

4. **Remove the bare clone and clone the new repository:**
   ```bash
   cd ..
   rm -rf pdftofoundry.git
   git clone https://github.com/your-username/pdftofoundry-private.git
   ```

## Maintaining the Private Copy

### Syncing Updates from the Original Repository

If you want to keep your private copy updated with changes from this fork:

1. **Add the original repository as a remote:**
   ```bash
   git remote add upstream https://github.com/henriknielsen1/pdftofoundry.git
   ```

2. **Fetch and merge updates:**
   ```bash
   git fetch upstream
   git merge upstream/main
   # or use the branch name that exists (e.g., master)
   ```

3. **Push updates to your private repository:**
   ```bash
   git push origin main
   ```

### Syncing from the Original Upstream (fryguy1013)

To get updates from the original pdftofoundry project:

1. **Add the original project as a remote:**
   ```bash
   git remote add original-upstream https://github.com/fryguy1013/pdftofoundry.git
   ```

2. **Fetch and merge updates:**
   ```bash
   git fetch original-upstream
   git merge original-upstream/main
   ```

3. **Push to your private repository:**
   ```bash
   git push origin main
   ```

## Important Considerations

### Licensing
- This repository is licensed under the terms in the LICENSE file
- Ensure you comply with the license terms when creating a private copy
- The README states "For personal use only"

### Fork Relationship
- Creating a private copy will not maintain the fork relationship with the original repository
- If you want to contribute back to the original project, you'll need to keep the public fork
- Consider keeping both: a public fork for contributions and a private copy for personal modifications

### Repository Size
- Be aware of GitHub's repository size limits
- This repository may contain binary files (PDFs, images) which can increase the size
- Private repositories on free GitHub accounts have storage limits

## Troubleshooting

### Authentication Issues
If you encounter authentication issues when pushing:

```bash
# Use SSH instead of HTTPS
git remote set-url private git@github.com:your-username/pdftofoundry-private.git
```

Or set up a Personal Access Token (PAT) for HTTPS authentication.

### Large File Issues
If you encounter issues with large files:

```bash
# Check the size of the repository
du -sh .git

# Consider using Git LFS for large files if needed
git lfs install
```

### Branch Issues
If the default branch is not `main`:

```bash
# Check the default branch
git branch -r

# Push the correct branch
git push private master  # or whatever the default branch is
```

## Verification

After copying, verify that your private repository contains all the expected content:

1. **Check branches:**
   ```bash
   git branch -r
   ```

2. **Check tags:**
   ```bash
   git tag -l
   ```

3. **Verify commit history:**
   ```bash
   git log --oneline -20
   ```

## Additional Resources

- [GitHub: Duplicating a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository)
- [GitHub: About repository visibility](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility)
- [GitHub CLI Documentation](https://cli.github.com/manual/)

## Questions or Issues?

If you encounter any issues during the copying process, please refer to GitHub's official documentation or seek help from the GitHub community.
