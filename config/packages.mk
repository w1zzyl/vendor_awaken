# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Extra tools
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    getcap \
    e2fsck \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    nano \
    openvpn \
    oprofiled \
    pigz \
    powertop \
    setcap \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs

# rsync
PRODUCT_PACKAGES += \
    rsync

# Awaken Packages
PRODUCT_PACKAGES += \
    Launcher3QuickStep \
    CustomDoze \
    GamingMode \
    StitchImage \
    ThemePicker \
    MatchmakerPrebuilt \
    WallpaperPickerGoogle \
    OmniJaws \
    WeatherIcons \
    TouchGestures \
    QuickAccessWallet \
    SimpleDeviceConfig

ifeq ($(AWAKEN_BUILD_TYPE),OFFICIAL)
ifeq ($(USE_GAPPS),true)
PRODUCT_PACKAGES += \
    Updater
endif
endif

ifeq ($(BUILD_LIVEWALLPAPERS),true)
PRODUCT_PACKAGES += \
    PixelLiveWallpaperPrebuilt
endif

# Custom Overlays
# Settings
PRODUCT_PACKAGES += \
    SystemRavenBlackOverlay \
    SystemUIRavenBlackOverlay \
    SystemDarkGrayOverlay \
    SystemUIDarkGrayOverlay \
    SystemStyleOverlay \
    SystemUIStyleOverlay \
    SystemNightOverlay \
    SystemUINightOverlay \
    SystemAwakenClearOverlay \
    SystemUIAwakenClearOverlay \
    SystemMaterialOceanOverlay \
    SystemUIMaterialOceanOverlay

# QS tile styles
PRODUCT_PACKAGES += \
    QStileCircleTrim \
    QStileDefault \
    QStileDualToneCircle \
    QStileSquircleTrim \
    QStileAttemptMountain \
    QStileDottedCircle \
    QStileNinja \
    QStilePokesign \
    QStileWavey \
    QStileCookie \
    QStileInkDrop \
    QStileSquaremedo \
    QStileCosmos \
    QStileDividedCircle \
    QStileNeonLight \
    QStileOxygen \
    QStileTriangles \
    QStileCircleOutline

# Local Updater
ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_PACKAGES += \
    LocalUpdater
endif

PRODUCT_PACKAGES += \
     AwakenOverlayStub

# Charger images
PRODUCT_PACKAGES += \
    charger_res_images

-include vendor/awaken/config/overlay.mk

# Google icons mess
PRODUCT_PACKAGES += \
    wellbeingconf \
    googleconf

-include packages/apps/Plugins/plugins.mk

# Include Xtended Switch Styles
include vendor/awaken/switch/switch.mk
