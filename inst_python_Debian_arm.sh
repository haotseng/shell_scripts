#!/bin/bash

#
# This script can install Python from source with TclTk,OpenSSL,sqlite3 support
#
# In my ARM board(OS: Debian(Jessie) , Armbian). Build tcltk from source seems 
# can not be reconized in python. So, use apt-get to get the offcial package 
# instead of it.
#

set -e

# Check necessary packages
check_pkg()
{
    if [[ $(dpkg-query -W -f='${db:Status-Abbrev}\n' ${1} 2>/dev/null) != *ii* ]]; then 
        echo "You must install package \"$1\" before run this script"
        echo "Use \"apt-get install $1\" to install it"
        exit 1
    fi
}

check_pkg tk-dev
check_pkg tcl-dev

#
# start
#

CURR_PATH=$(pwd)
SRC_PATH=${CURR_PATH}/_work_temp/src
BUILD_PATH=${CURR_PATH}/_work_temp/build

mkdir -p $SRC_PATH
mkdir -p $BUILD_PATH

# Debugging
rm -rf $BUILD_PATH/*

#=======================
# Get source code
#=======================
OPENSSL_TAR_GZ_SRC=https://www.openssl.org/source/openssl-1.0.2l.tar.gz
OPENSSL_VER=1.0.2l

SQLITE3_TAR_GZ_SRC=http://www.sqlite.org/2017/sqlite-autoconf-3190300.tar.gz
SQLITE3_VER=3190300

PYTHON_TAR_GZ_SRC=https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
PYTHON_VER=3.6.1

#TCL_TAR_GZ_SRC=https://prdownloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz
#TCL_VER=8.6.6

#TK_TAR_GZ_SRC=https://prdownloads.sourceforge.net/tcl/tk8.6.6-src.tar.gz
#TK_VER=8.6.6

echo "Get Source code from internet, and extract them"
cd $SRC_PATH
wget $PYTHON_TAR_GZ_SRC
#wget $TCL_TAR_GZ_SRC
#wget $TK_TAR_GZ_SRC
wget $OPENSSL_TAR_GZ_SRC
wget $SQLITE3_TAR_GZ_SRC

echo "Extract file from archive files..."
cd $BUILD_PATH
tar -zxvf $SRC_PATH/Python*.tgz
#tar -zxvf $SRC_PATH/tcl*.tar.gz
#tar -zxvf $SRC_PATH/tk*.tar.gz
tar -zxvf $SRC_PATH/openssl*.tar.gz
tar -zxvf $SRC_PATH/sqlite*.tar.gz

#=======================
# Build OPEN_SSL
#=======================
OPENSSL_INST_PATH=${HOME}/bin/openssl
echo "Build OPENSSL..."
cd ${BUILD_PATH}/openssl-${OPENSSL_VER}
./config --prefix=${OPENSSL_INST_PATH}
make
make install

#=======================
# Build Sqlite3
#=======================
SQLITE3_INST_PATH=${HOME}/bin/sqlite3
echo "Build Sqlite3..."
cd ${BUILD_PATH}/sqlite-autoconf-${SQLITE3_VER}
./configure --prefix=${SQLITE3_INST_PATH}
make
make install

#=======================
# Build TCL_TK
#=======================
#TCLTK_INST_PATH=${HOME}/bin/tcltk

#echo "Build TCL..."
#cd ${BUILD_PATH}/tcl${TCL_VER}/unix
#./configure --prefix=${TCLTK_INST_PATH} --exec-prefix=${TCLTK_INST_PATH}
#make
#make install

#echo "Build TK..."
#cd ${BUILD_PATH}/tk${TK_VER}/unix
#./configure --prefix=${TCLTK_INST_PATH} --exec-prefix=${TCLTK_INST_PATH} --with-tcl=${BUILD_PATH}/tcl${TCL_VER}/unix
#make
#make install

#=======================
# Build Python
#=======================
PY_INST_PATH=${HOME}/bin/py${PYTHON_VER}
#TCLTK_INC_PATH=${TCLTK_INST_PATH}/include
#TCLTK_LIB_PATH=${TCLTK_INST_PATH}/lib
TCLTK_INC_PATH=/usr/include
TCLTK_LIB_PATH=/usr/lib
TCLTK_OPT="--with-tcltk-includes='-I${TCLTK_INC_PATH}' --with-tcltk-libs='-L${TCLTK_LIB_PATH}'"
OPENSSL_OPT="--with-ssl"
#export LD_LIBRARY_PATH=${TCLTK_LIB_PATH}
#export PATH=${TCLTK_INST_PATH}/bin:$PATH
export CPPFLAGS=-I${TCLTK_INC_PATH}

echo "Build Python..."
cd ${BUILD_PATH}/Python-${PYTHON_VER}

#
# Modified Modules/Setup.dist for SSL
#
cat << EOF >> ./Modules/Setup.dist
SSL=${OPENSSL_INST_PATH}
_ssl _ssl.c \\
       -DUSE_SSL -I\$(SSL)/include -I\$(SSL)/include/openssl \\
       -L\$(SSL)/lib -lssl -lcrypto
EOF


#
# Modified setup.py to add sqlite3 search path
#
LD_LIBRARY_PATH=${SQLITE3_INST_PATH}/lib:$LD_LIBRARY_PATH

new_path=$(echo ${SQLITE3_INST_PATH}/include | sed 's/\//\\\//g')
#echo $NEW_PATH

search_pattern="s/\(sqlite_inc_paths.*\[.\)\('.*'\)/\1'${new_path}',\2/g"
#echo ${search_pattern}

cmd="sed \"${search_pattern}\" setup.py > setup.py.new"
#echo $cmd

cp setup.py setup.py.old
eval $cmd
cp setup.py.new setup.py

#
# Build
#
./configure --prefix=${PY_INST_PATH} ${TCLTK_OPT}
make
make install

#=======================
# Done
#=======================
echo "Done"

#
# Remove working directory
#
cd $BUILD_PATH
rm -rf *

# exit
cd $CURR_PATH





