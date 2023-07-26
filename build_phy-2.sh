#!/bin/bash
debug=${1:-"release"}
rebuild=${2:-"fast"}
# LOAD REQUIRED MODULES
module load intel/2017.1.132 
module load openmpi-intel/2.0.1-ifort-2017.1.132
module load netcdf/4.7.4-intel_2017

# GET IOW ESM ROOT PATH
export IOW_ESM_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../.."

# SET SYSTEM-SPECIFIC COMPILER OPTIONS AND PATHS
# compile mode: "PRODUCTION" or "DEBUG"
if [ $debug == "debug" ]; then
	export IOW_ESM_COMPILE_MODE="DEBUG"
elif [ $debug == "release" ]; then
	export IOW_ESM_COMPILE_MODE="PRODUCTION"
else
	echo "Compile mode is not specified correctly. Use debug or release"
	exit;
fi

# include paths
export IOW_ESM_NETCDF_INCLUDE="${NETCDF_INC}"
export IOW_ESM_NETCDF_LIBRARY="${NETCDF_LIB}"
# executables
export IOW_ESM_MAKE="/usr/bin/make"
export IOW_ESM_FC="mpifort"
export IOW_ESM_LD="mpifort"
# compiler flags
if [ $debug == "debug" ]; then
	export IOW_ESM_FFLAGS="-O1 -ftrapuv -fp-model strict -g -traceback -check all -xHost -save-temps"
else
	export IOW_ESM_FFLAGS="-O3 -no-prec-div -fp-model fast=2 -xHost -save-temps"
fi
export IOW_ESM_LDFLAGS="-Wl,-rpath,${IOW_ESM_NETCDF_LIBRARY} -g -traceback"

# MAKE CLEAN
if [ $rebuild == "rebuild" ]; then
	rm -r ${IOW_ESM_ROOT}/tools/I2LM/int2lm/obj_${IOW_ESM_COMPILE_MODE}
	rm -r ${IOW_ESM_ROOT}/tools/I2LM/int2lm/work_${IOW_ESM_COMPILE_MODE}
	rm -r ${IOW_ESM_ROOT}/tools/I2LM/int2lm/bin_${IOW_ESM_COMPILE_MODE}
	
	rm -r ${IOW_ESM_ROOT}/tools/I2LM/utils/cfu/obj
	rm -r ${IOW_ESM_ROOT}/tools/I2LM/utils/cfu/bin
fi

mkdir -p ${IOW_ESM_ROOT}/tools/I2LM/int2lm/obj_${IOW_ESM_COMPILE_MODE}
mkdir -p ${IOW_ESM_ROOT}/tools/I2LM/int2lm/work_${IOW_ESM_COMPILE_MODE}
mkdir -p ${IOW_ESM_ROOT}/tools/I2LM/int2lm/bin_${IOW_ESM_COMPILE_MODE}

mkdir -p ${IOW_ESM_ROOT}/tools/I2LM/utils/cfu/obj
mkdir -p ${IOW_ESM_ROOT}/tools/I2LM/utils/cfu/bin

# RUN BUILD COMMAND
cd ${IOW_ESM_ROOT}/tools/I2LM/int2lm
${IOW_ESM_MAKE}
cd ${IOW_ESM_ROOT}/tools/I2LM

cd ${IOW_ESM_ROOT}/tools/I2LM/utils/cfu
${IOW_ESM_MAKE}
cd ${IOW_ESM_ROOT}/tools/I2LM

