#
# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifndef BCC_RS_TRIPLE
BCC_RS_TRIPLE := $($(LOCAL_2ND_ARCH_VAR_PREFIX)RS_TRIPLE)
endif

# Set these values always by default
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES

include $(BUILD_SYSTEM)/base_rules.mk

BCC_STRIP_ATTR := $(BUILD_OUT_EXECUTABLES)/bcc_strip_attr$(BUILD_EXECUTABLE_SUFFIX)

bc_clang_cc1_cflags :=
ifeq ($(BCC_RS_TRIPLE),armv7-none-linux-gnueabi)
# We need to pass the +long64 flag to the underlying version of Clang, since
# we are generating a library for use with Renderscript (64-bit long type,
# not 32-bit).
bc_clang_cc1_cflags += -target-feature +long64
endif
bc_translated_clang_cc1_cflags := $(addprefix -Xclang , $(bc_clang_cc1_cflags))

bc_cflags := -MD \
             -DRS_VERSION=$(RS_VERSION) \
             -std=c99 \
             -c \
             -O3 \
             -fno-builtin \
             -emit-llvm \
             -target $(BCC_RS_TRIPLE) \
             -fsigned-char \
             $(LOCAL_CFLAGS) \
             $(bc_translated_clang_cc1_cflags)

ifeq ($(rs_debug_runtime),1)
    bc_cflags += -DRS_DEBUG_RUNTIME
endif
rs_debug_runtime:=

c_sources := $(filter %.c,$(LOCAL_SRC_FILES))
ll_sources := $(filter %.ll,$(LOCAL_SRC_FILES))

c_bc_files := $(patsubst %.c,%.bc, \
    $(addprefix $(intermediates)/, $(c_sources)))

ll_bc_files := $(patsubst %.ll,%.bc, \
    $(addprefix $(intermediates)/, $(ll_sources)))

$(c_bc_files): PRIVATE_INCLUDES := \
    frameworks/rs/scriptc \
    external/clang/lib/Headers
$(c_bc_files): PRIVATE_CFLAGS := $(bc_cflags)

$(c_bc_files): $(intermediates)/%.bc: $(LOCAL_PATH)/%.c  $(CLANG)
	@echo "bc: $(PRIVATE_MODULE) <= $<"
	@mkdir -p $(dir $@)
	$(hide) $(CLANG) $(addprefix -I, $(PRIVATE_INCLUDES)) $(PRIVATE_CFLAGS) $< -o $@

$(ll_bc_files): $(intermediates)/%.bc: $(LOCAL_PATH)/%.ll $(LLVM_AS)
	@mkdir -p $(dir $@)
	$(hide) $(LLVM_AS) $< -o $@

-include $(c_bc_files:%.bc=%.d)
-include $(ll_bc_files:%.bc=%.d)

$(LOCAL_BUILT_MODULE): PRIVATE_BC_FILES := $(c_bc_files) $(ll_bc_files)
$(LOCAL_BUILT_MODULE): $(c_bc_files) $(ll_bc_files)
$(LOCAL_BUILT_MODULE): $(LLVM_LINK) $(clcore_LLVM_LD)
$(LOCAL_BUILT_MODULE): $(LLVM_AS) $(BCC_STRIP_ATTR)
	@echo "bc lib: $(PRIVATE_MODULE) ($@)"
	@mkdir -p $(dir $@)
	$(hide) $(LLVM_LINK) $(PRIVATE_BC_FILES) -o $@.unstripped
	$(hide) $(BCC_STRIP_ATTR) -o $@ $@.unstripped

BCC_RS_TRIPLE :=
