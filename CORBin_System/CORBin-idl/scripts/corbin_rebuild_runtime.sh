#!/bin/sh
SML_RUNTIME_OBJS=/home/corbinbs/masters_proj/CORBin/sml_nj/src/runtime/objs
SML_RUNTIME_BIN=/home/corbinbs/masters_proj/CORBin/sml_nj/bin/.run

echo "Begining the SML-NJ Runtime System rebuild process..." 
cd $SML_RUNTIME_OBJS
rm -f *.o
make -f mk.x86-linux-ccalls >& /dev/null
cp run.x86-linux $SML_RUNTIME_BIN 
echo "SML-NJ Runtime System rebuild process complete" 
