#!/usr/bin/env bash

generate_password() {
    local len=${1}
    local symbols="!@#$%^&*()-_=+[]{};:,./?"
    local letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local numbers="0123456789"
    local all="$symbols$letters$numbers"
    local password=""
    
    for ((i = 0; i < len; i++)); do
        index=$((RANDOM % ${#all}))
        password+="${all:index:1}"
    done

    echo "$password"
}

generate_password "$1"
