# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
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

# -----------------------------------------------------------------
# Project Elixir OTA update package

CUSTOM_TARGET_PACKAGE := $(PRODUCT_OUT)/$(CUSTOM_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum
MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: bacon
bacon: $(DEFAULT_GOAL) $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CUSTOM_TARGET_PACKAGE)
	$(hide) $(SHA256) $(CUSTOM_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CUSTOM_TARGET_PACKAGE).sha256sum
	$(hide) $(MD5) $(CUSTOM_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CUSTOM_TARGET_PACKAGE).md5sum
	$(hide) python3 ./vendor/lineage/build/tools/createJson.py $(TARGET_DEVICE) $(ELIXIR_BUILD_TYPE) $(PRODUCT_OUT) $(CUSTOM_VERSION).zip
	@echo -e ${CL_CYN}""${CL_CYN}
	@echo -e ${CL_CYN}"      ____            _           _        "${CL_CYN}
	@echo -e ${CL_CYN}"     |  _ \ _ __ ___ (_) ___  ___| |_      "${CL_CYN}
	@echo -e ${CL_CYN}"     | |_) | '__/ _ \| |/ _ \/ __| __|     "${CL_CYN}
	@echo -e ${CL_CYN}"     |  __/| | | (_) | |  __/ (__| |_      "${CL_CYN}
	@echo -e ${CL_CYN}"     |_|   |_|  \___// |\___|\___|\__|     "${CL_CYN}
	@echo -e ${CL_CYN}"     |_|            |_/                    "${CL_CYN}
	@echo -e ${CL_CYN}"                                           "${CL_CYN}
	@echo -e ${CL_CYN}"            _____ _ _     _                "${CL_CYN}
	@echo -e ${CL_CYN}"           | ____| (_)_ _(_)_ __           "${CL_CYN}
	@echo -e ${CL_CYN}"           |  _| | | \ \/ / | '__|         "${CL_CYN}
	@echo -e ${CL_CYN}"           | |___| | |>  <| | |            "${CL_CYN}
	@echo -e ${CL_CYN}"           |_____|_|_/_/\_\_|_|            "${CL_CYN}
	@echo -e ${CL_CYN}"                                           "${CL_CYN}
	@echo -e ${CL_CYN}""${CL_CYN}
	@echo -e ${CL_CYN}"===========-Package Completed-==========="${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Zip: "${CL_YLW} $(CUSTOM_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"MD5: "${CL_YLW}" `cat $(CUSTOM_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1` "${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"SHA256: "${CL_YLW}" `sha256sum $(CUSTOM_TARGET_PACKAGE) | cut -d ' ' -f 1` "${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Size: "${CL_YLW}" `ls -l $(CUSTOM_TARGET_PACKAGE) | cut -d ' ' -f 5` "${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Timestamp: "${CL_MAG} $(CUSTOM_BUILD_DATE_UTC) ${CL_RST}
	@echo -e ${CL_CYN}"===========-----Thanks Sir:)-----==========="${CL_RST}
	@echo -e ""
