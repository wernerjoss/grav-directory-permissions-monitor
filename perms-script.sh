#!/bin/bash

# Customize these
WEB_DIR="/var/www/html/user"
OWNER="www-data"
GROUP="1000"
DIR_PERMS="775"
FILE_PERMS="664"

# Change ownership for both files and directories
chown -R $OWNER:$GROUP $WEB_DIR

# Update directory permissions to 775
# find $WEB_DIR -type d -print0 | xargs -0 chmod $DIR_PERMS	# this does not work for me, changed to exec...
find $WEB_DIR -type d -exec chmod $DIR_PERMS {} \+

# Update file permissions to 664
# find $WEB_DIR -type f -print0 | xargs -0 chmod $FILE_PERMS
find $WEB_DIR -type f -exec chmod $FILE_PERMS {} \+

chmod +x $WEB_DIR/../bin/*
# Add custom file permissions below. Example:

# find $WEB_DIR -type f -name 'wp-config.php' -print0 | xargs -0 chmod 640
