#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

# Initialize ROM manifest
repo init -u https://github.com/EverestOS-AOSP/manifest -b 15 --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove frameworks/native
# rm -rf frameworks/native

# cloning device tree
git clone https://github.com/K4LCHAKRA/android_device_xiaomi_mojito.git --depth 1 -b 15 device/xiaomi/mojito
git clone https://github.com/K4LCHAKRA/android_device_xiaomi_sm6150-common.git --depth 1 -b 15 device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/ProjectEverest-Devices/android_kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_mojito.git --depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/ProjectEverest-Devices/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

# source patch
# git clone https://github.com/everestos-mojito/frameworks_native.git --depth 1 -b 14 frameworks/native

# signing key for everestos
# git clone https://github.com/mojito-keys/vendor_lineage_signing.git --depth 1 -b main vendor/lineage

# Set up the build environment
. build/envsetup.sh

# Choose the target device
lunch everest_mojito-ap3a-userdebug

# Build the ROM (use mka bacon for a full build)
mka everest -j$(nproc --all)
