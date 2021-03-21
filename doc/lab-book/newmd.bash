#!/bin/bash
name=`date -u +%y%m%d%H%M%SZ`.md
cp `ls *Z.md | tail -1` $name
echo $name
