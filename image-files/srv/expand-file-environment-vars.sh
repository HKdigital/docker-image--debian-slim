#!/bin/bash

#
# This scripts creates environment variables from docker secrets.
#
# --
#
# Define the secret in the Docker YML file as follows:
#
# secrets:
#  SOME_SECRET:
#    external: true
#
# services:
#   my_service:
#     secrets:
#       - SOME_SECRET
#
#     environment:
#       SOME_SECRET_FILE: /run/secrets/SOME_SECRET
#
# --
#
# - This script will check if environment variables have been set that end
#   with "_FILE".
# - If so, the script will look for a file at the path
#   specified by the variable.
# - If a file was found, a new environment variable will be created without the
#   "_FILE" appendix.
# - The value of the variable will be the file contents
#
# --
#
# Run this script as follows (otherwise it won't work):
#
# source ./expand-file-environment-vars.sh
#

expandFileEnvironmentVars() {
  local envVar
  local key
  local path
  local newKey
  local value

  for envVar in $(env); do
    key=`echo "$envVar" | cut -d "=" -f 1`

    if [[ $key == *_FILE ]]
    then
      path=`echo "$envVar" | cut -d "=" -f 2`
      newKey=${key::-5}

      if [[ -f "${path}" ]]
      then
        echo "Setting environment variable [${newKey}] from file [${path}]"
        value=`cat "${path}"`
        # echo "${newKey} => ${value}"
        export "${newKey}"="${value}"

        # unset "$key"
      else
        echo "Cannot set environment variable [${newKey}] from file [${path}] (file not found)"
      fi
    fi
  done
}

expandFileEnvironmentVars
