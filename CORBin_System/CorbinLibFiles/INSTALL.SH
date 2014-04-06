#!/bin/sh

echo "Installing the CORBin Library..."
cp CORBin_Lib_Files.zip ../SML_NJ_install/src/runtime/c-libs/smlnj-ccalls
cd ../SML_NJ_install/src/runtime/c-libs/smlnj-ccalls
unzip CORBin_Lib_Files.zip
cd -
echo "Done."
echo "Installing the necessary Makefiles..."
cp Makefiles.zip ../SML_NJ_install/src/runtime/objs
cd ../SML_NJ_install/src/runtime/objs
unzip Makefiles.zip
cd -
echo "Done."
echo "Library install complete."
 
