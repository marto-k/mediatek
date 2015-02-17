TZ_PLATFORM := $(call lc,$(MTK_PLATFORM)) 

ifeq ($(strip $(TARGET_ARCH_VARIANT)),armv7-a-neon)
TZ_ARCH := armv7-a
TZ_CFLAG := -mcpu=cortex-a9 -mfloat-abi=soft
endif

ENABLE_THUMB?=true
THUMBCFLAGS :=
THUMBINTERWORK :=
ifeq ($(ENABLE_THUMB),true)
THUMBCFLAGS := -mthumb -Wa,-mimplicit-it=thumb -D__thumb__
THUMBINTERWORK := -mthumb-interwork
endif

TZ_C_INCLUDES := \
	$(call include-path-for, trustzone) \
	$(call include-path-for, trustzone)/libc/include

TZ_CFLAG += ${THUMBCFLAGS} ${THUMBINTERWORK}
TZ_CFLAG += -O2 -g -fno-builtin -finline -Wall -Wno-unused-parameter \
	-ffunction-sections -fdata-sections -mno-android
TZ_CFLAG += -Werror
TZ_CFLAG += -D__TRUSTZONE_TEE__

# For C lib, should be project dependent
TZ_CFLAG += -DARM_CPU_CORTEX_A7 -DARCH_ARM

ifneq ($(TARGET_BUILD_VARIANT),eng)
TZ_CFLAG += -DUSER_BUILD
endif

# add MTK feature options
TZ_CFLAG += $(MTK_CDEFS)

#TZ_CFLAG += -DOPENSSL_BN_ASM_MONT \
-DAES_ASM \
-DSHA1_ASM \
-DSHA256_ASM \
-DSHA512_ASM \
-DOPENSSL_NO_STDIO \
-DOPENSSL_NO_FP_API \
-DNO_WINDOWS_BRAINDEATH \
-DOPENSSL_IMPLEMENTS_strncasecmp \
-DOPENSSL_NO_DSA \
-DOPENSSL_NO_DH \
-DGETPID_IS_MEANINGLESS \
-DOPENSSL_NO_EC \
-DOPENSSL_NO_DES \
-DOPENSSL_THREADS \
-D_REENTRANT \
-DDSO_DLFCN \
-DHAVE_DLFCN_H \
-DL_ENDIAN \
-DOPENSSL_NO_CAMELLIA \
-DOPENSSL_NO_CAPIENG \
-DOPENSSL_NO_CAST \
-DOPENSSL_NO_CMS \
-DOPENSSL_NO_GMP \
-DOPENSSL_NO_IDEA \
-DOPENSSL_NO_JPAKE \
-DOPENSSL_NO_MD2 \
-DOPENSSL_NO_MDC2 \
-DOPENSSL_NO_RC5 \
-DOPENSSL_NO_SHA0 \
-DOPENSSL_NO_RFC3779 \
-DOPENSSL_NO_SEED \
-DOPENSSL_NO_STORE \
-DOPENSSL_NO_WHIRLPOOL \
-DOPENSSL_NO_HW \
-DOPENSSL_NO_ENGINE \
-DZLIB \
-DLK_NO_TIME \
-DLK_NO_QSORT \
-DLK_NO_BIO \
-DLK_NO_HMAC \
-DLK_NO_ENCODE \
-DLK_NO_STDERR \
-DLK_NO_ABORT \
-DLK_NO_PEM \
-DLK_NO_OAEP \
-DLK_NO_SSLV23 \
-DLK_NO_RAND \
-DLK_NO_UNISTD \
-DLK_NO_ERR_STATE \
-DOPENSSL_LK \

