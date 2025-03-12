#!/bin/sh
rm *.o *.ppu Main

# this is somehow the most convenient way to list only dirs
for dir in $(ls -d */); do
   # does not glob in string
   rm $dir*.o $dir*.ppu
done
