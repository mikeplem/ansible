#!/usr/bin/env bash

if [ "$REQUEST_METHOD" = "POST" ]; then
    if [ "$CONTENT_LENGTH" -gt 0 ]; then
        read -N $CONTENT_LENGTH POST_DATA <&0
    else
      exit 1
    fi
fi

# replace _ with :
WOL_MAC_TEXT=$(echo "${POST_DATA//_/:}")
# strip off 'macaddress='
WOL_MAC=$(echo "${WOL_MAC_TEXT:11}")

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<meta name="viewport" content="width=device-width, initial-scale=2" />'
echo '<meta http-equiv="refresh" content="15; URL=http://wol.local/">'
echo '<title>Wake On Lan</title>'
echo '</head>'
echo '<body>'

echo '<h3>'
wakeonlan "${WOL_MAC}"
echo '</h3>'

echo '</body>'
echo '</html>'

exit 0
