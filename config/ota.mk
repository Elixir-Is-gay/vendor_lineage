# Elixir Updater
PRODUCT_PACKAGES += \
    Updates

# Copy all custom init rc files
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init/init.elixir-updater.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.elixir-updater.rc
