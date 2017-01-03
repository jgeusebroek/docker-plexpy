#!/bin/sh
set -x

USERNAME=${USERNAME:=plexpy}
GROUP=${GROUP:=plexpy}

# Add user if it does not exist
if ! id -u "${USERNAME}" >/dev/null 2>&1; then
	addgroup -g ${USER_GID:=4000} ${GROUP}
	adduser -G ${GROUP} -D -u ${USER_UID:=4000} ${USERNAME}
fi

touch /config/plexpy.cfg
mkdir -p /config/datadir
chown -R ${USERNAME}:${GROUP} /config

# Update to latest version on every start
cd /opt/plexpy && git fetch origin master && git reset --hard

sudo -u ${USERNAME} -E sh -c "/opt/plexpy/PlexPy.py --config /config/plexpy.cfg --datadir /config/data $@"