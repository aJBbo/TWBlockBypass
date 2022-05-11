FINALPACKAGE = 1
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TWBlockBypass

TWBlockBypass_FILES = Tweak.xm
TWBlockBypass_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
