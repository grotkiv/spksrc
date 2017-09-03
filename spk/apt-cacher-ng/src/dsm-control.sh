#!/bin/sh

# Package
PACKAGE="apt-cacher-ng"
DNAME="apt-cacher-ng"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/sbin:${PATH}"
USER="apt-cacher-ng"
ACNG="${INSTALL_DIR}/usr/local/sbin/apt-cacher-ng"
CONF_DIR="${INSTALL_DIR}/usr/local/etc/apt-cacher-ng"
CACHE_DIR="${INSTALL_DIR}/var/cache/apt-cacher-ng"
LOG_DIR="${INSTALL_DIR}/var/log/apt-cacher-ng"
PID_FILE="${INSTALL_DIR}/var/run/apt-cacher-ng/pid"
SOCKET_FILE="${INSTALL_DIR}/var/run/apt-cacher-ng/socket"


start_daemon ()
{
    # using sudo because 'su -' is not working with DSM > v6
    sudo -u ${USER} PATH=${PATH} ${ACNG} -c ${CONF_DIR} \
	    CacheDir=${CACHE_DIR} \
	    LogDir=${LOG_DIR} \
	    PidFile=${PID_FILE} \
	    SocketPath=${SOCKET_FILE}
}

stop_daemon ()
{
    kill `cat ${PID_FILE}`
    wait_for_status 1 20 || kill -9 `cat ${PID_FILE}`
    rm -f ${PID_FILE}
}

daemon_status ()
{
    if [ -f ${PID_FILE} ] && kill -0 `cat ${PID_FILE}` > /dev/null 2>&1; then
        return
    fi
    rm -f ${PID_FILE}
    return 1
}

wait_for_status ()
{
    counter=$2
    while [ ${counter} -gt 0 ]; do
        daemon_status
        [ $? -eq $1 ] && return
        let counter=counter-1
        sleep 1
    done
    return 1
}


case $1 in
    start)
        if daemon_status; then
            echo ${DNAME} is already running
            exit 0
        else
            echo Starting ${DNAME} ...
            start_daemon
            exit $?
        fi
        ;;
    stop)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_daemon
            exit $?
        else
            echo ${DNAME} is not running
            exit 0
        fi
        ;;
    restart)
        stop_daemon
        start_daemon
        exit $?
        ;;
    status)
        if daemon_status; then
            echo ${DNAME} is running
            exit 0
        else
            echo ${DNAME} is not running
            exit 1
        fi
        ;;
    *)
        exit 1
        ;;
esac
