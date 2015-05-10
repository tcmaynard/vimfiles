#/bin/sh

# If required (on Linux systems) run this file to call
# `dos2unix` on every file here and below
#
# Options:
#   -f  force (ignore perceived binary-ness)
#   -k  keepdate
#   -o  oldfile (don't change the file's date)

find . -type f -exec dos2unix -f -k -o {} ';'
