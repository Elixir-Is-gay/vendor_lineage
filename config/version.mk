ELIXIR_BUILD_TYPE ?= UNOFFICIAL

# ELIXIR Version
ELIXIR_BASE_VERSION = 5.1

CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE)' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

CUSTOM_VERSION := ProjectElixir_$(ELIXIR_BASE_VERSION)_$(LINEAGE_BUILD)-$(PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)-$(ELIXIR_BUILD_TYPE)
CUSTOM_VERSION_PROP := fifteen
ELIXIR_MAINTAINER ?= Elixir-Devs

ifeq ($(ELIXIR_BUILD_TYPE), OFFICIAL)
PRODUCT_DEFAULT_DEV_CERTIFICATE := build/target/product/security/releasekey
# OTA
$(call inherit-product, vendor/lineage/config/ota.mk)
endif

LINEAGE_VERSION := 22.1

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.lineage.version=$(LINEAGE_VERSION) \
    ro.lineage.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.lineage.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.lineage.releasetype=$(LINEAGE_BUILDTYPE)

# Versioning props
PRODUCT_SYSTEM_PROPERTIES  += \
    org.elixir.device=$(LINEAGE_BUILD) \
    org.elixir.version=$(ELIXIR_BASE_VERSION) \
    org.elixir.version.display=$(CUSTOM_VERSION) \
    org.elixir.build_date=$(CUSTOM_BUILD_DATE) \
    org.elixir.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    ro.elixir.maintainer=$(ELIXIR_MAINTAINER) \
    ro.elixir.ota_device=$(LINEAGE_BUILD) \
    org.elixir.build_type=$(ELIXIR_BUILD_TYPE)
