#!/bin/sh

command="fpc Main.pas -FUCompiled"

for dir in $(ls -d */ | grep -o '[^/]*'); do
   command="$command -Fu$dir"
done

eval $command

