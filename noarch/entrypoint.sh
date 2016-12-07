#!/bin/sh

#HOME=CONFIG

CFG=/home/user/.config/transmission-daemon/settings.json
if [ ! -f "$CFG" ]; then
  $APP_BIN -d  > $CFG  2>&1
fi
#FIX rpc whitelist
sed 's/.*"rpc-whitelist-enabled": \(.*\),/"rpc-whitelist-enabled": false,/p' -i $CFG
sed 's@.*"incomplete-dir": "\(.*\)",@"incomplete-dir": "/downloads/incomplete",@p' -i $CFG
sed 's@.*"download-dir": "\(.*\)",@"download-dir": "/downloads",@p' -i $CFG


/usr/bin/set_user.sh

CMD="$APP_BIN $APP_ARGS $@"
echo call "$CMD"
su user -c "$CMD"
