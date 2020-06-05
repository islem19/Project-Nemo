#
# Copyright 2014 The Android Open-Source Project
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
-include device/generic/goldfish/x86-vendor.mk

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_x86.mk)
$(call inherit-product, device/Project_Nemo/Project_Nemo/device_Nemo.mk)
$(call inherit-product, device/Project_Nemo/Project_Nemo/prebuilt/common/apps/Wellbeing/wellbeing.mk)

-include device/Project_Nemo/Project_Nemo/versions.mk

#Google Wellbeing App
PRODUCT_PACKAGES += DigitalWellbeing

#theme for Dialer App
PRODUCT_PACKAGES += DialerThemeChocolate

#theme for System App
PRODUCT_PACKAGES += SystemChocolateTheme

#themes for QS (quick settings)
PRODUCT_PACKAGES += QStilesTearDropOverlay QStilesSquircleOverlay QStilesSquareOverlay

#theme accent for system
PRODUCT_PACKAGES += SystemGreenAccentOverlay SystemRedAccentOverlay SystemBlueAccentOverlay

#theme for DocumentUI App
PRODUCT_PACKAGES += DocumentsUIDark

PRODUCT_NAME := full_Project_Nemo
PRODUCT_DEVICE := Project_Nemo
PRODUCT_BRAND := Android
PRODUCT_MODEL := Project_Nemo
PRODUCT_MANUFACTURER := Project_Nemo
