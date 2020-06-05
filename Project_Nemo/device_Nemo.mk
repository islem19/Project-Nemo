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
BUILD_WITH_GAPPS := true


PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi

PRODUCT_HARDWARE := ranchu

# DEVICE_PACKAGE_OVERLAYS for the device should be before
# including common overlays since the one listed first
# takes precedence.
ifdef DEVICE_PACKAGE_OVERLAYS
$(warning Overlays defined in '$(DEVICE_PACKAGE_OVERLAYS)' will override '$(PRODUCT_HARDWARE)' overlays)
endif
DEVICE_PACKAGE_OVERLAYS += device/Project_Nemo/Project_Nemo/overlay

include device/Project_Nemo/Project_Nemo/device_common.mk


TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=420

#init device file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.ranchu.rc:root/init.ranchu.rc

#copy the userinit script to system
PRODUCT_COPY_FILES += \
		$(LOCAL_PATH)/userinit.sh:/system/bin/userinit.sh