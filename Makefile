#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=linux-optiga-trust-m
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/linux-optiga-trust-m
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Optiga Trust M CLI/lib/ENGINE
  DEPENDS:= +libopenssl +libpthread
  VERSION:=$(PKG_VERSION)-$(PKG_RELEASE)
endef

define Build/Configure
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) -r ./linux-optiga-trust-m/* $(PKG_BUILD_DIR)/
endef

define Package/linux-optiga-trust-m/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/simpleTest_Client $(1)/usr/sbin/	
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/simpleTest_Server $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_cert $(1)/usr/sbin/	
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_chipinfo $(1)/usr/sbin/	
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_data $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_ecc_keygen $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_ecc_sign $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_ecc_verify $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_errorcode $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_hkdf $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_hmac $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_hmac_verify_Auth $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_metadata $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_monotonic_counter $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_protected_update $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_protected_update_data $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_protected_update_aeskey $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_protected_update_ecckey $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_protected_update_rsakey $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_read_data $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_readmetadata_data $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_readmetadata_private $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_readmetadata_status $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_read_status $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_rsa_dec $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_rsa_enc $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_rsa_keygen $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_rsa_sign $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_rsa_verify $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_symmetric_dec $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_symmetric_enc $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_symmetric_keygen $(1)/usr/sbin/		

	$(INSTALL_DIR) $(1)/usr/lib/engines-1.1/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/trustm_engine.so $(1)/usr/lib/engines-1.1/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/libtrustm.so $(1)/usr/lib/	


endef

$(eval $(call BuildPackage,linux-optiga-trust-m))

