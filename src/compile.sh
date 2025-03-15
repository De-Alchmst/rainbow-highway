#!/bin/sh

command="fpc Main.pas -FUCompiled"

if [ $# -ne 1 ]; then
   echo "Usage:"
   echo "  compile.sh {-s|-d}"
   echo "     -s     link raylib statically"
   echo "     -d     link raylib dynamically"
   echo ""
   echo "Before recompiling in the other mode, run './clear.sh'"
   exit 1
fi

if [ $1 = '-s' ]; then
   command="$command -dSTATIC"
fi

for dir in $(ls -d */ | grep -o '[^/]*'); do
   command="$command -Fu$dir"
done

eval $command
