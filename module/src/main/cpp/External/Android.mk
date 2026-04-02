LOCAL_PATH := $(call my-dir)
EXT_PATH := $(LOCAL_PATH)

# libimgui.a
include $(CLEAR_VARS)
LOCAL_PATH := $(EXT_PATH)
LOCAL_MODULE := libimgui
LOCAL_C_INCLUDES := $(EXT_PATH)/ImGui
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := ImGui/backends/imgui_impl_opengl3.cpp \
                   ImGui/backends/imgui_impl_android.cpp \
                   ImGui/imgui.cpp \
                   ImGui/imgui_demo.cpp \
                   ImGui/imgui_draw.cpp \
                   ImGui/imgui_tables.cpp \
                   ImGui/imgui_widgets.cpp \

include $(BUILD_STATIC_LIBRARY)

# libkitty.a
include $(CLEAR_VARS)
LOCAL_PATH := $(EXT_PATH)
LOCAL_MODULE := libkitty
LOCAL_C_INCLUDES := $(EXT_PATH)/KittyMemory
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := KittyMemory/KittyMemory.cpp \
                   KittyMemory/MemoryPatch.cpp \
                   KittyMemory/MemoryBackup.cpp \
                   KittyMemory/KittyUtils.cpp \

include $(BUILD_STATIC_LIBRARY)

# libdobby.a
include $(CLEAR_VARS)
LOCAL_PATH := $(EXT_PATH)
LOCAL_MODULE := libdobby
LOCAL_C_INCLUDES := $(EXT_PATH)/Dobby
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := Dobby/libs/$(TARGET_ARCH_ABI)/libdobby.a

include $(PREBUILT_STATIC_LIBRARY)

# libmodmenu.so (zygisk module - renamed to arm64-v8a.so by gradle)
include $(CLEAR_VARS)
LOCAL_PATH := $(EXT_PATH)/..
LOCAL_MODULE := modmenu
LOCAL_CPP_FEATURES := exceptions
LOCAL_CPPFLAGS := -std=c++17 -O2 -fvisibility=hidden -ffunction-sections -fdata-sections
LOCAL_LDFLAGS := -Wl,--gc-sections
LOCAL_C_INCLUDES := \
    $(EXT_PATH)/../Headers \
    $(EXT_PATH)/../Include \
    $(EXT_PATH)/ImGui \
    $(EXT_PATH)/ImGui/backends \
    $(EXT_PATH)/Dobby \
    $(EXT_PATH)/KittyMemory
LOCAL_SRC_FILES := \
    Main.cpp \
    Drawing.cpp \
    ModMenu.cpp \
    Utility.cpp
LOCAL_STATIC_LIBRARIES := libimgui libkitty libdobby
LOCAL_LDLIBS := -llog -landroid -lEGL -lGLESv3
include $(BUILD_SHARED_LIBRARY)
