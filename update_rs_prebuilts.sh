#!/bin/bash

# We are currently in frameworks/rs, so compute our top-level directory.
MY_ANDROID_DIR=$PWD/../../
cd $MY_ANDROID_DIR

print_usage() {
  echo USAGE: $0 [-n]
}

build_from_scratch=1
if [ $# -gt 0 ]; then
  if [ $1 == "-n" ]; then
    build_from_scratch=0
  elif [ $1 == "-h" ]; then
    print_usage
    exit 0
  else
    echo Unknown argument: "$1"
    print_usage
  fi
fi

if [ $build_from_scratch -eq 1 ]; then

echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !!! BUILDING RS PREBUILTS FROM SCRATCH !!!
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

source build/envsetup.sh

lunch aosp_arm-userdebug
cd $MY_ANDROID_DIR/frameworks/rs/java/tests/RSTest_CompatLib/ && mma -j32 && cd - || exit 1

lunch aosp_x86-userdebug
cd $MY_ANDROID_DIR/frameworks/rs/java/tests/RSTest_CompatLib/ && mma -j32 && cd - || exit 2

lunch aosp_mips-userdebug
cd $MY_ANDROID_DIR/frameworks/rs/java/tests/RSTest_CompatLib/ && mma -j32 && cd - || exit 3

else

echo SKIPPING BUILD OF RS PREBUILTS FROM SCRATCH

fi

ARM_SYS_LIB_DIR=$MY_ANDROID_DIR/out/target/product/generic/system/lib
X86_SYS_LIB_DIR=$MY_ANDROID_DIR/out/target/product/generic_x86/system/lib
MIPS_SYS_LIB_DIR=$MY_ANDROID_DIR/out/target/product/generic_mips/system/lib

PREBUILTS_DIR=$MY_ANDROID_DIR/prebuilts/sdk/
DATE=`date +%Y%m%d`

cd $PREBUILTS_DIR || exit 4
repo start pb_$DATE .

# arm
for a in `find renderscript/lib/arm -name \*.so`; do
    file=`basename $a`
    cp `find $ARM_SYS_LIB_DIR -name $file` $a
done

for a in `find renderscript/lib/arm -name \*.bc`; do
    file=`basename $a`
    cp `find $ARM_SYS_LIB_DIR -name $file` $a
done

# x86
for a in `find renderscript/lib/x86 -name \*.so`; do
    file=`basename $a`
    cp `find $X86_SYS_LIB_DIR -name $file` $a
done

for a in `find renderscript/lib/x86 -name \*.bc`; do
    file=`basename $a`
    cp `find $X86_SYS_LIB_DIR -name $file` $a
done

# mips
for a in `find renderscript/lib/mips -name \*.so`; do
    file=`basename $a`
    cp `find $MIPS_SYS_LIB_DIR -name $file` $a
done

for a in `find renderscript/lib/mips -name \*.bc`; do
    file=`basename $a`
    cp `find $MIPS_SYS_LIB_DIR -name $file` $a
done

# general
# javalib.jar
cp $MY_ANDROID_DIR/out/target/common/obj/JAVA_LIBRARIES/android-support-v8-renderscript_intermediates/javalib.jar renderscript/lib

cp $MY_ANDROID_DIR/external/clang/lib/Headers/*.h renderscript/clang-include
cp $MY_ANDROID_DIR/frameworks/rs/scriptc/* renderscript/include


# Linux-specific tools (bin/ and lib/)
TOOLS_BIN="
bcc_compat
llvm-rs-cc
"

TOOLS_LIB="
libbcc.so
libbcinfo.so
libclang.so
libLLVM.so
"

ANDROID_HOST_OUT=$MY_ANDROID_DIR/out/host/linux-x86/
for a in $TOOLS_BIN; do
    cp $ANDROID_HOST_OUT/bin/$a tools/linux/
    strip tools/linux/$a
done

for a in $TOOLS_LIB; do
    cp $ANDROID_HOST_OUT/lib/$a tools/linux/
    strip tools/linux/$a
done
