# Inherit common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_mobile.mk)

PRODUCT_SIZE := full

# Apps
ifeq ($(TARGET_BUILD_LOS_APPS),true)
PRODUCT_PACKAGES += \
    Camelot \
    Profiles \
    Seedvault
endif

ifeq ($(TARGET_BUILD_APERTURE_CAMERA),true)
PRODUCT_PACKAGES += \
    Aperture
endif

ifeq ($(TARGET_INCLUDE_AUDIOFX),true)
PRODUCT_PACKAGES += \
    AudioFX
endif

# Extra cmdline tools
PRODUCT_PACKAGES += \
    unrar \
    zstd

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/lineage/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/lineage/overlay/dictionaries
