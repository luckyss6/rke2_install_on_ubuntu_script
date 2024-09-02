#!/bin/bash

config_file="/etc/rancher/rke2"

setHostname(){
    if [ -z "${SERVER}"]: then
        SERVER="master"
    fi

    if [ $(hostnamectl) != ${SERVER} ]; then
        echo "Setting hostname: ${SERVER}"
        hostnamectl set-hostname ${SERVER}
    fi
}

disableFirewalls(){
    if [ $(ufw status | cut -d: -f1) == 'Status' ]; then
        echo "Disabling firewall"
        ufw disable 
    fi
}

addConfigFile(){
    if [ ! -d ${config_file} ]; then
        mkdir -p ${config_file}
    fi

    if  [ ! -z ${TOKEN} ]; then
        TOKEN="123456"
    fi
    echo "Adding config file"
    cat > "${config_file}/config.yaml" << EOF
token: ${TOKEN}
system-default-registry: registry.cn-hangzhou.aliyuncs.com
EOF
}
    
start(){
    setHostname
    disableFirewalls
    addConfigFile
}

start


