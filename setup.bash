set -e # stop on error


# Import Ubuntu VM with one interface (NAT) and install required software.
# Change network card to host only (the address should be assigned via DHCP server of the VirtualBox) 

REPOS_DIR = "/var/lib/svn"
REPO_1 = "ask_188603"
REPO_2 = "pile_of_files"
ACCESSFILE = "/etc/apache2/dav_svn.authz"
HTPASSWD = "/etc/apache2/dav_svn.passwd"

rm -f $HTPASSWD
htpasswd -bc $HTPASSWD user1 ask
htpasswd -b $HTPASSWD user2 ask

cp files/dav_svn.conf > /etc/apache2/mods-enabled/dav_svn.conf

# configure the repository using SVNParentPath directive. Show the Revision 0: / page.

# 3. Create 2 repositories and 2 users. The name of one repository must contain the student ID number. 

mkdir -p "$REPOS_DIR/$REPO_1"
svnadmin create "$REPOS_DIR/$REPO_1"

mkdir -p "$REPOS_DIR/$REPO_2"
svnadmin create "$REPOS_DIR/$REPO_2"

# User 1 should have rw access to repository 1 and r access to repository 2. User 2 should have rw access to repository 2 and no access to repository 1.

cp files/dav_svn.authz > /etc/apache2/mods-enabled/dav_svn.authz

# 4. Secure all the files so that only Apache user will have access to them

chown www-data:www-data "$REPOS_DIR" -R
chmod u+rwx "$REPOS_DIR" -R
chmod og-rwxX "$REPOS_DIR" -R

systemctl restart apache2