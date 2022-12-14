include vendor/awaken/build/core/vendor/*.mk
include vendor/awaken/config/gsm.mk

# Inherit from textclassifier config
$(call inherit-product, vendor/awaken/config/textclassifier.mk)

ifeq ($(USE_GAPPS),true)
$(call inherit-product, vendor/gapps/gapps.mk)
endif

ifeq ($(TARGET_SUPPORTS_UPDATABLE_APEX),true)
$(call inherit-product, vendor/prebuilts/config/apex.mk)
endif

ifeq ($(PRODUCT_USES_QCOM_HARDWARE), true)
include vendor/awaken/build/core/ProductConfigQcom.mk
endif

$(call inherit-product, vendor/qcom/opensource/power/power-vendor-board.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

# IORap app launch prefetching using Perfetto traces and madvise
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/awaken/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/awaken/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/awaken/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# copy privapp permissions
PRODUCT_COPY_FILES += \
    vendor/awaken/prebuilt/common/etc/permissions/privapp-permissions-awaken-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-awaken-product.xml \
    vendor/awaken/prebuilt/common/etc/permissions/privapp-permissions-awaken-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-awaken-system.xml

# Livedisplay
PRODUCT_COPY_FILES += \
    vendor/awaken/prebuilt/common/etc/permissions/privapp-permissions-lineagehw.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-lineagehw.xml

# backuptool
PRODUCT_COPY_FILES += \
    vendor/awaken/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/awaken/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/awaken/prebuilt/common/bin/50-lineage.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-lineage.sh

# Awaken-specific init file
PRODUCT_COPY_FILES += \
    vendor/awaken/prebuilt/common/etc/init.awaken.rc:system/etc/init/init.awaken.rc

# Copy all AOSiP-specific init rc files
$(foreach f,$(wildcard vendor/awaken/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Build ID
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_DISPLAY_ID="$(BUILD_ID)-$(TARGET_BUILD_VARIANT)"

# Packages
include vendor/awaken/config/packages.mk

# Branding
include vendor/awaken/config/branding.mk

# Sounds
include vendor/awaken/config/pixel2-audio_prebuilt.mk

# Bootanimation
include vendor/awaken/config/bootanimation.mk

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Fonts
include vendor/awaken/config/fonts.mk

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/awaken/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/awaken/overlay/common
