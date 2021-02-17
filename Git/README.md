# Git

## Hook templates

- **[post-receive]** - a template for deploying static websites to the server

**Usage**:

1. After connecting to the server, create two directories:
   - for Git's bare repository
   - for Git's working directory _(build output)_

   ```bash
   sudo mkdir --parents /var/repo/<website name>.git
   sudo mkdir --parents /var/www/html/<website name>
   ```

2. Change the ownership for these two directories. For example:

   ```bash
   chown --recursive <username> /var/repo/<website name>.git
   chown --recursive <username> /var/www/html/<website name>
   ```

3. Initiate the Git bare repository:

   ```bash
   cd /var/repo/<website-name>.git
   git init --bare
   ```

4. Go to the directory for Git hooks.

   ```bash
   cd ./hooks
   ```

5. Download this hook template with this command:

   ```bash
   curl --remote-name https://raw.githubusercontent.com/xeho91/.dotfiles/main/Git/post-receive
   ```

6. Edit the variables in this Git hook's file and save changes.

   ```bash
   vi ./post-receive
   ```

7. Make this hook executable:

   ```bash
   chmod +x post-receive
   ```

8. In your local repository, add this remote repository:

   ```bash
   git remote add <repository alias> ssh://<username>@<ip or hostname>/var/repo/<website name>.git
   ```

[post-receive]: "./post-receive"
