#!/bin/bash
#This script will update the release notes.
version=$1
sed -i '2 a\- [Release notes for UniConfig '$version'](../release-notes/uniconfig-'$version'.md)' ./index.md
