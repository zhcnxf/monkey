#! /usr/bin/env bash

CMD=$0
DIR=`dirname $CMD`

help() {
    echo "Usage $CMD -e <count> [-m <email>] [-d]"
    echo "  -e --events    <count>    specify event count"
    echo "  -m --mailto    <email>    send email of reports, <email>=email addresses,"
    echo "                            like: someone@somedomain,another@somedomain"
    echo "  -d --debug                debug mode"
}

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
    -m|--mailto)
        MAIL="$2"
        [ "$MAIL" == '' ] && help && exit 1
        shift
        shift
        ;;
    -e|--events)
        EVENTS="$2"
        [ "$EVENTS" == '' ] && help && exit 1
        shift
        shift
        ;;
    -d|--debug)
        DEBUG='--stacktrace'
        shift
        ;;
    *)
        help && exit 1
        ;;
    esac
done

if [[ "$EVENTS" == '' ]]; then
    help
    exit 1
fi

$DIR/gradlew monkey $DEBUG "-Pevents=$EVENTS" "-Pdevelopers=$MAIL"