#
# Copyright 2019 Android Open Source Project - Project Nemo
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

# Use the non-open-source parts, if they're present
-include vendor/Project_Nemo/Project_Nemo/BoardConfigVendor.mk

# config.mk
#
# Product-specific compile-time definitions.
#
TARGET_PREBUILT_KERNEL := device/Project_Nemo/Project_Nemo-kernel/kernel
# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
TARGET_CPU_ABI := x86
TARGET_ARCH := x86
TARGET_ARCH_VARIANT := x86
TARGET_PRELINK_MODULE := false


#emulator now uses 64bit kernel to run 32bit x86 image
#
TARGET_USES_64_BIT_BINDER := true

# The IA emulator (qemu) uses the Goldfish devices
HAVE_HTC_AUDIO_DRIVER := true
BOARD_USES_GENERIC_AUDIO := true

# no hardware camera
USE_CAMERA_STUB := true

# Enable dex-preoptimization to speed up the first boot sequence
# of an SDK AVD. Note that this operation only works on Linux for now
ifeq ($(HOST_OS),linux)
WITH_DEXPREOPT ?= true
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY ?= false
endif

TARGET_USES_HWC2 := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Build OpenGLES emulation host and guest libraries
BUILD_EMULATOR_OPENGL := true

# Build partitioned system.img and vendor.img (if applicable)
# for qemu, otherwise, init cannot find PART_NAME
BUILD_QEMU_IMAGES := true

# Build and enable the OpenGL ES View renderer. When running on the emulator,
# the GLES renderer disables itself if host GL acceleration isn't available.
USE_OPENGL_RENDERER := true


TARGET_COPY_OUT_VENDOR := vendor
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# mmc part
# :  type name      (size)
#1.  System         (3G)
#2.  Userdata       (4G)
#3.  Vendor         (900M)
#4.  Cache          (66M)

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 4294967296
BOARD_VENDORIMAGE_PARTITION_SIZE := 943718400
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016


BOARD_FLASH_BLOCK_SIZE := 512


# ~100 MB vendor image. Please adjust system image / vendor image sizes
# when finalizing them.

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
DEVICE_MATRIX_FILE   := device/generic/goldfish/compatibility_matrix.xml


PRODUCT_FULL_TREBLE_OVERRIDE := false

# Android generic system image always create metadata partition
BOARD_USES_METADATA_PARTITION := true

# Set this to create /cache mount point for non-A/B devices that mounts /cache.
# The partition size doesn't matter, just to make build pass.


#set the dalvik JIT cache size to zero for really low memory devices
#PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.jit.codecachesize=0


BOARD_SEPOLICY_DIRS += \
        device/Project_Nemo/Project_Nemo/sepolicy/common \
        device/Project_Nemo/Project_Nemo/sepolicy/x86

# Android Verified Boot (AVB):
#   Builds a special vbmeta.img that disables AVB verification.
#   Otherwise, AVB will prevent the device from booting the generic system.img.
#   Also checks that BOARD_AVB_ENABLE is not set, to prevent adding verity
#   metadata into system.img.
ifeq ($(BOARD_AVB_ENABLE),true)
$(error BOARD_AVB_ENABLE cannot be set for GSI)
endif
BOARD_BUILD_DISABLED_VBMETAIMAGE := true

ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
# GSI is always userdebug and needs a couple of properties taking precedence
# over those set by the vendor.
TARGET_SYSTEM_PROP := build/make/target/board/gsi_system.prop
endif
BOARD_VNDK_VERSION := current

# Enable A/B update
#TARGET_NO_RECOVERY := true
TARGET_NO_RECOVERY := false
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# Wifi.
BOARD_WLAN_DEVICE           := emulator
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_simulated
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_simulated
WPA_SUPPLICANT_VERSION      := VER_0_8_X
WIFI_DRIVER_FW_PATH_PARAM   := "/dev/null"
WIFI_DRIVER_FW_PATH_STA     := "/dev/null"
WIFI_DRIVER_FW_PATH_AP      := "/dev/null"
