PRODUCT_PACKAGES += \
    libigdrcl \
    libOpenCL \
    libopencl-clang \
    libigc \
    libigdfcl \
    clinfo \

#Gallium drivers since mesa 22.0.3
PRODUCT_PACKAGES += \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi
#Vulkan driver since mesa 22.0.3
PRODUCT_PACKAGES += \
    vulkan.intel

#mesa perfetto gpu counter data producer
PRODUCT_PACKAGES += \
    libgpudataproducer \
    gpudataproducer

PRODUCT_PACKAGES += \
    libdrm \
    libdrm_intel \
    libsync
#   libmd
#Epic mdapi was deprecated for TGL and ADL platform
#So disable libmd and leave mdapi compiling issue with mesa 22.0.3

PRODUCT_PACKAGES += \
    gralloc.default

#Surface Flinger related Properties

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.max_frame_buffer_acquired_buffers=3

# System's VSYNC phase offsets in nanoseconds
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.vsync_event_phase_offset_ns=7500000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.vsync_sf_event_phase_offset_ns=3000000

# i915 firmwares
$(foreach fw,$(I915_FW),$(eval PRODUCT_PACKAGES += $(notdir $(fw))))

# move configure files provided by intel to vendor partition
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/drirc:vendor/etc/drirc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/intel.icd:vendor/Khronos/OpenCL/vendors/intel.icd

PRODUCT_COPY_FILES += \
    vendor/intel/hardware/interfaces/graphic/dgpu-renderwlocal.cfg:vendor/etc/dgpu-renderwlocal.cfg

# virtio-gpu backend
PRODUCT_PACKAGES += \
    libacrn_dm_backend \
    DmBackendApp \
    acrn-bkend-server \
    dm-backend \
    libCastFrontClientJni \
    ScreenCastClient \
    open-node \
    probe-node

# DRM HWComposer
PRODUCT_PACKAGES += \
    hwcomposer.drm_minigbm

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.hwcomposer=drm_minigbm

{{#minigbm}}
# Mini gbm
PRODUCT_PACKAGES += \
    gralloc.$(TARGET_GFX_INTEL) \
    mapper.minigbm \
    libminigbm_gralloc_intel

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=$(TARGET_GFX_INTEL)
{{/minigbm}}

{{^minigbm}}

#Gralloc
PRODUCT_PACKAGES += \
    gralloc.drm
{{/minigbm}}

{{#gen9+}}
# Mesa
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:vendor/etc/permissions/android.hardware.opengles.aep.xml

# GLES version
PRODUCT_PROPERTY_OVERRIDES += \
   ro.opengles.version=196610

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2023-03-01.xml:vendor/etc/permissions/android.software.opengles.deqp.level.xml

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:vendor/etc/permissions/android.hardware.vulkan.level.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:vendor/etc/permissions/android.hardware.vulkan.compute.xml
{{/vulkan}}

{{/gen9+}}

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_3.xml:vendor/etc/permissions/android.hardware.vulkan.version.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2023-03-01.xml:vendor/etc/permissions/android.software.vulkan.deqp.level.xml

PRODUCT_PACKAGES += \
    vulkan.pastel
{{/vulkan}}

PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle

