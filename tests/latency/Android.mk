LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SDK_VERSION := 8
LOCAL_NDK_STL_VARIANT := stlport_static

LOCAL_SRC_FILES:= \
	latency.rs \
	latency.cpp

LOCAL_STATIC_LIBRARIES := \
	libRScpp_static \
	libstlport_static

LOCAL_LDFLAGS += -llog -ldl

LOCAL_MODULE:= rstest-latency

LOCAL_MODULE_TAGS := tests

intermediates := $(call intermediates-dir-for,STATIC_LIBRARIES,libRS,TARGET,)

LOCAL_C_INCLUDES += frameworks/rs/cpp
LOCAL_C_INCLUDES += frameworks/rs
LOCAL_C_INCLUDES += $(intermediates)

LOCAL_CLANG := true

include $(BUILD_EXECUTABLE)

