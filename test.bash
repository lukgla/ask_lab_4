#5. Send some (empty) files to the repositories (at least 1 to each repository using
# user1 and user 2 respectively). Show the content of the repositories in the web browser.

URL_ROOT = "http://192.168.56.101/svn"
REPO_1 = "ask_188603"
REPO_2 = "pile_of_files"
URL_REPO_1 = "$URL_ROOT/$REPO_1"
URL_REPO_2 = "$URL_ROOT/$REPO_2"

cd ~/Desktop/repos/
svn checkout $URL_REPO_1 repo11 --username user1
cd repo11
touch u1
svn add u1
svn commit -m "r11_u1"
cd ..

# fail (no read access)
svn checkout $URL_REPO_1 repo12 --username user2

# fail (no write access)
svn checkout $URL_REPO_2 repo21 --username user1
cd repo21
touch u1
svn add u1
svn commit -m "r21_u1"
cd ..

svn checkout $URL_REPO_2 repo22 --username user2
cd repo22
touch u2
svn add u2
svn commit -m "r22_u2"
cd ..


