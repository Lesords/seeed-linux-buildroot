################################################################################
#
# hailort demo
#
################################################################################

HAILORT_DEMO_VERSION = main
HAILORT_DEMO_SITE = https://github.com/hailo-ai/Hailo-Application-Code-Examples.git
HAILORT_DEMO_SITE_METHOD = git
HAILORT_DEMO_GIT_SUBMODULES = YES
HAILORT_DEMO_LICENSE = MIT
HAILORT_DEMO_DEPENDENCIES = hailort-driver
HAILORT_DEMO_CONF_OPTS = \
	-DCMAKE_FIND_ROOT_PATH=$(STAGING_DIR) \
	-DCMAKE_C_COMPILER=$(TARGET_CC) \
	-DCMAKE_CXX_COMPILER=$(TARGET_CXX)

define HAILORT_DEMO_CONFIGURE_CMDS
	(cd $(@D)/runtime/hailo-8/cpp/classifier/; \
		./get_hef.sh; \
		$(TARGET_MAKE_ENV) $(HAILORT_DEMO_BUILD_ENV) $(BR2_CMAKE) -H. -Bbuild/ $(HAILORT_DEMO_CONF_OPTS); \
	)
endef

define HAILORT_DEMO_BUILD_CMDS
	(cd $(@D)/runtime/hailo-8/cpp/classifier/; \
		$(TARGET_MAKE_ENV) $(HAILORT_DEMO_BUILD_ENV) $(BR2_CMAKE) --build ./build/ -j$(PARALLEL_JOBS); \
	)
endef

define HAILORT_DEMO_INSTALL_TARGET_CMDS
	(cd $(@D)/runtime/hailo-8/cpp/classifier/; \
		cp -rf build/classifier $(TARGET_DIR)/mnt/ ; \
		cp -rf *.hef $(TARGET_DIR)/mnt/ ; \
		cp -rf *.jpg $(TARGET_DIR)/mnt/ ; \
	)
endef

$(eval $(cmake-package))
