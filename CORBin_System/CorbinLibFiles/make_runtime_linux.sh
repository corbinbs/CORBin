#!/bin/sh

echo "Building the runtime system for the first time..."
cd ../SML_NJ_install/src/runtime/objs
gmake -f mk.x86-linux-ccalls
cd -
echo "Done."
echo "Initial runtime build complete."
 
