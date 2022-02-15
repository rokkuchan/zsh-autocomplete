#!/bin/bash

_autocomplete_options='run stop kill start'
complete -W "${_autocomplete_options}" 'rabbit' 


function rabbit() {
    set -e 
    if [ -z "$1" ]; then
        echo "No Args Supplied"
        return
    fi
    $1_rabbit
}

function run_rabbit {
    echo "Running Rabbit"
}

function stop_rabbit {
    local STATUS_STRING=$(_rabbit_status)

    echo "Stopping Rabbit"
}

function kill_rabbit {
    echo "Killing Rabbit"
    set -e 
    local STATUS_STRING=$(_rabbit_status)
    if [ ${STATUS_STRING} == "DEAD" ]; then
        echo "Cannot kill what is already dead"
        return 
    fi
    if [ ${STATUS_STRING} == "RUNNING" ]; then
        echo "Stop the Rabbit first"
        return 
    fi
    if [ ${STATUS_STRING} == "STOPPED" ]; then
        docker rm rabbit-docker
    fi
}

function start_rabbit {
    local STATUS_STRING=$(_rabbit_status)
    echo $STATUS_STRING
    echo "Starting Rabbit"
    set -e 
    local STATUS_STRING=$(_rabbit_status)
    if [ "${STATUS_STRING}" == "DEAD" ]; then
        echo "It's dead jim"
        return 
    fi
    if [ "${STATUS_STRING}" == "RUNNING" ]; then
        echo "He's already moving"
        return 
    fi
    if [ "${STATUS_STRING}" == "STOPPED" ]; then
        docker start rabbit-docker
    fi
}

function _rabbit_status {
    local rabbit_string="$(docker ps | grep "rabbit-docker" 2> /dev/null)"
    if [ -z "${rabbit_string}" ]; then
        return "DEAD"
    fi
    IFS='\t'
    read -a strarr << "${rabbit_string}"
    echo "${strarr[4]}"
    # if [ ]
    # echo ${rabbit_string}
}