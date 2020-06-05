include $(call all-makefiles-under)
LOCAL_PATH := device/Project_Nemo/Project_Nemo/prebuilt/common/apps/Wellbeing

PRODUCT_COPY_FILES := \
	$(LOCAL_PATH)/etc/permissions/privapp-permissions-wellbeing.xml:system/etc/permissions/privapp-permissions-wellbeing.xml \
	$(LOCAL_PATH)/etc/sysconfig/wellbeing-enabler.xml:system/etc/sysconfig/wellbeing-enabler.xml

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,device/Project_Nemo/Project_Nemo/prebuilt/common/apps/Wellbeing/priv-app/DigitalWellbeing/lib,system/priv-app/DigitalWellbeing/lib)
