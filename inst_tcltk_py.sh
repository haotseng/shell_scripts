#!/bin/bash

#
# This script can install Python with TclTk from source
#

set -e
CURR_PATH=$(pwd)
SRC_PATH=${CURR_PATH}/_work_temp/src
BUILD_PATH=${CURR_PATH}/_work_temp/build

mkdir -p $SRC_PATH
mkdir -p $BUILD_PATH


#
# Source code
#
PYTHON_TAR_GZ_SRC=https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
PYTHON_VER=3.6.1
TCL_TAR_GZ_SRC=https://prdownloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz
TCL_VER=8.6.6
TK_TAR_GZ_SRC=https://prdownloads.sourceforge.net/tcl/tk8.6.6-src.tar.gz
TK_VER=8.6.6

echo "Get Source code from internet, and extract them"
cd $SRC_PATH
wget $PYTHON_TAR_GZ_SRC
wget $TCL_TAR_GZ_SRC
wget $TK_TAR_GZ_SRC

echo "Extract file from archive files..."
cd $BUILD_PATH
tar -zxvf $SRC_PATH/Python*.tgz
tar -zxvf $SRC_PATH/tcl*.tar.gz
tar -zxvf $SRC_PATH/tk*.tar.gz


#
# Build TCL_TK
#
TCLTK_INST_PATH=${HOME}/bin/tcltk

echo "Build TCL..."
cd ${BUILD_PATH}/tcl${TCL_VER}/unix
./configure --prefix=${TCLTK_INST_PATH} --exec-prefix=${TCLTK_INST_PATH}
make
make install

echo "Build TK..."
cd ${BUILD_PATH}/tk${TK_VER}/unix
./configure --prefix=${TCLTK_INST_PATH} --exec-prefix=${TCLTK_INST_PATH} --with-tcl=${BUILD_PATH}/tcl${TCL_VER}/unix
make
make install

#
# Build Python
#
PY_INST_PATH=${HOME}/bin/py${PYTHON_VER}
TCLTK_INC_PATH=${TCLTK_INST_PATH}/include
TCLTK_LIB_PATH=${TCLTK_INST_PATH}/lib
TCLTK_OPT="--with-tcltk-includes='-I${TCLTK_INC_PATH}' --with-tcltk-libs='-L${TCLTK_LIB_PATH}'"
#export LD_LIBRARY_PATH=${TCLTK_LIB_PATH}
#export PATH=${TCLTK_INST_PATH}/bin:$PATH
export CPPFLAGS=-I${TCLTK_INC_PATH}

echo "Build Python..."
cd ${BUILD_PATH}/Python-${PYTHON_VER}
./configure --prefix=${PY_INST_PATH} ${TCLTK_OPT}
make
make install

echo "Done"

#
# Remove working directory
#
cd $BUILD_PATH
rm -rf *

# exit
cd $CURR_PATH





