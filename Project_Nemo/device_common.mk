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
ifeq ($(BUILD_WITH_GAPPS),true)
include device/Project_Nemo/Project_Nemo/gapps_pie/config.mk
endif

LOCAL_PATH := device/Project_Nemo/Project_Nemo

#Android Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/Project_Nemo/Project_Nemo-kernel/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

#device doesn't require sim
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

#enable RSA Authentication using ADB
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.adb.secure=1

# OEM Unlock reporting
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.oem_unlock_supported=1

#copy the kernel
PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel

#bootanimation
PRODUCT_COPY_FILES += \
		$(LOCAL_PATH)/media/bootanimation_android.zip:system/media/bootanimation.zip \

$(call inherit-product-if-exists, vendor/Project_Nemo/Project_Nemo/device-vendor.mk)
