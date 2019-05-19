#!/bin/bash
#
# Requires: bash, wget, grep, sed, tar, xutils, gpg, rev, cut, java
#

##change wget variable to VAR32 or VAR64 depending on if your system is 32 or 64bit

##Get the download link
VAR32=$(wget -q -O - https://www.java.com/en/download/linux_manual.jsp | grep -o '<a title="Download Java software for Linux" href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a title="Download Java software for Linux" href=["'"'"']//' -e 's/["'"'"']$//' | head -n -1)
VAR64=$(wget -q -O - https://www.java.com/en/download/linux_manual.jsp | grep -o '<a title="Download Java software for Linux x64" href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a title="Download Java software for Linux x64" href=["'"'"']//' -e 's/["'"'"']$//' | head -n -1)

##remove any old version
rm -r java 2> /dev/null

##download
mkdir tmp
cd tmp
wget --trust-server-names "$VAR64"
FILE=$(ls | cut -f1 -d"?")
echo "$FILE" > ../version

##extract
FILE2=$(ls)
mv $FILE2 $FILE
tar -xf "$FILE"
FILE3=$(ls -d */)
mv $FILE3 ../java
cd ../

##cleanup
rm -r tmp

echo "Done, if no errors above"
