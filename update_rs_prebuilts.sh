#!/bin/bash

# We are currently in frameworks/rs, so compute our top-level directory.
MY_ANDROID_DIR=$PWD/../../
cd $MY_ANDROID_DIR

if [ $OSTYPE == 'darwin13' ];
then

  DARWIN=1
  SHORT_OSNAME=darwin
  SONAME=dylib
  # Only build arm on darwin.
  TARGETS=(arm)
  SYS_NAMES=(generic)
  NUM_CORES=`sysctl -n hw.ncpu`

else

  DARWIN=0
  SHORT_OSNAME=linux
  SONAME=so
  # Target architectures and their system library names.
  TARGETS=(arm mips x86)
  SYS_NAMES=(generic generic_mips generic_x86)
  NUM_CORES=`cat /proc/cpuinfo | grep processor | tail -n 1 | cut -f 2 -d :`
  NUM_CORES=$(($NUM_CORES+1))

fi

echo "Using $NUM_CORES cores"

# Turn off the build cache and make sure we build all of LLVM from scratch.
export ANDROID_USE_BUILDCACHE=false
export FORCE_BUILD_LLVM_COMPONENTS=true

# Ensure that we have constructed the latest "bcc" for the host. Without
# this variable, we don't build the .so files, hence we never construct the
# actual required compiler pieces.
export FORCE_BUILD_RS_COMPAT=true

# ANDROID_HOST_OUT is where the new prebuilts will be constructed/copied from.
ANDROID_HOST_OUT=$MY_ANDROID_DIR/out/host/$SHORT_OSNAME-x86/

# HOST_LIB_DIR allows us to pick up the built librsrt_*.bc libraries.
HOST_LIB_DIR=$ANDROID_HOST_OUT/lib

# PREBUILTS_DIR is where we want to copy our new files to.
PREBUILTS_DIR=$MY_ANDROID_DIR/prebuilts/sdk/

print_usage() {
  echo "USAGE: $0 [-h|--help] [-n|--no-build] [-x]"
  echo "OPTIONS:"
  echo "    -h, --help     : Display this help message."
  echo "    -n, --no-build : Skip the build step and just copy files."
  echo "    -x             : Display commands before they are executed."
}

build_rs_libs() {
  echo Building for target $1
  lunch $1
  # Build the RS runtime libraries.
  cd $MY_ANDROID_DIR/frameworks/rs/driver/runtime && mma -j$NUM_CORES && cd - || exit 1
  # Build a sample support application to ensure that all the pieces are up to date.
  cd $MY_ANDROID_DIR/frameworks/rs/java/tests/RSTest_CompatLib/ && mma -j$NUM_CORES && cd - || exit 2

}

# Build everything by default
build_rs=1

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      print_usage
      exit 0
      ;;
    -n|--no-build)
      build_rs=0
      ;;
    -x)
      # set lets us enable bash -x mode.
      set -x
      ;;
    *)
      echo Unknown argument: "$1"
      print_usage
      exit 99
      break
      ;;
  esac
  shift
done

if [ $build_rs -eq 1 ]; then

  echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  echo !!! BUILDING RS PREBUILTS !!!
  echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  source build/envsetup.sh

  for t in ${TARGETS[@]}; do
    build_rs_libs aosp_${t}-userdebug
  done

  echo DONE BUILDING RS PREBUILTS

else

  echo SKIPPING BUILD OF RS PREBUILTS

fi

DATE=`date +%Y%m%d`

cd $PREBUILTS_DIR || exit 3
repo start pb_$DATE .

# Don't copy device prebuilts on Darwin. We don't need/use them.
if [ $DARWIN -eq 0 ]; then
  for i in $(seq 0 $((${#TARGETS[@]} - 1))); do
    t=${TARGETS[$i]}
    sys_lib_dir=$MY_ANDROID_DIR/out/target/product/${SYS_NAMES[$i]}/system/lib
    for a in `find renderscript/lib/$t -name \*.so`; do
      file=`basename $a`
      cp `find $sys_lib_dir -name $file` $a || exit 4
    done

    for a in `find renderscript/lib/$t -name \*.bc`; do
      file=`basename $a`
      cp `find $HOST_LIB_DIR $sys_lib_dir -name $file` $a || exit 5
    done
  done

  # javalib.jar
  cp $MY_ANDROID_DIR/out/target/common/obj/JAVA_LIBRARIES/android-support-v8-renderscript_intermediates/javalib.jar renderscript/lib

fi

# Copy header files for compilers
cp $MY_ANDROID_DIR/external/clang/lib/Headers/*.h renderscript/clang-include
cp $MY_ANDROID_DIR/frameworks/rs/scriptc/* renderscript/include


# Host-specific tools (bin/ and lib/)
TOOLS_BIN="
bcc_compat
llvm-rs-cc
"

TOOLS_LIB="
libbcc.$SONAME
libbcinfo.$SONAME
libclang.$SONAME
libLLVM.$SONAME
"

for a in $TOOLS_BIN; do
  cp $ANDROID_HOST_OUT/bin/$a tools/$SHORT_OSNAME/
  strip tools/$SHORT_OSNAME/$a
done

for a in $TOOLS_LIB; do
  cp $ANDROID_HOST_OUT/lib/$a tools/$SHORT_OSNAME/
  strip tools/$SHORT_OSNAME/$a
done

if [ $DARWIN -eq 0 ]; then
  echo "DON'T FORGET TO UPDATE THE DARWIN COMPILER PREBUILTS!!!"
fi
