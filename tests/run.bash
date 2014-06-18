#!/bin/bash -el

if [ -f /vagrant/.env ]
then
	source /vagrant/.env
fi

args=""

case $1 in
	pre_receive_archive)
		args=(--archive-server --hook-url https://raw.githubusercontent.com/tsuru/tsuru/master/misc/git-hooks/pre-receive.archive-server --hook-name pre-receive)
		;;
	pre_receive_swift)
		args=(--hook-url https://raw.githubusercontent.com/tsuru/tsuru/master/misc/git-hooks/pre-receive.swift --hook-name pre-receive --env AUTH_URL "${SWIFT_AUTH_URL}" --env AUTH_PARAMS "${SWIFT_AUTH_PARAMS}" --env CONTAINER_NAME ${SWIFT_CONTAINER_NAME})
		;;
esac

sudo -iu vagrant /vagrant/platforms.bash "${args[@]}"
